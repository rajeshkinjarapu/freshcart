const { onCall, HttpsError } = require('firebase-functions/v2/https');
const { onDocumentCreated } = require('firebase-functions/v2/firestore');
const admin = require('firebase-admin');
admin.initializeApp();
const db = admin.firestore();
const money = (n) => Math.round(Number(n) * 100) / 100;

exports.updateCart = onCall(async (request) => {
  if (!request.auth) throw new HttpsError('unauthenticated', 'Sign in required');
  const items = Array.isArray(request.data.items) ? request.data.items : [];
  if (items.some(i => !i.productId || !Number.isInteger(i.quantity) || i.quantity < 1)) throw new HttpsError('invalid-argument', 'Invalid cart item');
  await db.doc(`cart/${request.auth.uid}`).set({ userId: request.auth.uid, items, updatedAt: admin.firestore.FieldValue.serverTimestamp() });
  return { ok: true };
});

exports.validateCoupon = onCall(async (request) => {
  if (!request.auth) throw new HttpsError('unauthenticated', 'Sign in required');
  const code = String(request.data.code || '').trim().toUpperCase(); const subtotal = Number(request.data.subtotal || 0);
  const snap = await db.doc(`coupons/${code}`).get(); const c = snap.data();
  if (!snap.exists || !c.isActive || subtotal < Number(c.minOrderValue || 0) || (c.validTill && c.validTill.toDate() < new Date())) throw new HttpsError('failed-precondition', 'Coupon is invalid or expired');
  let discount = c.discountType === 'percent' ? subtotal * Number(c.discountValue) / 100 : Number(c.discountValue); discount = Math.min(discount, Number(c.maxDiscount || discount), subtotal);
  return { code, discount: money(discount) };
});

exports.placeOrder = onCall(async (request) => {
  if (!request.auth) throw new HttpsError('unauthenticated', 'Sign in required');
  const uid = request.auth.uid; const data = request.data; const items = Array.isArray(data.items) ? data.items : [];
  if (!items.length || !data.deliveryAddress) throw new HttpsError('invalid-argument', 'Items and address are required');
  const ref = db.collection('orders').doc();
  await db.runTransaction(async tx => {
    let subtotal = 0; const checked = [];
    for (const item of items) { const pRef = db.doc(`products/${item.productId}`); const p = (await tx.get(pRef)).data(); if (!p || !p.isAvailable || Number(p.stockQuantity) < item.quantity) throw new HttpsError('failed-precondition', `${item.name || 'Product'} is unavailable`); const price = Number(p.discountPrice ?? p.price); subtotal += price * item.quantity; checked.push({...item, price}); tx.update(pRef, {stockQuantity: admin.firestore.FieldValue.increment(-item.quantity)}); }
    const deliveryCharge = subtotal >= 499 ? 0 : 40; const discount = Math.min(Number(data.discount || 0), subtotal); tx.set(ref, {orderId: ref.id, userId: uid, items: checked, totalAmount: money(subtotal), deliveryCharge, discount, grandTotal: money(subtotal + deliveryCharge - discount), couponCode: data.couponCode || null, paymentMethod: data.paymentMethod || 'cod', status: 'placed', deliveryAddress: data.deliveryAddress, createdAt: admin.firestore.FieldValue.serverTimestamp(), estimatedDelivery: admin.firestore.Timestamp.fromDate(new Date(Date.now() + 45 * 60 * 1000))});
  });
  await db.doc(`cart/${uid}`).delete().catch(() => {}); return { orderId: ref.id };
});

exports.notifyNewOrder = onDocumentCreated('orders/{orderId}', async (event) => { const order = event.data.data(); const user = await admin.auth().getUser(order.userId); if (!user) return; return null; });

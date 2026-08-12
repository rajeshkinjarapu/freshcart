# Firestore schema

Collections used by FreshCart:

```text
users/{uid}
  uid, name, phone, email, addresses[], createdAt
users/{uid}/addresses/{addressId}
  label, flat, area, landmark, pincode, lat, lng, createdAt
categories/{id}
  name, imageUrl, priority
products/{id}
  name, categoryId, brand, description, images[], price, discountPrice,
  unit, stockQuantity, avgRating, isAvailable, createdAt
cart/{uid}
  userId, items[{productId,name,image,price,quantity,unit}], updatedAt
orders/{orderId}
  orderId, userId, items[], totalAmount, deliveryCharge, discount, grandTotal,
  couponCode, paymentMethod, status, deliveryAddress, createdAt, estimatedDelivery
coupons/{code}
  discountType, discountValue, minOrderValue, maxDiscount, validTill, isActive
reviews/{reviewId}
  productId, userId, userName, rating, comment, createdAt
```

The app currently stores addresses in the `users/{uid}/addresses` subcollection. The optional `addresses[]` field can be maintained as a denormalized summary if needed later.

## Deploy

From the project root:

```text
firebase login
firebase use YOUR_FIREBASE_PROJECT_ID
cd functions && npm install && cd ..
firebase deploy --only firestore:rules,firestore:indexes,functions
```

To seed development data after installing the functions dependencies:

```text
node functions/seed.js
```

Callable functions exposed to the Flutter client are `updateCart`, `validateCoupon`, and `placeOrder`.

# Razorpay test-mode setup

1. Create a Razorpay test account and copy the test key ID.
2. Replace `REPLACE_WITH_RAZORPAY_TEST_KEY` in `lib/services/payment_service.dart`.
3. Configure Android package metadata and iOS URL/payment settings according to Razorpay Flutter documentation.
4. Never put the Razorpay secret key in Flutter. Keep it in Cloud Functions secrets.
5. The payment success handler must send `razorpay_payment_id`, `razorpay_order_id`, and `razorpay_signature` to a callable Cloud Function before marking an order paid.
6. Use Cash on Delivery while payment credentials are not configured.

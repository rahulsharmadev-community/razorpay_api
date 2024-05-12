// ignore_for_file: unused_field, unused_element
library razorpay_api;

import 'dart:convert';
import 'dart:io';
import '/src/checkout.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

export 'src/checkout.dart';
export 'src/error_response.dart';
export 'src/currencies.dart';

export 'src/refund/refund.dart';
export 'src/refund/refund_api.dart';
export 'src/refund/refund_response.dart';

export 'src/customer/customer.dart';
export 'src/customer/customer_api.dart';
export 'src/customer/customer_response.dart';

export 'src/order/order.dart';
export 'src/order/order_api.dart';
export 'src/order/order_response.dart';
export 'package:razorpay_flutter/razorpay_flutter.dart'
    show ExternalWalletResponse, PaymentFailureResponse, PaymentSuccessResponse;

class RazorPayAPI {
  static late String _keyId, _keySecret;
  static String get keyId => _keyId;
  static String get keySecret => _keySecret;

  static init({required String keyId, required keySecret}) {
    RazorPayAPI._keyId = keyId;
    RazorPayAPI._keySecret = keySecret;
  }

  static final headers = {
    HttpHeaders.authorizationHeader: 'Basic ${base64Encode(utf8.encode('$_keyId:$_keySecret'))}',
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptEncodingHeader: 'gzip, deflate, br'
  };

  final Razorpay _razorpay;
  RazorPayAPI() : _razorpay = Razorpay();
}

extension RazorPayAPIExt on RazorPayAPI {
  /// Opens Razorpay checkout
  void checkout(RazorpayCheckout object) => _razorpay.open(object.toMap());

  /// Clears all event listeners
  void dispose() => _razorpay.clear();

  /// **handler()** is responsible for managing all RazorPay payment-related events.
  /// When a payment is made successfully or unsuccessfully,
  /// the plugin emits events using event-based communication.
  void handler(
    Function(PaymentSuccessResponse) onSuccess,
    Function(PaymentFailureResponse) onError,
    Function(ExternalWalletResponse) onExternalWallet,
  ) {
    ///  What? if payment Success
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, onSuccess);

    /// What if user choose for external wallet (like paytm, amazon pay or other..)
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, onExternalWallet);

    ///  What if payment fails
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, onError);
  }
}

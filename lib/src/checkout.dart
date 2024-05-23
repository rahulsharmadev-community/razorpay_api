import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:razorpay_api/razorpay_api.dart';

import 'helper.dart';
import 'package:flutter/services.dart';

class RazorpayCheckout {
  RazorpayCheckout(
      {required this.amount,
      required this.currency,
      required this.prefill,
      required this.name,
      required this.orderId,
      this.description,
      this.timeout,
      this.image,
      this.customerId,
      this.subscriptionId,
      this.callbackUrl,
      this.readonly,
      this.hidden,
      this.retry,
      this.notes,
      this.theme,
      this.modal,
      this.redirect = false,
      this.recurring = false,
      this.sendSmsHash = false,
      this.allowRotation = false,
      this.rememberCustomer = false,
      this.subscriptionCardChange = false,
      this.config,
      this.externalWallet})
      : key = RazorPayAPI.keyId;

  /// const uniqe value
  final String key;
  final double amount;
  final RazorpayCurrency currency;

  /// Your Business/Enterprise name shown on the Checkout form
  final String name;

  /// Order ID generated via Orders API.
  final String orderId;

  /// Determines whether to allow saving of cards. Can also be configured via the Dashboard.
  final bool rememberCustomer;

  /// Used to auto-read OTP for cards and net banking pages. Applicable from Android SDK version 1.5.9 and above. Possible values:
  ///
  /// **true**: OTP is auto-read.\
  /// **false (default)**: OTP is not auto-read.
  final bool sendSmsHash;

  final bool allowRotation;

  /// Determines whether to post a response to the event handler post payment completion or redirect to Callback URL. callback_url must be passed while using this parameter. Possible values:
  ///  - true: Customer is redirected to the specified callback URL in case of payment failure.
  ///  - false (default): Customer is shown the Checkout popup to retry the payment with the suggested next best option.
  final bool redirect;

  /// Determines if you are accepting recurring (charge-at-will) payments on Checkout via instruments such as emandate, paper NACH and so on. Possible values:
  ///  - `true`: You are accepting recurring payments.
  ///  - `false` (default): You are not accepting recurring payments.
  final bool recurring;

  /// Permit or restrict customer from changing the card linked to the subscription.
  /// You can also do this from the hosted page. Possible values:
  ///
  /// **true**: Allow the customer to change the card from Checkout.\
  /// **false (default)**: Do not allow the customer to change the card from Checkout.
  final bool subscriptionCardChange;

  final String? description;

  /// Sets a timeout on Checkout, in seconds. After the specified time limit, the customer will not be able to use Checkout.
  final Duration? timeout;

  /// Link to an image (usually your business logo) shown on the Checkout form.
  /// Can also be a base64 string if you are not loading the image from a network.
  final String? image;

  /// Unique identifier of customer.
  ///
  /// Used for:
  /// - Local saved cards feature.
  /// - Static bank account details on Checkout in case of Bank Transfer payment method.
  final String? customerId;
  final String? subscriptionId;

  /// Customers will be redirected to this URL on successful payment. Ensure that the domain of the Callback URL is allowlisted.
  final String? callbackUrl;
  final Prefill? prefill;
  final Readonly? readonly;
  final Hidden? hidden;
  final Retry? retry;
  final Map<String, dynamic>? notes;

  final RazorPayCheckOutTheme? theme;
  final Modal? modal;

  final CheckoutConfig? config;

  /// example: externalWallet = ['paytm', 'phonepe', 'amazonpay']
  final List<String>? externalWallet;

  RazorpayCheckout copyWith({
    double? amount,
    RazorpayCurrency? currency,
    String? name,
    String? orderId,
    String? description,
    Duration? timeout,
    String? image,
    String? customerId,
    bool? rememberCustomer,
    bool? sendSmsHash,
    bool? allowRotation,
    String? subscriptionId,
    bool? subscriptionCardChange,
    String? callbackUrl,
    bool? redirect,
    bool? recurring,
    Prefill? prefill,
    Readonly? readonly,
    Hidden? hidden,
    Retry? retry,
    Map<String, dynamic>? notes,
    RazorPayCheckOutTheme? theme,
    Modal? modal,
    CheckoutConfig? config,
    List<String>? externalWallet,
  }) =>
      RazorpayCheckout(
          amount: amount ?? this.amount,
          currency: currency ?? this.currency,
          name: name ?? this.name,
          orderId: orderId ?? this.orderId,
          description: description ?? this.description,
          timeout: timeout ?? this.timeout,
          image: image ?? this.image,
          customerId: customerId ?? this.customerId,
          rememberCustomer: rememberCustomer ?? this.rememberCustomer,
          sendSmsHash: sendSmsHash ?? this.sendSmsHash,
          allowRotation: allowRotation ?? this.allowRotation,
          subscriptionId: subscriptionId ?? this.subscriptionId,
          subscriptionCardChange: subscriptionCardChange ?? this.subscriptionCardChange,
          callbackUrl: callbackUrl ?? this.callbackUrl,
          redirect: redirect ?? this.redirect,
          recurring: recurring ?? this.recurring,
          prefill: prefill ?? this.prefill,
          readonly: readonly ?? this.readonly,
          hidden: hidden ?? this.hidden,
          retry: retry ?? this.retry,
          notes: notes ?? this.notes,
          theme: theme ?? this.theme,
          modal: modal ?? this.modal,
          config: config ?? this.config,
          externalWallet: externalWallet ?? this.externalWallet);

  Map<String, dynamic> toMap() => {
        "key": key,
        "amount": (amount * 100).toInt(),
        "currency": currency.name,
        "name": name,
        "order_id": orderId,
        "redirect": redirect,
        "recurring": recurring,
        "remember_customer": rememberCustomer,
        "send_sms_hash": sendSmsHash,
        "allow_rotation": allowRotation,
        "subscription_card_change": subscriptionCardChange,
        if (description != null) "description": description,
        if (timeout != null) "timeout": timeout?.inSeconds,
        if (image != null) "image": image,
        if (customerId != null) "customer_id": customerId,
        if (subscriptionId != null) "subscription_id": subscriptionId,
        if (callbackUrl != null) "callback_url": callbackUrl,
        if (prefill != null) "prefill": prefill!.toMap(),
        if (readonly != null) "readonly": readonly!.toMap(),
        if (hidden != null) "hidden": hidden?.toMap(),
        if (retry != null) "retry": retry!.toMap(),
        if (notes != null) "notes": notes,
        if (theme != null) "theme": theme!.toMap(),
        if (modal != null) "modal": modal!.toMap(),
        if (config != null) "config": config!.toMap(),
        if (externalWallet != null) 'external': {'wallets': externalWallet}
      };
}

class Hidden {
  Hidden({
    this.email = false,
    this.contact = false,
  });

  final bool? email;
  final bool? contact;

  String toJson() => json.encode(toMap());

  Map<String?, dynamic> toMap() => {"email": email, "contact": contact};
}

class Modal {
  Modal({
    this.backdropclose = false,
    this.escape = true,
    this.handleback = true,
    this.confirmClose = false,
    this.animation = true,
  });

  final bool backdropclose;
  final bool escape;
  final bool handleback;
  final bool confirmClose;
  final bool animation;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "backdropclose": backdropclose,
        "escape": escape,
        "handleback": handleback,
        "confirm_close": confirmClose,
        "animation": animation
      };
}

class Prefill {
  Prefill({
    this.name,
    this.email,
    this.contact,
    this.method,
  });

  /// Cardholder's name to be pre-filled if customer is to make card payments on Checkout.
  final String? name;

  /// Email address of the customer.
  final String? email;

  /// Pre-selection of the payment method for the customer. Will only work if contact and email are also pre-filled.
  final CheckoutMethod? method;

  /// Phone number of the customer. The expected format of the phone number is + {country code}{phone number}
  final String? contact;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        if (name != null) "name": name,
        if (email != null) "email": email,
        if (contact != null) "contact": contact,
        if (method != null) "method": method!.name,
      };
}

class Readonly {
  Readonly({
    this.name = false,
    this.email = false,
    this.contact = false,
  });

  final bool name;
  final bool email;
  final bool contact;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {"name": name, "email": email, "contact": contact};
}

class Retry {
  Retry({this.enabled = true, this.maxCount = 4});

  final bool enabled;
  final int maxCount;

  String? toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "enabled": enabled,
        "max_count": maxCount,
      };
}

class RazorPayCheckOutTheme {
  RazorPayCheckOutTheme({
    this.hideTopbar = false,
    this.color,
    this.backdropColor,
  });

  final bool hideTopbar;
  final Color? color;
  final Color? backdropColor;

  String? toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "hide_topbar": hideTopbar,
        if (color != null) "color": color?.toHex,
        if (backdropColor != null) "backdrop_color": backdropColor?.toHex,
      };
}

// Dart class to represent the configuration
class CheckoutConfig {
  final DisplayLanguage? language;

  CheckoutConfig({this.language});

  Map<String, dynamic> toMap() => {
        "display": {'language': language?.name}
      };
}

// Enum to represent available languages
enum DisplayLanguage {
  en('English'),
  ben('Bengali'),
  hi('Hindi'),
  mar('Marathi'),
  guj('Gujarati'),
  tam('Tamil'),
  tel('Telugu');

  final String fullName;
  const DisplayLanguage(this.fullName);
}

enum CheckoutMethod {
  card,
  netbanking,
  wallet,
  emi,
  upi,
}

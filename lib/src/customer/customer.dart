import 'dart:convert';

class RazorPayCustomer {
  RazorPayCustomer({
    required this.name,
    this.contact,
    this.email,
    this.failExisting,
    this.gstin,
    this.notes,
  });

  /// Customer's name.
  final String name;

  /// The customer's phone number. A maximum length of 15 characters including country code.
  ///  For example, +919876543210.
  final String? contact;

  /// The customer's email address.
  final String? email;

  /// **false**: If a customer with the same details already exists, fetches details of the existing customer.
  ///
  /// **true**: (default): If a customer with the same details already exists, throws an error.
  final bool? failExisting;

  /// Customer's GST number, if available.
  /// For example, 29XAbbA4369J1PA
  final String? gstin;

  /// It can hold up 15 key-values, 256 characters (maximum) each.
  Map<String, dynamic>? notes;

  RazorPayCustomer copyWith(
          {String? name,
          String? contact,
          String? email,
          bool? failExisting,
          String? gstin,
          Map<String, dynamic>? notes}) =>
      RazorPayCustomer(
          name: name ?? this.name,
          contact: contact ?? this.contact,
          email: email ?? this.email,
          failExisting: failExisting ?? this.failExisting,
          gstin: gstin ?? this.gstin,
          notes: notes ?? this.notes);

  String toJson() => json.encode(toMap());

  factory RazorPayCustomer.fromMap(Map<String, dynamic> map) => RazorPayCustomer(
        name: map["name"],
        email: map["email"],
        contact: map["contact"],
        gstin: map["gstin"],
        notes: map["notes"] != null ? Map.from(map["notes"]) : null,
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        if (contact != null) "contact": contact,
        if (email != null) "email": email,
        if (failExisting != null) "fail_existing": failExisting,
        if (gstin != null) "gstin": gstin,
        if (notes != null) "notes": notes
      };
}

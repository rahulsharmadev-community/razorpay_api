import 'dart:convert';

class RazorPayCustomerResponse {
  RazorPayCustomerResponse(
      {required this.id,
      required this.name,
      required this.createdAt,
      this.email,
      this.contact,
      this.gstin,
      this.notes});

  /// Unique identifier of the customer.
  final String id;

  /// Customer's name.
  final String name;

  /// The customer's phone number. A maximum length of 15 characters including country code.
  ///  For example, +919876543210.
  final String? contact;

  /// The customer's email address.
  final String? email;

  /// Customer's GST number, if available.
  /// For example, 29XAbbA4369J1PA
  final String? gstin;

  final DateTime createdAt;
  final Map<String, dynamic>? notes;

  factory RazorPayCustomerResponse.fromJson(String str) =>
      RazorPayCustomerResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RazorPayCustomerResponse.fromMap(Map<String, dynamic> map) =>
      RazorPayCustomerResponse(
        id: map["id"],
        name: map["name"],
        email: map["email"],
        contact: map["contact"],
        gstin: map["gstin"],
        notes: map["notes"] != null ? Map.from(map["notes"]) : null,
        createdAt: DateTime.fromMillisecondsSinceEpoch(
            (map["created_at"] as int) * 1000),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "created_at": createdAt.millisecondsSinceEpoch / 1000,
        if (email != null) "email": email,
        if (contact != null) "contact": contact,
        if (gstin != null) "gstin": gstin,
        if (notes != null) "notes": notes,
      };
}

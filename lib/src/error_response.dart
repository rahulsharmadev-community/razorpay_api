import 'dart:convert';

class RazorPayErrorResponse implements Exception {
  RazorPayErrorResponse({this.code, this.description, this.source, this.step, this.reason, this.field});

  final String? code;
  final String? description;
  final String? source;
  final String? step;
  final String? reason;
  final String? field;

  RazorPayErrorResponse copyWith({
    String? code,
    String? description,
    String? source,
    String? step,
    String? reason,
    String? field,
  }) =>
      RazorPayErrorResponse(
        code: code ?? this.code,
        description: description ?? this.description,
        source: source ?? this.source,
        step: step ?? this.step,
        reason: reason ?? this.reason,
        field: field ?? this.field,
      );

  factory RazorPayErrorResponse.fromJson(String str) => RazorPayErrorResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RazorPayErrorResponse.fromMap(Map<String, dynamic> json) => RazorPayErrorResponse(
        code: json["code"],
        description: json["description"],
        source: json["source"],
        step: json["step"],
        reason: json["reason"],
        field: json["field"],
      );

  Map<String, dynamic> toMap() => {
        if (code != null) "code": code,
        if (description != null) "description": description,
        if (source != null) "source": source,
        if (step != null) "step": step,
        if (reason != null) "reason": reason,
        if (field != null) "field": field,
      };
}

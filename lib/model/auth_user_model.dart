import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AuthUserModel {
  String token;
  AuthUserModel({
    required this.token,
  });

  AuthUserModel copyWith({
    String? token,
  }) {
    return AuthUserModel(
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
    };
  }

  factory AuthUserModel.fromMap(Map<String, dynamic> map) {
    return AuthUserModel(
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthUserModel.fromJson(String source) =>
      AuthUserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AuthUserModel(token: $token)';

  @override
  bool operator ==(covariant AuthUserModel other) {
    if (identical(this, other)) return true;

    return other.token == token;
  }

  @override
  int get hashCode => token.hashCode;
}

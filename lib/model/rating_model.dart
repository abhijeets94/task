import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Rating {
  double rate;
  int count;
  Rating({
    required this.rate,
    required this.count,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rate': rate,
      'count': count,
    };
  }

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      rate: map['rate'].toDouble() as double,
      count: map['count'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Rating.fromJson(String source) =>
      Rating.fromMap(json.decode(source) as Map<String, dynamic>);
}

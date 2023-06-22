import 'package:json_annotation/json_annotation.dart';
part 'person.g.dart';

@JsonSerializable()
class Person {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'popularity')
  final num? popularity;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'profileImg')
  final String? profileImg;
  @JsonKey(name: 'known')
  final String? known;

  Person({
    this.id,
    this.name,
    this.profileImg,
    this.popularity,
    this.known,
  });
  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
  Map<String, dynamic> toJson() => _$PersonToJson(this);
}

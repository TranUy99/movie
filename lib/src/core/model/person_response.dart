import 'package:json_annotation/json_annotation.dart';
import 'package:movie/src/core/model/person.dart';

part 'person_response.g.dart';

@JsonSerializable()
class PersonResponse {
  @JsonKey(name: 'person')
  final List<Person>? person;
  @JsonKey(name: 'error')
  final String? error;

  PersonResponse({
    this.person,
    this.error,
   
  });
  factory PersonResponse.fromJson(Map<String, dynamic> json) => _$PersonResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PersonResponseToJson(this);
}

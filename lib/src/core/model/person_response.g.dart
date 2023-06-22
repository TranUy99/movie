// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonResponse _$PersonResponseFromJson(Map<String, dynamic> json) =>
    PersonResponse(
      person: (json['person'] as List<dynamic>?)
          ?.map((e) => Person.fromJson(e as Map<String, dynamic>))
          .toList(),
      error: json['error'] as String?,
    );

Map<String, dynamic> _$PersonResponseToJson(PersonResponse instance) =>
    <String, dynamic>{
      'person': instance.person,
      'error': instance.error,
    };

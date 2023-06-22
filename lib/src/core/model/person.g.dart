// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      id: json['id'] as int?,
      name: json['name'] as String?,
      profileImg: json['profileImg'] as String?,
      popularity: json['popularity'] as num?,
      known: json['known'] as String?,
    );

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'id': instance.id,
      'popularity': instance.popularity,
      'name': instance.name,
      'profileImg': instance.profileImg,
      'known': instance.known,
    };

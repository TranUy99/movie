// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieResponse _$MovieResponseFromJson(Map<String, dynamic> json) =>
    MovieResponse(
      movie: (json['movie'] as List<dynamic>?)
          ?.map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList(),
      error: json['error'] as String?,
    );

Map<String, dynamic> _$MovieResponseToJson(MovieResponse instance) =>
    <String, dynamic>{
      'movie': instance.movie,
      'error': instance.error,
    };

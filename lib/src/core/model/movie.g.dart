// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      id: json['id'] as int?,
      backPoster: json['backPoster'] as String?,
      overview: json['overview'] as String?,
      popularity: json['popularity'] as num?,
      poster: json['poster'] as String?,
      rating: json['rating'] as num?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'popularity': instance.popularity,
      'title': instance.title,
      'backPoster': instance.backPoster,
      'poster': instance.poster,
      'overview': instance.overview,
      'rating': instance.rating,
    };

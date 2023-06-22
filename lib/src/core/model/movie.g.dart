// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      id: json['id'] as int?,
      backdrop_path: json['backdrop_path'] as String?,
      overview: json['overview'] as String?,
      popularity: json['popularity'] as num?,
      poster_path: json['poster_path'] as String?,
      vote_average: json['vote_average'] as num?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'popularity': instance.popularity,
      'title': instance.title,
      'backPoster': instance.backdrop_path,
      'poster_path': instance.poster_path,
      'overview': instance.overview,
      'vote_average': instance.vote_average,
    };

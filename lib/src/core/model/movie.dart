import 'package:json_annotation/json_annotation.dart';
part 'movie.g.dart';

@JsonSerializable()
class Movie {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'popularity')
  final num? popularity;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'backdrop_path')
  final String? backdrop_path;
  @JsonKey(name: 'poster_path')
  final String? poster_path;
  @JsonKey(name: 'overview')
  final String? overview;
  @JsonKey(name: 'vote_average')
  final num? vote_average;

  Movie({
    this.id,
    this.backdrop_path,
    this.overview,
    this.popularity,
    this.poster_path,
    this.vote_average,
    this.title,
  });
  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);
}

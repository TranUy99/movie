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
  @JsonKey(name: 'backPoster')
  final String? backPoster;
  @JsonKey(name: 'poster')
  final String? poster;
  @JsonKey(name: 'overview')
  final String? overview;
  @JsonKey(name: 'rating')
  final num? rating;

  Movie({
    this.id,
    this.backPoster,
    this.overview,
    this.popularity,
    this.poster,
    this.rating,
    this.title,
  });
  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);
}

import 'package:json_annotation/json_annotation.dart';
import 'package:movie/src/core/model/movie.dart';
part 'movie_response.g.dart';

@JsonSerializable()
class MovieResponse {
  @JsonKey(name: 'movie')
  final List<Movie>? movie;
  @JsonKey(name: 'error')
  final String? error;

  MovieResponse({
    this.movie,
    this.error,
   
  });
  factory MovieResponse.fromJson(Map<String, dynamic> json) => _$MovieResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MovieResponseToJson(this);
}

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:movie/src/core/model/genre_response.dart';
import 'package:movie/src/core/model/movie.dart';
import 'package:movie/src/core/model/movie_response.dart';
import 'package:movie/src/core/model/person_response.dart';

class MovieRepository {
  final String apiKey = "e9e9d8da18ae29fc430845952232787c";
  static String mainUrl = "https://api.themoviedb.org/3";

  final Dio _dio = Dio();
  var getPopularUrl = '$mainUrl/movie/top_rated';
  var getMoviesUrl = '$mainUrl/discover/movie';
  var getPlayingUrl = '$mainUrl/movie/now_playing';
  var getGenresUrl = "$mainUrl/genre/movie/list";
  var getPersonsUrl = "$mainUrl/trending/person/week";
  var movieUrl = "$mainUrl/movie";

  Future<MovieResponse> getMovies() async {
    var params = {"api_key": apiKey, "language": "en-US", "page": 1};
    try {
      Response response = await _dio.get(getPopularUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieResponse();
    }
  }

  Future<List<Movie>> getPlayingMovies() async {
    var params = {"api_key": apiKey, "language": "en-US", "page": 1};
    try {
      Response response = await _dio.get(getPlayingUrl, queryParameters: params);

      List<Movie> results = (response.data['results'] as List).map((item) => Movie.fromJson(item)).toList();
      return results;
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");

      return [];
    }
  }

  Future<List<Movie>> getMovieByGenre(int id) async {
    var similarMoviesUrl = '$mainUrl/movie/$id/similar';
    var params = {"api_key": apiKey, "language": "en-US", "page": 1};
    try {
      Response response = await _dio.get(similarMoviesUrl, queryParameters: params);
      List<Movie> results = (response.data['results'] as List).map((item) => Movie.fromJson(item)).toList();
      return results;
    } catch (error, stacktrace) {
      print("Exception occurred: $error\nStackTrace: $stacktrace");
      return [];
    }
  }

  Future<GenreResponse> getGenres() async {
    var params = {"api_key": apiKey, "language": "en-US"};
    try {
      Response response = await _dio.get(getGenresUrl, queryParameters: params);
      return GenreResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return GenreResponse.withError("$error");
    }
  }

  Future<PersonResponse> getPersons() async {
    var params = {"api_key": apiKey};
    try {
      Response response = await _dio.get(getPersonsUrl, queryParameters: params);
      return PersonResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return PersonResponse();
    }
  }

  // Future<MovieDetailResponse> getMovieDetail(int id) async {
  //   var params = {"api_key": apiKey, "language": "en-US"};
  //   try {
  //     Response response = await _dio.get(movieUrl + "/$id", queryParameters: params);
  //     return MovieDetailResponse.fromJson(response.data);
  //   } catch (error, stacktrace) {
  //     print("Exception occured: $error stackTrace: $stacktrace");
  //     return MovieDetailResponse.withError("$error");
  //   }
  // }

  // Future<VideoResponse> getMovieVideos(int id) async {
  //   var params = {"api_key": apiKey, "language": "en-US"};
  //   try {
  //     Response response = await _dio.get(movieUrl + "/$id" + "/videos", queryParameters: params);
  //     return VideoResponse.fromJson(response.data);
  //   } catch (error, stacktrace) {
  //     print("Exception occured: $error stackTrace: $stacktrace");
  //     return VideoResponse.withError("$error");
  //   }
  // }

  // Future<MovieResponse> getSimilarMovies(int id) async {
  //   var params = {"api_key": apiKey, "language": "en-US"};
  //   try {
  //     Response response = await _dio.get(movieUrl + "/$id" + "/similar", queryParameters: params);
  //     return MovieResponse.fromJson(response.data);
  //   } catch (error, stacktrace) {
  //     print("Exception occured: $error stackTrace: $stacktrace");
  //     return MovieResponse.withError("$error");
  //   }
  // }

  // Future<CastResponse> getCasts(int id) async {
  //   var params = {"api_key": apiKey, "language": "en-US"};
  //   try {
  //     Response response = await _dio.get(movieUrl + "/$id" + "/credits", queryParameters: params);
  //     return CastResponse.fromJson(response.data);
  //   } catch (error, stacktrace) {
  //     print("Exception occured: $error stackTrace: $stacktrace");
  //     return CastResponse.withError("$error");
  //   }
  // }
}

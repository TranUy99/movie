import 'package:flutter/material.dart';
import 'package:movie/src/core/api/movie_response.dart';
import 'package:movie/src/core/model/movie_response.dart';
import 'package:rxdart/rxdart.dart';

import '../../core/model/movie.dart';

class MoviesListByGenreBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();

  getMoviesByGenre(int id) async {
    
     List<Movie> movies = await _repository.getMovieByGenre(id);
      MovieResponse response = MovieResponse(movie: movies);
      _subject.sink.add(response);
  }

  void drainStream() async {
    await _subject.drain();
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;
}

final moviesByGenreBloc = MoviesListByGenreBloc();
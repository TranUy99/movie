import 'package:movie/src/core/api/movie_response.dart';
import 'package:movie/src/core/model/movie_response.dart';
import 'package:rxdart/rxdart.dart';

class MovieBloc {
  final MovieRepository _movieRepository = MovieRepository();
  final BehaviorSubject<MovieResponse> _subject = BehaviorSubject<MovieResponse>();

  getMoives() async {
    MovieResponse response = await _movieRepository.getMovies();
    _subject.sink.add(response);
  }
  dispose() {
    _subject.close();
  }
  BehaviorSubject<MovieResponse> get subject => _subject;
}

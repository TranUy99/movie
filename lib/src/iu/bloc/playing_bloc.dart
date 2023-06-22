import 'package:movie/src/core/api/movie_response.dart';
import 'package:movie/src/core/model/movie.dart';
import 'package:movie/src/core/model/movie_response.dart';
import 'package:rxdart/rxdart.dart';

class NowPlayingListBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<MovieResponse> _subject = BehaviorSubject<MovieResponse>();

  Future<void> getMovies() async {
    try {
      List<Movie> movies = await _repository.getPlayingMovies();
      MovieResponse response = MovieResponse(movie: movies);
      _subject.sink.add(response);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      _subject.sink.addError("Failed to fetch movies.");
    }
  }

  void dispose() {
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;
}

final nowPlayingMoviesBloc = NowPlayingListBloc();
import 'package:flutter/material.dart';
import 'package:movie/src/core/model/video_response.dart';
import 'package:rxdart/rxdart.dart';

import '../../core/api/movie_response.dart';

class MovieVideoBloc {
  final MovieRepository _response = MovieRepository();
  final BehaviorSubject<VideoResponse> _subject = BehaviorSubject<VideoResponse>();

  getMovieVideo(int id) async {
    VideoResponse response = await _response.getMovieVideos(id);
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

  BehaviorSubject<VideoResponse> get subject => _subject;
}

final movieVideosBloc = MovieVideoBloc();

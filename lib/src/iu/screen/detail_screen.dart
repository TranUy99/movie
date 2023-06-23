import 'package:flutter/material.dart';
import 'package:movie/src/core/model/movie.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;
  const MovieDetailScreen({super.key, required this.movie});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  //   @override
  // void initState() {
  //   super.initState();
  //   movieVideosBloc.getMovieVideos(movie.id);
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   movieVideosBloc.drainStream();
  // }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie/src/contants/color.dart';
import 'package:movie/src/core/model/movie.dart';
import 'package:movie/src/iu/screen/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../core/model/video.dart';
import '../../core/model/video_response.dart';
import '../bloc/movie_video_bloc.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;
  MovieDetailScreen({super.key, required this.movie});
  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState(movie);
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final Movie movie;
  _MovieDetailScreenState(this.movie);

  @override
  void initState() {
    super.initState();
    movieVideosBloc.getMovieVideo(movie.id!);
  }

  @override
  void dispose() {
    super.dispose();
    movieVideosBloc.drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      body: Builder(
        builder: (context) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: kYellowColor,
                expandedHeight: 200.0,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  // title: Text(
                  //   movie.title.length > 40 ? movie.title.substring(0, 37) + "..." : movie.title,
                  //   style: const TextStyle(
                  //     fontSize: 12.0,
                  //     fontWeight: FontWeight.normal,
                  //   ),
                  // ),
                  background: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              "https://image.tmdb.org/t/p/original/${movie.backdrop_path}",
                            ),
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: [0.1, 0.9],
                            colors: [
                              Colors.black.withOpacity(0.9),
                              Colors.black.withOpacity(0.0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    StreamBuilder<VideoResponse>(
                      stream: movieVideosBloc.subject.stream,
                      builder: (context, AsyncSnapshot<VideoResponse> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.error != null && snapshot.data!.error.length > 0) {
                            return _buildErrorWidget(snapshot.data!.error);
                          }
                          return _buildVideoWidget(snapshot.data!);
                        } else if (snapshot.hasError) {
                          return _buildErrorWidget(snapshot.data!.error);
                        } else {
                          return _buildLoadingWidget();
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            movie.vote_average.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          RatingBar(
                            itemSize: 8.0,
                            ratingWidget: RatingWidget(
                              empty: const Icon(
                                Icons.star,
                                color: kYellowColor,
                              ),
                              full: const Icon(
                                Icons.star,
                                color: kYellowColor,
                              ),
                              half: const Icon(
                                Icons.star,
                                color: kYellowColor,
                              ),
                            ),
                            initialRating: 2,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: const EdgeInsets.symmetric(
                              horizontal: 2.0,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                      child: Text(
                        "OVERVIEW",
                        style: TextStyle(
                          color: kGreyColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        movie.overview!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    // MovieInfo(
                    //   id: movie.id,
                    // ),
                    // Casts(
                    //   id: movie.id,
                    // ),
                    // SimilarMovies(id: movie.id)
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return const Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
      ],
    ));
  }

  Widget _buildVideoWidget(VideoResponse data) {
    List<Video> videos = data.videos;

    return FloatingActionButton(
      backgroundColor: kYellowColor,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPlayerScreen(
              controller: YoutubePlayerController(
                initialVideoId: videos[0].key,
                flags: const YoutubePlayerFlags(
                  autoPlay: true,
                  mute: true,
                ),
              ),
            ),
          ),
        );
      },
      child: const Icon(Icons.play_arrow),
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movie/src/contants/color.dart';
import 'package:movie/src/iu/bloc/playing_bloc.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../core/model/movie_response.dart';
import '../../core/model/video_response.dart';
import '../bloc/movie_video_bloc.dart';
import '../screen/video_player.dart';

class NowPlaying extends StatefulWidget {
  const NowPlaying({super.key});

  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  PageController pageController = PageController(viewportFraction: 1, keepPage: true);

  @override
  void initState() {
    super.initState();
    nowPlayingMoviesBloc.getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
      stream: nowPlayingMoviesBloc.subject.stream, // Add the null check operator '?'
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var movies = snapshot.data!.movie!;
          return SizedBox(
            height: 220.0,
            child: PageIndicatorContainer(
              align: IndicatorAlign.bottom,
              length: movies.take(5).length,
              indicatorSpace: 8.0,
              padding: const EdgeInsets.all(5.0),
              indicatorColor: kGreyColor,
              indicatorSelectorColor: kYellowColor,
              shape: IndicatorShape.circle(size: 5.0),
              child: PageView.builder(
                controller: pageController,
                scrollDirection: Axis.horizontal,
                itemCount: movies.take(5).length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      movieVideosBloc.getMovieVideo(movies[index].id!);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return StreamBuilder<VideoResponse>(
                              stream: movieVideosBloc.subject.stream,
                              builder: (context, AsyncSnapshot<VideoResponse> snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data!.error != null && snapshot.data!.error.isNotEmpty) {
                                    return const Text("Error occurred");
                                  }
                                  return VideoPlayerScreen(
                                    controller: YoutubePlayerController(
                                      initialVideoId: snapshot.data!.videos[index].key,
                                      flags: const YoutubePlayerFlags(
                                        autoPlay: true,
                                        mute: true,
                                      ),
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return const Text("Error occurred");
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              },
                            );
                          },
                        ),
                      );
                    },
                    child: Stack(
                      children: <Widget>[
                        Hero(
                          tag: movies[index],
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 220.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(fit: BoxFit.cover, image: NetworkImage("https://image.tmdb.org/t/p/original/${movies[index].backdrop_path!}")),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter, end: Alignment.topCenter, stops: [0.0, 0.9], colors: [kBlackColor.withOpacity(1.0), kBlackColor.withOpacity(0.0)]),
                          ),
                        ),
                        const Positioned(
                          bottom: 0.0,
                          top: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Icon(
                            Icons.play_circle,
                            color: kYellowColor,
                            size: 40.0,
                          ),
                        ),
                        Positioned(
                            bottom: 30.0,
                            child: Container(
                              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                              width: 250.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    movies[index].title!,
                                    style: const TextStyle(height: 1.5, color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        } else if (snapshot.hasError) {
          // Handle the error case
          return const Text('Error occurred');
        } else {
          // Handle the initial loading state or when data is still null
          return CircularProgressIndicator();
        }
      },
    );
  }
}

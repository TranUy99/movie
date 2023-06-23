import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie/src/contants/color.dart';
import 'package:movie/src/core/model/movie_response.dart';
import 'package:movie/src/iu/bloc/movie_bloc.dart';

import '../screen/detail_screen.dart';

class BestMovies extends StatefulWidget {
  const BestMovies({super.key});

  @override
  State<BestMovies> createState() => _BestMoviesState();
}

class _BestMoviesState extends State<BestMovies> {
  @override
  void initState() {
    super.initState();
    moviesBloc.getMoives();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10.0, top: 20.0),
          child: Text(
            "BEST POPULAR MOVIES",
            style: TextStyle(color: kYellowColor, fontWeight: FontWeight.w500, fontSize: 12.0),
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        StreamBuilder<MovieResponse>(
          stream: moviesBloc.subject.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var movies = snapshot.data?.movie;
              if (movies != null && movies.isNotEmpty) {
                return Container(
                    height: 270.0,
                    padding: EdgeInsets.only(left: 10.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      var movie = movies[index];
                  
                      return Padding(
                        padding: const EdgeInsets.only(
                          top: 10.0,
                          bottom: 10.0,
                          right: 15.0,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MovieDetailScreen(movie: movie),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              movie.poster_path == null
                                  ? Container(
                                      width: 120.0,
                                      height: 180.0,
                                      decoration: const BoxDecoration(
                                        color: kYellowColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(2.0),
                                        ),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: const Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.filter_drama_outlined,
                                            color: Colors.white,
                                            size: 60.0,
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      width: 120.0,
                                      height: 180.0,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(2.0),
                                        ),
                                        shape: BoxShape.rectangle,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            "https://image.tmdb.org/t/p/w200/${movie.poster_path}",
                                          ),
                                        ),
                                      ),
                                    ),
                              const SizedBox(height: 10.0),
                              SizedBox(
                                width: 110,
                                child: Text(
                                  movie.title ?? '',
                                  maxLines: 2,
                                  style: const TextStyle(
                                    height: 1.4,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11.0,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    movie.vote_average.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 5.0),
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
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            "No More Movies",
                            style: TextStyle(color: Colors.black45),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
            } else if (snapshot.hasError) {
              // Handle the error case
              return const Text('Error occurred');
            } else {
              // Handle the initial loading state or when data is still null
              return const CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }
}

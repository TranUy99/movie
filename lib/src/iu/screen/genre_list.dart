import 'package:flutter/material.dart';
import 'package:movie/src/contants/color.dart';
import 'package:movie/src/core/model/genre.dart';
import 'package:movie/src/iu/bloc/movie_by_genre_bloc.dart';
import 'package:movie/src/iu/screen/movie_by_genre.dart';

class GenresList extends StatefulWidget {
  final List<Genre> genres;
  const GenresList({super.key, required this.genres});

  @override
  State<GenresList> createState() => _GenresListState(genres);
}

class _GenresListState extends State<GenresList> with SingleTickerProviderStateMixin {
  final List<Genre> genres;
  _GenresListState(this.genres);
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: genres.length);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        moviesByGenreBloc.drainStream();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 307.0,
        child: DefaultTabController(
          length: genres.length,
          child: Scaffold(
            backgroundColor: kBlackColor,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50.0),
              child: AppBar(
                backgroundColor: kBlackColor,
                bottom: TabBar(
                  controller: _tabController,
                  indicatorColor: kYellowColor,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 3.0,
                  unselectedLabelColor: kGreyColor,
                  labelColor: Colors.white,
                  isScrollable: true,
                  tabs: genres.map((Genre genre) {
                    return Container(
                        padding: const EdgeInsets.only(bottom: 15.0, top: 10.0),
                        child: Text(genre.name!.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            )));
                  }).toList(),
                ),
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: genres.map((Genre genre) {
                return GenreMovies(
                  genreId: genre.id!,
                );
              }).toList(),
            ),
          ),
        ));
  }
}

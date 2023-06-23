import 'package:flutter/material.dart';
import 'package:movie/src/contants/color.dart';
import 'package:movie/src/iu/widget/best_movie.dart';
import 'package:movie/src/iu/widget/genre.dart';
import 'package:movie/src/iu/widget/now_playing.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      appBar: AppBar(
        backgroundColor: kBlackColor,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [kGreyColor, kBlackColor],
            ),
            color: kBlackColor,
            boxShadow: const [BoxShadow(blurRadius: 50.0)],
            borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(MediaQuery.of(context).size.width, 20)),
          ),
        ),
        centerTitle: true,
        leading: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
        title: const Text("Discover"),
        actions: <Widget>[
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ))
        ],
      ),
      body: ListView(
        children: const <Widget>[
          NowPlaying(),
          GenresScreen(),
          BestMovies(),
        ],
      ),
    );
  }
}

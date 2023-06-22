import 'package:flutter/material.dart';
import 'package:movie/src/core/model/genre.dart';
import 'package:movie/src/core/model/genre_response.dart';
import 'package:movie/src/iu/bloc/genre_bloc.dart';
import 'package:movie/src/iu/screen/genre_list.dart';

class GenresScreen extends StatefulWidget {
  const GenresScreen({super.key});

  @override
  _GenresScreenState createState() => _GenresScreenState();
}

class _GenresScreenState extends State<GenresScreen>{
  

  @override
  void initState() {
    super.initState();
    genresBloc.getGenres();
    
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GenreResponse>(
        stream: genresBloc.subject.stream,
        builder: (context, AsyncSnapshot<GenreResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.error != null && snapshot.data!.error.length > 0) {
              return _buildErrorWidget(snapshot.data!.error);
            }
            return _buildHomeWidget(snapshot.data!);
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.data!.error);
          } else {
            return _buildLoadingWidget();
          }
        },
      );
  }

  Widget _buildLoadingWidget() {
    return const Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(
            valueColor:
                  AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 4.0,
          ),
        )
      ],
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

  Widget _buildHomeWidget(GenreResponse data) {
    List<Genre> genres = data.genres;
  
    if (genres.isEmpty) {
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
                )
              ],
            )
          ],
        ),
      );
    } else {
      return GenresList(genres: genres,);
    }
  }
}
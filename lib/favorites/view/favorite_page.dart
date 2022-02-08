import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jokes_bloc/favorites/bloc/favorite_bloc.dart';
import 'package:jokes_bloc/favorites/widgets/favorite_empty.dart';
import 'package:jokes_bloc/favorites/widgets/favorite_loading.dart';
import 'package:jokes_bloc/joke/bloc/joke_bloc.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Joke"),
        actions: [
          IconButton(
              onPressed: () async {
                //TODO: Pass Mode Joke to Joke Bloc
                Navigator.pushNamed(context, '/joke');
                //context.read<JokeBloc>().add(FetchNextJoke());
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(builder: (context, state) {
        switch (state.status) {
          case FavoriteStatus.loading:
            return FavoriteLoading();
          case FavoriteStatus.initial:
            return FavoriteEmpty();
          case FavoriteStatus.success:
            return FavoriteView();
          case FavoriteStatus.failure:
            return FavoriteEmpty();
          default:
            return FavoriteEmpty();
        }
      }),
    );
  }
}

class FavoriteView extends StatelessWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jokes_bloc/favorites/bloc/favorite_bloc.dart';
import 'package:jokes_bloc/favorites/widgets/favorite_empty.dart';
import 'package:jokes_bloc/favorites/widgets/favorite_loading.dart';
import 'package:jokes_bloc/joke/bloc/joke_bloc.dart';
import 'package:jokes_repository/jokes_repository.dart';

const newJokeMode = false;
const historyMode = true;

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
                final rebuild = await Navigator.pushNamed(context, '/joke',
                    arguments: [newJokeMode]);
                if (rebuild != null) {
                  context.read<FavoriteBloc>().add(GetAllFavorites());
                }
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(builder: (context, state) {
        switch (state.status) {
          case FavoriteStatus.loading:
            return FavoriteLoading();
          case FavoriteStatus.initial:
            context.read<FavoriteBloc>().add(GetAllFavorites());
            return FavoriteEmpty();
          case FavoriteStatus.empty:
            return FavoriteEmpty();
          case FavoriteStatus.success:
            return FavoriteView(jokes: state.jokes);
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
  const FavoriteView({Key? key, required this.jokes}) : super(key: key);

  final List<Joke> jokes;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: jokes.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () async {
              final res = await Navigator.pushNamed(context, '/joke',
                  arguments: [historyMode, index]);
              if (res != null) {
                context.read<FavoriteBloc>().add(GetAllFavorites());
              }
            },
            title: Text(jokes[index].joke),
            subtitle: Text(jokes[index].category.toString()),
            trailing: Icon(Icons.navigate_next),
          );
        });
  }
}

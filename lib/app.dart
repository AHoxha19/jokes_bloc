import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jokes_bloc/favorites/bloc/favorite_bloc.dart';
import 'package:jokes_bloc/favorites/view/favorite_page.dart';
import 'package:jokes_bloc/joke/bloc/joke_bloc.dart';
import 'package:jokes_repository/jokes_repository.dart';

import 'joke/joke.dart';

class App extends StatelessWidget {
  const App({Key? key, required this.jokesRepository}) : super(key: key);

  final JokesRepository jokesRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => FavoriteBloc(jokesRepository: jokesRepository)),
          BlocProvider(
              create: (_) => JokeBloc(jokesRepository: jokesRepository))
        ],
        child: MaterialApp(
          title: 'Jokes',
          initialRoute: '/',
          routes: {
            '/': (_) => FavoritePage(),
            '/joke': (_) => JokePage(),
          },
        ));
  }
}

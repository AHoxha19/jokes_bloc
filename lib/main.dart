import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jokes_bloc/app.dart';
import 'package:jokes_bloc/joke_bloc_observer.dart';
import 'package:jokes_repository/jokes_repository.dart';

void main() async {
  BlocOverrides.runZoned(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final jokeStorage = JokesStorage();
    await jokeStorage.initDb();
    runApp(App(jokesRepository: JokesRepository()));
  }, blocObserver: JokeBlocObserver());
}

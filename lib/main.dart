import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jokes_bloc/app.dart';
import 'package:jokes_bloc/joke_bloc_observer.dart';
import 'package:jokes_repository/jokes_repository.dart';

void main() {
  BlocOverrides.runZoned(() => runApp(App(jokesRepository: JokesRepository())),
      blocObserver: JokeBlocObserver());
}

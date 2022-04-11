import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jokes_bloc/joke/bloc/joke_bloc.dart';
import 'package:jokes_bloc/joke/widgets/joke_empty.dart';
import 'package:jokes_bloc/joke/widgets/joke_error.dart';
import 'package:jokes_bloc/joke/widgets/joke_loading.dart';
import 'package:jokes_bloc/joke/widgets/joke_populated.dart';
import 'package:jokes_repository/jokes_repository.dart';

class JokePage extends StatelessWidget {
  const JokePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mode = ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    return BlocProvider(
      create: (_) => JokeBloc(
          jokesRepository: context.read<JokesRepository>(),
          mode: mode[0],
          position: mode.length == 2 ? mode[1] : null),
      child: JokeView(),
    );
  }
}

class JokeView extends StatelessWidget {
  const JokeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Joke"),
      ),
      body: BlocBuilder<JokeBloc, JokeState>(builder: (context, state) {
        switch (state.status) {
          case JokeStatus.initial:
            context.read<JokeBloc>().add(FetchJoke());
            return JokeEmpty();
          case JokeStatus.loading:
            return JokeLoading();
          case JokeStatus.success:
            return JokePopulated(joke: state.joke);
          case JokeStatus.failure:
          default:
            return JokeError();
        }
      }),
    );
  }
}

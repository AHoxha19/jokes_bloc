import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jokes_bloc/joke/bloc/joke_bloc.dart';
import 'package:jokes_bloc/joke/widgets/joke_empty.dart';
import 'package:jokes_bloc/joke/widgets/joke_error.dart';
import 'package:jokes_bloc/joke/widgets/joke_loading.dart';
import 'package:jokes_bloc/joke/widgets/joke_populated.dart';

class JokePage extends StatelessWidget {
  const JokePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Joke"),
      ),
      body: BlocBuilder<JokeBloc, JokeState>(builder: (context, state) {
        print("bloc built");
        print("Joke STATUSSSSSSSSSSSS: ${state.status}");
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

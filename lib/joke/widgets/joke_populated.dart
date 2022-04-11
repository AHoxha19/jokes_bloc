import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jokes_bloc/joke/bloc/joke_bloc.dart';
import 'package:jokes_repository/jokes_repository.dart';

class JokePopulated extends StatelessWidget {
  const JokePopulated({Key? key, required this.joke}) : super(key: key);

  final Joke joke;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return true;
      },
      child: BlocBuilder<JokeBloc, JokeState>(
        builder: (context, state) {
          final height = MediaQuery.of(context).size.height;
          print("Favorite Value: ${joke.favorite}");
          return SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: height * 0.1),
                  child: Text(
                    joke.category.toString(),
                    style: TextStyle(fontSize: height * 0.02),
                  ),
                ),
                Chip(
                  label: Text(joke.safe ? 'Safe' : 'Not safe'),
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                SizedBox(
                  height: height * 0.25,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        joke.joke,
                        style: TextStyle(
                            fontSize: height * 0.03,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: !state.isFirstJoke()
                            ? () {
                                context
                                    .read<JokeBloc>()
                                    .add(FetchPreviousJoke());
                              }
                            : null,
                        child: const Icon(Icons.arrow_back)),
                    ElevatedButton(
                        onPressed: () {
                          //jokeViewModel.editFavorite();
                          context.read<JokeBloc>().add(EditFavorite());
                        },
                        child: joke.favorite
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : const Icon(Icons.favorite_border)),
                    ElevatedButton(
                        onPressed: state.isLastJokeOfFavorites()
                            ? null
                            : () {
                                //jokeViewModel.nextJoke();
                                context.read<JokeBloc>().add(FetchNextJoke());
                              },
                        child: const Icon(Icons.arrow_forward)),
                  ],
                ),
                SizedBox(
                  height: height * 0.1,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

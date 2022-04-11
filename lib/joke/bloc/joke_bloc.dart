import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jokes_repository/jokes_repository.dart';

part 'joke_event.dart';
part 'joke_state.dart';

class JokeBloc extends Bloc<JokeEvent, JokeState> {
  JokeBloc(
      {required JokesRepository jokesRepository,
      required bool mode,
      int? position})
      : _jokesRepository = jokesRepository,
        super(JokeState(
            jokeMode: mode ? JokeMode.history_joke : JokeMode.new_joke,
            position: position)) {
    on<FetchJoke>(_fetchJoke);
    on<FetchPreviousJoke>(_fetchPreviousJoke);
    on<FetchNextJoke>(_fetchNextJoke);
    on<EditFavorite>(_editFavorite);
  }

  final JokesRepository _jokesRepository;

  void _fetchJoke(FetchJoke event, Emitter<JokeState> emit) async {
    emit(state.copyWith(status: JokeStatus.loading));

    try {
      if (state.jokeMode == JokeMode.new_joke) {
        //fetch a new joke from API
        final joke = await _jokesRepository.getJoke(true);
        emit(state.copyWith(
            status: JokeStatus.success,
            history: state.history..add(joke),
            joke: joke));
      } else {
        //load all Jokes in history
        final jokes = await _jokesRepository.getFavoriteJokes();
        emit(state.copyWith(
            status: JokeStatus.success,
            history: jokes,
            joke: jokes.elementAt(state.position)));
      }
    } catch (e) {
      print(e);
      emit(state.copyWith(status: JokeStatus.failure));
    }
  }

  Future<void> _fetchNextJoke(
      FetchNextJoke event, Emitter<JokeState> emit) async {
    emit(state.copyWith(status: JokeStatus.loading));

    try {
      if (state.jokeMode == JokeMode.new_joke) {
        //We need to fetch a new Joke
        //if the position is == to history length, we need to fetch a new joke
        if (state.position == state.history.length - 1) {
          final joke = await _jokesRepository.getJoke(true);
          emit(state.copyWith(
              status: JokeStatus.success,
              position: state.position + 1,
              history: state.history..add(joke),
              joke: joke));
        } else {
          emit(state.copyWith(
              status: JokeStatus.success,
              position: state.position + 1,
              joke: state.history[state.position + 1]));
        }
      } else {
        //We need to load a Joke from history
        emit(state.copyWith(
            status: JokeStatus.success,
            position: state.position + 1,
            joke: state.history[state.position + 1]));
      }
    } catch (e) {
      print(e);
      emit(state.copyWith(status: JokeStatus.failure));
    }
  }

  void _fetchPreviousJoke(FetchPreviousJoke event, Emitter<JokeState> emit) {
    if (state.isFirstJoke()) return;
    emit(state.copyWith(
        position: state.position - 1, joke: state.history[state.position - 1]));
  }

  void _editFavorite(EditFavorite event, Emitter<JokeState> emit) async {
    final newJoke = state.joke.copyWith(favorite: !state.joke.favorite);
    final newState = state.copyWith(
        status: JokeStatus.success,
        joke: newJoke,
        history: state.history
          ..removeAt(state.position)
          ..add(newJoke));
    await _jokesRepository.editJoke(newState.joke);
    emit(newState);
  }
}

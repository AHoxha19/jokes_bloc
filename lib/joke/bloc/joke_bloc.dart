import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jokes_repository/jokes_repository.dart';

part 'joke_event.dart';
part 'joke_state.dart';

class JokeBloc extends Bloc<JokeEvent, JokeState> {
  JokeBloc({required JokesRepository jokesRepository})
      : _jokesRepository = jokesRepository,
        super(JokeState()) {
    on<FetchJoke>(_fetchJoke);
    on<FetchPreviousJoke>(_fetchPreviousJoke);
    on<FetchNextJoke>(_fetchNextJoke);
  }

  final JokesRepository _jokesRepository;

  void _fetchJoke(FetchJoke event, Emitter<JokeState> emit) async {
    emit(state.copyWith(status: JokeStatus.loading));

    try {
      if (state.jokeMode == JokeMode.new_joke) {
        //We need to fetch a new Joke
        final joke = await _jokesRepository.getJoke(true);
        emit(state.copyWith(
            status: JokeStatus.success,
            history: state.history..add(joke),
            joke: joke));
      } else {
        //We need to load a Joke from history / localDB
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
        //We need to load a Joke from history / localDB
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
}

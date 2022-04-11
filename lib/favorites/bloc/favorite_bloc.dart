import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jokes_repository/jokes_repository.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc({required JokesRepository jokesRepository})
      : _jokesRepository = jokesRepository,
        super(const FavoriteState()) {
    on<GetAllFavorites>(_getFavoriteJokes);
  }

  final JokesRepository _jokesRepository;

  void _getFavoriteJokes(
      GetAllFavorites event, Emitter<FavoriteState> emit) async {
    emit(state.copyWith(status: FavoriteStatus.loading));

    try {
      final jokes = await _jokesRepository.getFavoriteJokes();
      if (jokes.isEmpty) {
        emit(state.copyWith(status: FavoriteStatus.empty));
        return;
      }
      emit(state.copyWith(jokes: jokes, status: FavoriteStatus.success));
    } on Exception {
      emit(state.copyWith(status: FavoriteStatus.failure));
    }
  }
}

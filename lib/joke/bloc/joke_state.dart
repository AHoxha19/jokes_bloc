part of 'joke_bloc.dart';

enum JokeStatus { initial, loading, success, failure }
enum JokeMode { new_joke, history_joke }

class JokeState extends Equatable {
  JokeState(
      {int? position,
      List<Joke>? history,
      JokeStatus? status,
      Joke? joke,
      JokeMode? jokeMode})
      : joke = joke ?? Joke.empty,
        status = status ?? JokeStatus.initial,
        position = position ?? 0,
        history = history ?? [],
        jokeMode = jokeMode ?? JokeMode.new_joke;

  final JokeStatus status;
  final Joke joke;
  final int position;
  final List<Joke> history;
  final JokeMode jokeMode;

  bool isFirstJoke() {
    return position == 0;
  }

  JokeState copyWith(
      {int? position,
      List<Joke>? history,
      JokeStatus? status,
      Joke? joke,
      JokeMode? jokeMode}) {
    return JokeState(
        status: status ?? this.status,
        position: position ?? this.position,
        joke: joke ?? this.joke,
        history: history ?? this.history,
        jokeMode: jokeMode ?? this.jokeMode);
  }

  @override
  String toString() {
    // TODO: implement toString
    return "jokeState: position: $position, history: ${history.length}, status: ${status.toString()}, joke: ${joke}, jokeMode:${jokeMode.toString()}";
  }

  @override
  List<Object> get props => [position, history, status, joke, jokeMode];
}

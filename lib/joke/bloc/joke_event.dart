part of 'joke_bloc.dart';

abstract class JokeEvent extends Equatable {
  const JokeEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchJoke extends JokeEvent {
  const FetchJoke();
}

class FetchNextJoke extends JokeEvent {
  const FetchNextJoke();
}

class FetchPreviousJoke extends JokeEvent {
  const FetchPreviousJoke();
}

class EditFavorite extends JokeEvent {
  const EditFavorite();
}

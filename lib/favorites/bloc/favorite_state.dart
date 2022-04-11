part of 'favorite_bloc.dart';

enum FavoriteStatus { initial, empty, loading, success, failure }

//initial is for empty and success when we have data

class FavoriteState extends Equatable {
  const FavoriteState(
      {this.status = FavoriteStatus.initial, this.jokes = const []});

  final FavoriteStatus status;
  final List<Joke> jokes;

  FavoriteState copyWith({FavoriteStatus? status, List<Joke>? jokes}) {
    return FavoriteState(
        status: status ?? this.status, jokes: jokes ?? this.jokes);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, jokes];
}

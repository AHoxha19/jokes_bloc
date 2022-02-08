import 'package:jokes_api/jokes_api.dart' as jokes_api;
import 'package:jokes_repository/jokes_repository.dart';

class JokesRepository {
  //TODO: Get Jokes from Local DB

  JokesRepository({jokes_api.JokesApiClient? jokesApiClient})
      : _jokesApiClient = jokesApiClient ?? jokes_api.JokesApiClient();

  final jokes_api.JokesApiClient _jokesApiClient;

  Future<Joke> getJoke(bool safe) async {
    final jokeData = await _jokesApiClient.getJoke(safe);

    return Joke(
        category: jokeData.category.toJokeCategory,
        joke: jokeData.joke,
        safe: jokeData.safe);
  }

  Future<List<Joke>> getFavoriteJokes() async {
    final jokes = await Future.delayed(Duration(seconds: 3));
    return [];
  }

  void saveJoke() {
    //TODO: Save Joke in local DB.
  }
}

extension on jokes_api.JokeCategory {
  JokeCategory get toJokeCategory {
    switch (this) {
      case jokes_api.JokeCategory.misc:
        return JokeCategory.misc;
      case jokes_api.JokeCategory.programming:
        return JokeCategory.programming;
      case jokes_api.JokeCategory.dark:
        return JokeCategory.dark;
      case jokes_api.JokeCategory.pun:
        return JokeCategory.pun;
      case jokes_api.JokeCategory.spooky:
        return JokeCategory.spooky;
      case jokes_api.JokeCategory.christmas:
        return JokeCategory.christmas;
      default:
        return JokeCategory.unknown;
    }
  }
}

import 'package:jokes_api/jokes_api.dart' as jokes_api;
import 'package:jokes_storage/jokes_storage.dart';

class JokesRepository {
  //TODO: Get Jokes from Local DB

  JokesRepository(
      {jokes_api.JokesApiClient? jokesApiClient, JokesStorage? jokesStorage})
      : _jokesApiClient = jokesApiClient ?? jokes_api.JokesApiClient(),
        _jokesStorage = jokesStorage ?? JokesStorage();

  final jokes_api.JokesApiClient _jokesApiClient;
  final JokesStorage _jokesStorage;

  Future<Joke> getJoke(bool safe) async {
    final jokeData = await _jokesApiClient.getJoke(safe);

    return Joke(
        id: jokeData.id,
        category: jokeData.category.toJokeCategory,
        joke: jokeData.joke,
        safe: jokeData.safe,
        favorite: false);
  }

  Future<Joke> getJokeFromStorage(int id) async {
    final joke = await _jokesStorage.getJoke(id);
    return joke;
  }

  Future<List<Joke>> getFavoriteJokes() async {
    final jokesData = await _jokesStorage.getJokes();
    final jokes = jokesData
        .map((e) => Joke(
            id: e.id,
            category: e.category,
            joke: e.joke,
            safe: e.safe,
            favorite: true))
        .toList();
    return jokes;
  }

  Future<int> editJoke(Joke joke) async {
    //TODO: Save Joke in local DB.
    if (joke.favorite) {
      return await _jokesStorage.insert(joke);
    } else {
      return await _jokesStorage.remove(joke);
    }
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

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jokes_api/jokes_api.dart';

class JokeRequestFailure implements Exception {}

class JokeNotFoundFailure implements Exception {}

class JokesApiClient {
  JokesApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;
  static const _baseUrl = 'v2.jokeapi.dev';

  //"https://v2.jokeapi.dev/joke/Any?type=single" &safe-mode

  Future<JokeData> getJoke(bool safe) async {
    final jokeRequest = Uri.https(
        _baseUrl, '/joke/Any', {'type': 'single', safe ? 'safe-mode' : '': ''});
    final jokeResponse = await _httpClient.get(jokeRequest);

    if (jokeResponse.statusCode != 200) {
      throw JokeRequestFailure();
    }

    final jokeJson = jsonDecode(jokeResponse.body) as Map<String, dynamic>;

    if (jokeJson.isEmpty) {
      throw JokeNotFoundFailure();
    }

    return JokeData.fromJson(jokeJson);
  }
}

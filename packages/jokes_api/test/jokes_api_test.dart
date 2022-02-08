// ignore_for_file: prefer_const_constructors
import 'package:http/http.dart' as http;
import 'package:jokes_api/jokes_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('JokeApiClient', () {
    late http.Client httpClient;
    late JokesApiClient jokesApiClient;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      jokesApiClient = JokesApiClient(httpClient: httpClient);
    });

    group('getJoke', () {
      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await jokesApiClient.getJoke(true);
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.https('v2.jokeapi.dev', '/joke/Any?type=single'),
          ),
        ).called(1);
      });

      test('throws JokeRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await jokesApiClient.getJoke(false),
          throwsA(isA<JokeRequestFailure>()),
        );
      });

      test('throws JokeNotFoundFailure on empty response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await jokesApiClient.getJoke(false),
          throwsA(isA<JokeNotFoundFailure>()),
        );
      });

      test('returns joke on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('''
          {
    "error": false,
    "category": "Programming",
    "type": "single",
    "joke": "The glass is neither half-full nor half-empty, the glass is twice as big as it needs to be.",
    "flags": {
        "nsfw": false,
        "religious": false,
        "political": false,
        "racist": false,
        "sexist": false,
        "explicit": false
    },
    "id": 23,
    "safe": true,
    "lang": "en"
}
        ''');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await jokesApiClient.getJoke(false);
        expect(
            actual,
            isA<JokeData>()
                .having((w) => w.error, 'error', false)
                .having((w) => w.category, 'category', JokeCategory.programming)
                .having((w) => w.type, 'type', JokeType.single)
                .having((w) => w.joke, 'joke',
                    "The glass is neither half-full nor half-empty, the glass is twice as big as it needs to be.")
                .having((w) => w.id, 'id', 23)
                .having((w) => w.safe, 'safe', true)
                .having((w) => w.lang, 'lang', "en"));
      });
    });
  });
}

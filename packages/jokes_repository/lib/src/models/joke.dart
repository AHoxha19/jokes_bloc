import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'joke.g.dart';

enum JokeCategory { misc, programming, dark, pun, spooky, christmas, unknown }

extension CategoryString on JokeCategory {
  String asString() {
    String category = toString().split('.').last;
    category = category[0].toUpperCase() + category.substring(1);
    return category;
  }
}

@JsonSerializable()
class Joke extends Equatable {
  Joke({
    required this.category,
    required this.joke,
    required this.safe,
  });

  factory Joke.fromJson(Map<String, dynamic> json) => _$JokeFromJson(json);

  final JokeCategory category;
  final String joke;
  final bool safe;

  Joke copyWith({
    required JokeCategory category,
    required String joke,
    required bool safe,
  }) {
    return Joke(category: category, joke: joke, safe: safe);
  }

  static final empty =
      Joke(category: JokeCategory.unknown, joke: "--", safe: false);

  @override
  // TODO: implement props
  List<Object?> get props => [category, joke, safe];
}

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

JokeCategory fromString(String category) {
  switch (category) {
    case "Misc":
      return JokeCategory.misc;
    case "Programming":
      return JokeCategory.programming;
    case "Dark":
      return JokeCategory.dark;
    case "Pun":
      return JokeCategory.pun;
    case "Christmas":
      return JokeCategory.christmas;
    case "Spooky":
      return JokeCategory.spooky;
    default:
      return JokeCategory.unknown;
  }
}

@JsonSerializable()
class Joke extends Equatable {
  Joke(
      {required this.id,
      required this.category,
      required this.joke,
      required this.safe,
      required this.favorite});

  factory Joke.fromJson(Map<String, dynamic> json) => _$JokeFromJson(json);

  final int id;
  final JokeCategory category;
  final String joke;
  final bool safe;
  final bool favorite;

  Joke copyWith(
      {int? id,
      JokeCategory? category,
      String? joke,
      bool? safe,
      bool? favorite}) {
    return Joke(
        id: id ?? this.id,
        category: category ?? this.category,
        joke: joke ?? this.joke,
        safe: safe ?? this.safe,
        favorite: favorite ?? this.favorite);
  }

  Map<String, dynamic> toSqlite() => {
        'id': id,
        'category': category.asString(),
        'joke': joke,
        'safe': safe ? 1 : 0,
        'favorite': favorite ? 1 : 0
      };

  Joke.fromSqlite(Map<String, dynamic> data)
      : id = data['id'],
        category = fromString(data['category'] as String),
        joke = data['joke'],
        safe = data['safe'] > 0 ? true : false,
        favorite = data['favorite'] > 0 ? true : false;

  static final empty = Joke(
      id: -1,
      category: JokeCategory.unknown,
      joke: "--",
      safe: false,
      favorite: false);

  @override
  // TODO: implement props
  List<Object?> get props => [category, joke, safe, favorite];
}

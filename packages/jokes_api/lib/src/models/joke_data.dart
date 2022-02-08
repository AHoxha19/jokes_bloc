import 'package:json_annotation/json_annotation.dart';

part 'joke_data.g.dart';

enum JokeType {
  @JsonValue('single')
  single,
  @JsonValue('twopart')
  twoPart
}

enum JokeCategory {
  @JsonValue('Misc')
  misc,
  @JsonValue('Programming')
  programming,
  @JsonValue('Dark')
  dark,
  @JsonValue('Pun')
  pun,
  @JsonValue('Spooky')
  spooky,
  @JsonValue('Christmas')
  christmas
}

@JsonSerializable()
class JokeData {
  JokeData({
    required this.error,
    required this.category,
    required this.type,
    required this.joke,
    required this.flags,
    required this.id,
    required this.safe,
    required this.lang,
  });

  factory JokeData.fromJson(Map<String, dynamic> json) =>
      _$JokeDataFromJson(json);

  final bool error;
  final JokeCategory category;
  final JokeType type;
  final String joke;
  final Flags flags;
  final int id;
  final bool safe;
  final String lang;
}

@JsonSerializable()
class Flags {
  Flags({
    required this.nsfw,
    required this.religious,
    required this.political,
    required this.racist,
    required this.sexist,
    required this.explicit,
  });

  factory Flags.fromJson(Map<String, dynamic> json) => _$FlagsFromJson(json);

  final bool nsfw;
  final bool religious;
  final bool political;
  final bool racist;
  final bool sexist;
  final bool explicit;
}

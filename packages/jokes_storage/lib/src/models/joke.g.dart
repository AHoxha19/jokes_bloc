// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'joke.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Joke _$JokeFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Joke',
      json,
      ($checkedConvert) {
        final val = Joke(
          id: $checkedConvert('id', (v) => v as int),
          category: $checkedConvert(
              'category', (v) => $enumDecode(_$JokeCategoryEnumMap, v)),
          joke: $checkedConvert('joke', (v) => v as String),
          safe: $checkedConvert('safe', (v) => v as bool),
          favorite: $checkedConvert('favorite', (v) => v as bool),
        );
        return val;
      },
    );

Map<String, dynamic> _$JokeToJson(Joke instance) => <String, dynamic>{
      'id': instance.id,
      'category': _$JokeCategoryEnumMap[instance.category],
      'joke': instance.joke,
      'safe': instance.safe,
      'favorite': instance.favorite,
    };

const _$JokeCategoryEnumMap = {
  JokeCategory.misc: 'misc',
  JokeCategory.programming: 'programming',
  JokeCategory.dark: 'dark',
  JokeCategory.pun: 'pun',
  JokeCategory.spooky: 'spooky',
  JokeCategory.christmas: 'christmas',
  JokeCategory.unknown: 'unknown',
};

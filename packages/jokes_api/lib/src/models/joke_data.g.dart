// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'joke_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JokeData _$JokeDataFromJson(Map<String, dynamic> json) => $checkedCreate(
      'JokeData',
      json,
      ($checkedConvert) {
        final val = JokeData(
          error: $checkedConvert('error', (v) => v as bool),
          category: $checkedConvert(
              'category', (v) => $enumDecode(_$JokeCategoryEnumMap, v)),
          type:
              $checkedConvert('type', (v) => $enumDecode(_$JokeTypeEnumMap, v)),
          joke: $checkedConvert('joke', (v) => v as String),
          flags: $checkedConvert(
              'flags', (v) => Flags.fromJson(v as Map<String, dynamic>)),
          id: $checkedConvert('id', (v) => v as int),
          safe: $checkedConvert('safe', (v) => v as bool),
          lang: $checkedConvert('lang', (v) => v as String),
        );
        return val;
      },
    );

const _$JokeCategoryEnumMap = {
  JokeCategory.misc: 'Misc',
  JokeCategory.programming: 'Programming',
  JokeCategory.dark: 'Dark',
  JokeCategory.pun: 'Pun',
  JokeCategory.spooky: 'Spooky',
  JokeCategory.christmas: 'Christmas',
};

const _$JokeTypeEnumMap = {
  JokeType.single: 'single',
  JokeType.twoPart: 'twopart',
};

Flags _$FlagsFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Flags',
      json,
      ($checkedConvert) {
        final val = Flags(
          nsfw: $checkedConvert('nsfw', (v) => v as bool),
          religious: $checkedConvert('religious', (v) => v as bool),
          political: $checkedConvert('political', (v) => v as bool),
          racist: $checkedConvert('racist', (v) => v as bool),
          sexist: $checkedConvert('sexist', (v) => v as bool),
          explicit: $checkedConvert('explicit', (v) => v as bool),
        );
        return val;
      },
    );

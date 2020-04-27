import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_type.freezed.dart';

enum PokemonType {
  normal,
  fighting,
  poison,
  ground,
  flying,
  bug,
  rock,
  ghost,
  steel,
  fire,
  water,
  electric,
  grass,
  ice,
  psychic,
  dragon,
  dark,
  fairy,
}

@freezed
abstract class PokemonTypeData with _$PokemonTypeData {
  const factory PokemonTypeData({
    @Default('') String name,
    @Default(Color(0x00000000)) Color color,
    @Default({}) Set<PokemonType> weaknesses,
    @Default({}) Set<PokemonType> strengths,
    @Default({}) Set<PokemonType> immunities,
  }) = _PokemonTypeData;
}

extension PokemonTypeDataProviding on PokemonType {
  String get name => data.name;
  Color get color => data.color;
  Set<PokemonType> get weaknesses => data.weaknesses;
  Set<PokemonType> get strengths => data.strengths;
  Set<PokemonType> get immunities => data.immunities;

  PokemonTypeData get data {
    switch (this) {
      case PokemonType.normal:
        return const PokemonTypeData(
          name: 'ノーマル',
          color: Color(0xFFB8B895),
          weaknesses: {PokemonType.fighting},
          immunities: {PokemonType.ghost},
        );
      case PokemonType.fighting:
        return const PokemonTypeData(
          name: 'かくとう',
          color: Color(0xFF87352F),
          weaknesses: {PokemonType.flying, PokemonType.psychic},
          strengths: {PokemonType.bug, PokemonType.rock},
        );
      case PokemonType.poison:
        return const PokemonTypeData(
          name: 'どく',
          color: Color(0xFF9B5EA7),
          weaknesses: {
            PokemonType.ground,
            PokemonType.bug,
            PokemonType.psychic,
          },
          strengths: {
            PokemonType.fighting,
            PokemonType.poison,
            PokemonType.grass,
          },
        );
      case PokemonType.ground:
        return const PokemonTypeData(
          name: 'じめん',
          color: Color(0xFFE3CA8E),
          weaknesses: {
            PokemonType.water,
            PokemonType.grass,
            PokemonType.ice,
          },
          strengths: {PokemonType.poison, PokemonType.rock},
          immunities: {PokemonType.electric},
        );
      case PokemonType.flying:
        return const PokemonTypeData(
          name: 'ひこう',
          color: Color(0xFFB2BDEA),
          weaknesses: {
            PokemonType.rock,
            PokemonType.electric,
            PokemonType.ice,
          },
          strengths: {
            PokemonType.fighting,
            PokemonType.bug,
            PokemonType.grass,
          },
          immunities: {PokemonType.ground},
        );
      case PokemonType.bug:
        return const PokemonTypeData(
          name: 'むし',
          color: Color(0xFFBDB85F),
          weaknesses: {
            PokemonType.flying,
            PokemonType.rock,
            PokemonType.fire,
          },
          strengths: {
            PokemonType.fighting,
            PokemonType.ground,
            PokemonType.grass,
          },
        );
      case PokemonType.rock:
        return const PokemonTypeData(
          name: 'いわ',
          color: Color(0xFFC1A75F),
          weaknesses: {
            PokemonType.fighting,
            PokemonType.ground,
            PokemonType.water,
            PokemonType.grass,
            PokemonType.steel,
          },
          strengths: {
            PokemonType.normal,
            PokemonType.poison,
            PokemonType.flying,
            PokemonType.fire,
          },
        );
      case PokemonType.ghost:
        return const PokemonTypeData(
          name: 'ゴースト',
          color: Color(0xFF6B6BA1),
          weaknesses: {PokemonType.ghost, PokemonType.dark},
          strengths: {PokemonType.poison, PokemonType.bug},
          immunities: {PokemonType.normal, PokemonType.fighting},
        );
      case PokemonType.steel:
        return const PokemonTypeData(
          name: 'はがね',
          color: Color(0xFFC7D4E0),
          weaknesses: {
            PokemonType.fighting,
            PokemonType.ground,
            PokemonType.fire,
          },
          strengths: {
            PokemonType.normal,
            PokemonType.flying,
            PokemonType.bug,
            PokemonType.rock,
            PokemonType.steel,
            PokemonType.grass,
            PokemonType.ice,
            PokemonType.psychic,
            PokemonType.dragon,
            PokemonType.fairy,
          },
          immunities: {PokemonType.poison},
        );
      case PokemonType.fire:
        return const PokemonTypeData(
          name: 'ほのお',
          color: Color(0xFFDC5949),
          weaknesses: {
            PokemonType.ground,
            PokemonType.rock,
            PokemonType.water,
          },
          strengths: {
            PokemonType.bug,
            PokemonType.steel,
            PokemonType.fire,
            PokemonType.grass,
            PokemonType.ice,
            PokemonType.fairy,
          },
        );
      case PokemonType.water:
        return const PokemonTypeData(
          name: 'みず',
          color: Color(0xFF73B8EA),
          weaknesses: {PokemonType.electric, PokemonType.grass},
          strengths: {
            PokemonType.steel,
            PokemonType.fire,
            PokemonType.water,
            PokemonType.ice,
          },
        );
      case PokemonType.electric:
        return const PokemonTypeData(
          name: 'でんき',
          color: Color(0xFFF2D479),
          weaknesses: {PokemonType.ground},
          strengths: {
            PokemonType.flying,
            PokemonType.steel,
            PokemonType.electric,
          },
        );
      case PokemonType.grass:
        return const PokemonTypeData(
          name: 'くさ',
          color: Color(0xFF95C779),
          weaknesses: {
            PokemonType.poison,
            PokemonType.flying,
            PokemonType.bug,
            PokemonType.fire,
            PokemonType.ice,
          },
          strengths: {
            PokemonType.ground,
            PokemonType.water,
            PokemonType.electric,
            PokemonType.grass,
          },
        );
      case PokemonType.ice:
        return const PokemonTypeData(
          name: 'こおり',
          color: Color(0xFFB8E7E7),
          weaknesses: {
            PokemonType.fighting,
            PokemonType.rock,
            PokemonType.steel,
            PokemonType.fire,
          },
          strengths: {PokemonType.ice},
        );
      case PokemonType.psychic:
        return const PokemonTypeData(
          name: 'エスパー',
          color: Color(0xFFE36C9B),
          weaknesses: {
            PokemonType.bug,
            PokemonType.ghost,
            PokemonType.dark,
          },
          strengths: {PokemonType.fighting, PokemonType.psychic},
        );
      case PokemonType.dragon:
        return const PokemonTypeData(
          name: 'ドラゴン',
          color: Color(0xFF6686E3),
          weaknesses: {
            PokemonType.ice,
            PokemonType.dragon,
            PokemonType.fairy,
          },
          strengths: {
            PokemonType.fire,
            PokemonType.water,
            PokemonType.electric,
            PokemonType.grass,
          },
        );
      case PokemonType.dark:
        return const PokemonTypeData(
          name: 'あく',
          color: Color(0xFF6C594E),
          weaknesses: {
            PokemonType.fighting,
            PokemonType.bug,
            PokemonType.fairy
          },
          strengths: {PokemonType.ghost, PokemonType.dark},
          immunities: {PokemonType.psychic},
        );
      case PokemonType.fairy:
        return const PokemonTypeData(
          name: 'フェアリー',
          color: Color(0xFFFA90BA),
          weaknesses: {PokemonType.poison, PokemonType.steel},
          strengths: {
            PokemonType.fighting,
            PokemonType.bug,
            PokemonType.dark,
          },
          immunities: {PokemonType.dragon},
        );
      default: return const PokemonTypeData();
    }
  }
}

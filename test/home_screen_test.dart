import 'package:built_collection/built_collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pkmn_tb_checker/models/party/party_score.dart';
import 'package:pkmn_tb_checker/models/pokemon/pokemon.dart';

import 'package:tuple/tuple.dart';

void main() {
  group('total party score', () {
    test('indicates 0 by evaluating empty list', () {
      expect(PartyScore(BuiltList<PokemonTypeCombination>()).total, 0);
    });

    test('indicates 50 by evaluating kanto starting pokemons', () {
      final typeCombinations = BuiltList<PokemonTypeCombination>([
        PokemonTypeCombination(BuiltSet({PokemonType.grass, PokemonType.poison})),
        PokemonTypeCombination(BuiltSet({PokemonType.fire})),
        PokemonTypeCombination(BuiltSet({PokemonType.water})),
      ]);
      expect(PartyScore(typeCombinations).total, 50);
    });

    test('indicates 100 by evaluating perfect party', () {
      final typeCombinations = BuiltList<PokemonTypeCombination>([
        PokemonTypeCombination(BuiltSet({PokemonType.fighting})),
        PokemonTypeCombination(BuiltSet({PokemonType.ground})),
        PokemonTypeCombination(BuiltSet({PokemonType.steel})),
        PokemonTypeCombination(BuiltSet({PokemonType.fairy})),
        PokemonTypeCombination(BuiltSet({PokemonType.water, PokemonType.flying})),
        PokemonTypeCombination(BuiltSet({PokemonType.electric, PokemonType.dark})),
      ]);
      expect(PartyScore(typeCombinations).total, 100);
    });
  });

  test('evaluating each of kanto starter pokemons', () {
    final partyScore = PartyScore(BuiltList([
      PokemonTypeCombination(BuiltSet({PokemonType.grass, PokemonType.poison})),
      PokemonTypeCombination(BuiltSet({PokemonType.fire})),
      PokemonTypeCombination(BuiltSet({PokemonType.water})),
    ]));

    expect(partyScore.individualScore(0), 11);
    expect(partyScore.individualScore(1), 14);
    expect(partyScore.individualScore(2), 3);
  });

  test('calculating additional type scores for kanto starter pokemons', () {
    final partyScore = PartyScore(BuiltList([
      PokemonTypeCombination(BuiltSet({PokemonType.grass, PokemonType.poison})),
      PokemonTypeCombination(BuiltSet({PokemonType.fire})),
      PokemonTypeCombination(BuiltSet({PokemonType.water})),
    ]));
    final additionalTypeScores = partyScore.additionalTypeScores();

    expect(additionalTypeScores.length, 7);
    expect(additionalTypeScores[0], Tuple2(17, 'はがね'));
    expect(additionalTypeScores[1], Tuple2(14, 'あく'));
    expect(additionalTypeScores[2], Tuple2(11, 'じめん, むし, いわ, ゴースト, フェアリー'));
    expect(additionalTypeScores[3], Tuple2(8, 'かくとう, エスパー'));
    expect(additionalTypeScores[4], Tuple2(6, 'ひこう, でんき, こおり'));
    expect(additionalTypeScores[5], Tuple2(3, 'ノーマル, どく, くさ, ドラゴン'));
    expect(additionalTypeScores[6], Tuple2(0, 'ほのお, みず'));
  });
}

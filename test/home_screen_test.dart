import 'package:flutter_test/flutter_test.dart';
import 'package:pkmn_tb_checker/models/party/party_score.dart';

import 'package:pkmn_tb_checker/models/pokemon/pokemon_type.dart';
import 'package:pkmn_tb_checker/models/pokemon/pokemon_type_combination.dart';
import 'package:tuple/tuple.dart';

void main() {
  group('total party score', () {
    test('indicates 0 by evaluating empty list', () {
      expect(PartyScore([]).total, 0);
    });

    test('indicates 50 by evaluating kanto starting pokemons', () {
      final typeCombinations = [
        PokemonTypeCombination({PokemonType.grass, PokemonType.poison}),
        PokemonTypeCombination({PokemonType.fire}),
        PokemonTypeCombination({PokemonType.water}),
      ];
      expect(PartyScore(typeCombinations).total, 50);
    });

    test('indicates 100 by evaluating perfect party', () {
      final typeCombinations = [
        PokemonTypeCombination({PokemonType.fighting}),
        PokemonTypeCombination({PokemonType.ground}),
        PokemonTypeCombination({PokemonType.steel}),
        PokemonTypeCombination({PokemonType.fairy}),
        PokemonTypeCombination({PokemonType.water, PokemonType.flying}),
        PokemonTypeCombination({PokemonType.electric, PokemonType.dark}),
      ];
      expect(PartyScore(typeCombinations).total, 100);
    });
  });

  test('evaluating each of kanto starter pokemons', () {
    final partyScore = PartyScore([
      PokemonTypeCombination({PokemonType.grass, PokemonType.poison}),
      PokemonTypeCombination({PokemonType.fire}),
      PokemonTypeCombination({PokemonType.water}),
    ]);

    expect(partyScore.individualScore(0), 11);
    expect(partyScore.individualScore(1), 14);
    expect(partyScore.individualScore(2), 3);
  });

  test('calculating additional type scores for kanto starter pokemons', () {
    final partyScore = PartyScore([
      PokemonTypeCombination({PokemonType.grass, PokemonType.poison}),
      PokemonTypeCombination({PokemonType.fire}),
      PokemonTypeCombination({PokemonType.water}),
    ]);
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

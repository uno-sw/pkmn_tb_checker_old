import 'package:built_collection/built_collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
import 'package:pkmn_tb_checker/models/pokemon/pokemon.dart';

part 'party_score.freezed.dart';

class PartyScore {
  const PartyScore(this.typeCombinations);

  PartyScore.fromPokemons(BuiltList<Pokemon> pokemons)
      : this(pokemons.map((pokemon) => pokemon.typeCombination).toBuiltList());

  final BuiltList<PokemonTypeCombination> typeCombinations;

  int get total => _scoreOf(typeCombinations.toList());

  int individualScore(int index) {
    RangeError.checkValidIndex(index, typeCombinations);
    final others = List.of(typeCombinations)..removeAt(index);
    return total - _scoreOf(others);
  }

  int scoreIncreaseByAdding(PokemonType type) {
    final tc = List.of(typeCombinations)
      ..add(PokemonTypeCombination(BuiltSet({type})));
    return _scoreOf(tc) - total;
  }

  List<ScoredPokemonTypeList> additionalTypeScores() {
    final scoreMap = <int, List<PokemonType>>{};
    for (var type in PokemonType.values) {
      final score = scoreIncreaseByAdding(type);
      if (scoreMap[score] == null) {
        scoreMap[score] = [type];
      } else {
        scoreMap[score].add(type);
      }
    }
    return scoreMap.entries
        .map((entry) =>
            ScoredPokemonTypeList(score: entry.key, types: entry.value))
        .toList()
        ..removeWhere((element) => element.score == 0)
        ..sort((a, b) => b.score.compareTo(a.score));
  }

  static int _scoreOf(List<PokemonTypeCombination> typeCombinations) {
    var score = 100.0;
    var weaknessSub = score * 0.5 / PokemonType.values.length;
    var advantageSub = weaknessSub;

    for (var type in PokemonType.values) {
      if (typeCombinations.every((typeCombination) =>
      typeCombination.damageFactorCausedBy(type) >= 1.0)) {
        score -= weaknessSub;
      }

      if (typeCombinations.every((typeCombination) =>
      !typeCombination.canHitWeaknessWithSTAB(type))) {
        score -= advantageSub;
      }
    }

    return score.round();
  }
}

@freezed
abstract class ScoredPokemonTypeList with _$ScoredPokemonTypeList {
  const factory ScoredPokemonTypeList({
    @required int score,
    @Default([]) Iterable<PokemonType> types,
  }) = _ScoredPokemonTypeList;
}
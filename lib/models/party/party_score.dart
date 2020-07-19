import 'package:built_collection/built_collection.dart';
import 'package:pkmn_tb_checker/models/pokemon/pokemon.dart';
import 'package:tuple/tuple.dart';

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

  List<Tuple2<int, String>> additionalTypeScores() {
    final scoreMap = <int, String>{};
    for (var type in PokemonType.values) {
      final score = scoreIncreaseByAdding(type);
      if (scoreMap[score] == null) {
        scoreMap[score] = type.name;
      } else {
        scoreMap[score] += ', ${type.name}';
      }
    }
    return scoreMap.entries
        .map((entry) => Tuple2(entry.key, entry.value))
        .toList()
        ..removeWhere((element) => element.item1 == 0)
        ..sort((a, b) => b.item1.compareTo(a.item1));
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
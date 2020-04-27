import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pkmn_tb_checker/models/pokemon/pokemon_type.dart';
import 'package:pkmn_tb_checker/models/pokemon/pokemon_type_combination.dart';
import 'package:tuple/tuple.dart';

part 'party_score.freezed.dart';

@freezed
abstract class PartyScore implements _$PartyScore {
  PartyScore._();
  factory PartyScore(List<PokemonTypeCombination> typeCombinations)
      = _PartyScore;

  int get total => _scoreOf(typeCombinations);

  int individualScore(int index) {
    RangeError.checkValidIndex(index, typeCombinations);
    final others = List.of(typeCombinations)..removeAt(index);
    return total - _scoreOf(others);
  }

  int scoreIncreaseByAdding(PokemonType type) {
    final tc = List.of(typeCombinations)
      ..add(PokemonTypeCombination({type}));
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

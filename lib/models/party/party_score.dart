import 'package:meta/meta.dart';
import 'package:pkmn_tb_checker/models/pokemon/pokemon_type.dart';
import 'package:pkmn_tb_checker/models/pokemon/pokemon_type_combination.dart';
import 'package:tuple/tuple.dart';

class PartyScore {
  PartyScore({@required List<PokemonTypeCombination> typeCombinations})
      : assert(typeCombinations != null),
        _typeCombinations = typeCombinations,
        total = _scoreOf(typeCombinations);

  final List<PokemonTypeCombination> _typeCombinations;
  final int total;

  int individualScore(int index) {
    RangeError.checkValidIndex(index, _typeCombinations);
    final others = List.of(_typeCombinations)..removeAt(index);
    return total - _scoreOf(others);
  }

  int scoreIncreaseByAdding(PokemonType type) {
    final typeCombinations = List.of(_typeCombinations)
      ..add(PokemonTypeCombination({type}));
    return _scoreOf(typeCombinations) - total;
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

import 'package:meta/meta.dart';

import 'pokemon_type.dart';

@immutable
class PokemonTypeCombination {
  PokemonTypeCombination(this._types)
      : assert(_types != null),
        assert(_types.isNotEmpty && _types.length <= maxTypeCount);

  static const maxTypeCount = 2;
  static const weaknessDamageFactor = 2.0;
  static const strengthDamageFactor = 0.5;

  final Set<PokemonType> _types;

  List<PokemonType> get toList => List.unmodifiable(_types);

  double damageFactorCausedBy(PokemonType moveType) {
    var factor = 1.0;

    for (var type in _types) {
      if (type.immunities.contains(moveType)) {
        return 0.0;
      }

      if (type.weaknesses.contains(moveType)) {
        factor *= weaknessDamageFactor;
      }

      if (type.strengths.contains(moveType)) {
        factor *= strengthDamageFactor;
      }
    }

    return factor;
  }

  bool canHitWeaknessWithSTAB(PokemonType target) {
    return _types.any((type) =>
        target.weaknesses.contains(type));
  }

  @override
  int get hashCode {
    int result = 17;
    for (var type in toList..sort((a, b) => a.index.compareTo(b.index))) {
      result = 37 * result + type.hashCode;
    }
    return result;
  }

  @override
  bool operator ==(dynamic other) {
    if (other is! PokemonTypeCombination) return false;
    PokemonTypeCombination typeCombination = other;
    return (_types.length == typeCombination.toList.length &&
        _types.containsAll(typeCombination.toList));
  }
}

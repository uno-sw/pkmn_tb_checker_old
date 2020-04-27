import 'package:freezed_annotation/freezed_annotation.dart';

import 'pokemon_type.dart';

part 'pokemon_type_combination.freezed.dart';

@freezed
abstract class PokemonTypeCombination implements _$PokemonTypeCombination {
  PokemonTypeCombination._();
  factory PokemonTypeCombination(Set<PokemonType> types)
      = _PokemonTypeCombination;

  static const maxTypeCount = 2;
  static const weaknessDamageFactor = 2.0;
  static const strengthDamageFactor = 0.5;

  @late
  List<PokemonType> get toList => List.unmodifiable(types);

  double damageFactorCausedBy(PokemonType moveType) {
    var factor = 1.0;

    for (var type in types) {
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
    return types.any((type) =>
        target.weaknesses.contains(type));
  }
}

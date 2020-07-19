import 'package:built_collection/built_collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pkmn_tb_checker/models/pokemon/pokemon_type.dart';

export 'pokemon_type.dart';

part 'pokemon.freezed.dart';

@freezed
abstract class Pokemon with _$Pokemon {
  const factory Pokemon(String name, PokemonTypeCombination typeCombination)
      = _Pokemon;
}

@freezed
abstract class PokemonTypeCombination implements _$PokemonTypeCombination {
  PokemonTypeCombination._();
  factory PokemonTypeCombination(BuiltSet<PokemonType> types)
  = _PokemonTypeCombination;

  static const maxTypeCount = 2;
  static const weaknessDamageFactor = 2.0;
  static const strengthDamageFactor = 0.5;

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
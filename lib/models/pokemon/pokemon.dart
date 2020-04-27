import 'package:freezed_annotation/freezed_annotation.dart';

import 'pokemon_type_combination.dart';

part 'pokemon.freezed.dart';

@freezed
abstract class Pokemon with _$Pokemon {
  const factory Pokemon(String name, PokemonTypeCombination typeCombination)
      = _Pokemon;
}

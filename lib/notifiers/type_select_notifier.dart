import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:pkmn_tb_checker/models/pokemon/pokemon.dart';
import 'package:state_notifier/state_notifier.dart';

class TypeSelectNotifier extends StateNotifier<BuiltSet<PokemonType>> {
  TypeSelectNotifier({
    @required this.pokemonIndex,
    @required PokemonTypeCombination initialTypeCombination,
  }) : assert(pokemonIndex != null),
       assert(initialTypeCombination != null),
       super(initialTypeCombination.types);

  final int pokemonIndex;

  bool get maxCountSelected =>
      (state.length >= PokemonTypeCombination.maxTypeCount);
  bool get canSave => state.isNotEmpty;

  void select(PokemonType type) {
    if (maxCountSelected) return;
    state = state.rebuild((t) => t..add(type));
  }

  void unselect(PokemonType type) {
    state = state.rebuild((t) => t..remove(type));
  }
}
import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pkmn_tb_checker/models/pokemon/pokemon.dart';
import 'package:state_notifier/state_notifier.dart';

part 'type_select_notifier.freezed.dart';

@freezed
abstract class TypeSelectState implements _$TypeSelectState {
  TypeSelectState._();
  factory TypeSelectState({
    @required int pokemonIndex,
    @required BuiltSet<PokemonType> types,
  }) = _TypeSelectState;

  @late
  bool get maxCountSelected =>
      (types.length >= PokemonTypeCombination.maxTypeCount);

  @late
  bool get canSave => types.isNotEmpty;
}

class TypeSelectNotifier extends StateNotifier<TypeSelectState> {
  TypeSelectNotifier({
    @required int pokemonIndex,
    @required PokemonTypeCombination initialTypeCombination,
  })  : super(
          TypeSelectState(
            pokemonIndex: pokemonIndex,
            types: initialTypeCombination.types,
          ),
        );

  void select(PokemonType type) {
    if (state.maxCountSelected) return;
    state = state.copyWith(types: state.types.rebuild((t) => t..add(type)));
  }

  void deselect(PokemonType type) {
    state = state.copyWith(types: state.types.rebuild((t) => t..remove(type)));
  }
}
import 'package:built_collection/built_collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pkmn_tb_checker/models/pokemon/pokemon.dart';
import 'package:pkmn_tb_checker/notifiers/type_select_notifier.dart';

void main() {
  test('selecting pokemon types', () {
    final typeSelectNotifier = TypeSelectNotifier(
      pokemonIndex: 0,
      initialTypeCombination: PokemonTypeCombination(
        BuiltSet({PokemonType.normal}),
      ),
    );

    typeSelectNotifier.unselect(PokemonType.normal);
    expect(typeSelectNotifier.debugState, BuiltSet<PokemonType>());
    expect(typeSelectNotifier.canSave, false);

    typeSelectNotifier.select(PokemonType.steel);
    typeSelectNotifier.select(PokemonType.fairy);
    typeSelectNotifier.select(PokemonType.normal);
    expect(
      typeSelectNotifier.debugState,
      BuiltSet<PokemonType>({PokemonType.steel, PokemonType.fairy}),
    );
    expect(typeSelectNotifier.canSave, true);
  });
}
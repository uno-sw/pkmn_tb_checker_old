import 'package:flutter_test/flutter_test.dart';
import 'package:pkmn_tb_checker/models/pokemon/pokemon_type.dart';
import 'package:pkmn_tb_checker/models/pokemon/pokemon_type_combination.dart';
import 'package:pkmn_tb_checker/notifiers/type_select_notifier.dart';

void main() {
  test('selecting pokemon types', () {
    final typeSelectNotifier = TypeSelectNotifier(
      pokemonIndex: 0,
      initialTypeCombination: PokemonTypeCombination({PokemonType.normal}),
    );

    expect(typeSelectNotifier.unselect(PokemonType.fire), false);
    expect(typeSelectNotifier.unselect(PokemonType.normal), true);
    expect(typeSelectNotifier.canSave, false);
    expect(typeSelectNotifier.select(PokemonType.steel), true);
    expect(typeSelectNotifier.select(PokemonType.steel), false);
    expect(typeSelectNotifier.select(PokemonType.fairy), true);
    expect(typeSelectNotifier.select(PokemonType.normal), false);
    expect(typeSelectNotifier.canSave, true);
  });
}

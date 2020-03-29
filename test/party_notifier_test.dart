import 'package:flutter_test/flutter_test.dart';
import 'package:pkmn_tb_checker/models/pokemon/pokemon_type.dart';
import 'package:pkmn_tb_checker/models/pokemon/pokemon_type_combination.dart';
import 'package:pkmn_tb_checker/notifiers/party_notifier.dart';

void main() {
  test('Clearing all pokemons', () {
    final notifier = PartyNotifier();
    expect(notifier.pokemons.length, 3);
    notifier.removeAllPokemon();
    expect(notifier.pokemons.length, 0);
  });

  test('Creating and removing pokemons', () {
    final notifier = PartyNotifier()..createPokemon();
    expect(notifier.pokemons.last.name, 'ポケモン1');
    expect(notifier.pokemons.last.typeCombination.toList, [PokemonType.normal]);
    notifier.createPokemon();
    expect(notifier.pokemons.last.name, 'ポケモン2');
    notifier.removePokemon(3);
    expect(notifier.pokemons.length, 4);
    notifier.createPokemon();
    expect(notifier.pokemons.last.name, 'ポケモン1');
  });

  test('Renaming pokemon', () {
    final notifier = PartyNotifier();
    notifier.renamePokemon(0, 'ナゾノクサ');
    expect(notifier.pokemons.first.name, 'ナゾノクサ');
  });

  test('Updating types of pokemon', () {
    final notifier = PartyNotifier();
    notifier.updatePokemonTypeCombination(
      2,
      PokemonTypeCombination({PokemonType.steel, PokemonType.dragon}),
    );
    expect(
      notifier.pokemons[2].typeCombination.toList,
      [PokemonType.steel, PokemonType.dragon],
    );
  });
}

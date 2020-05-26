import 'package:built_collection/built_collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pkmn_tb_checker/models/pokemon/pokemon.dart';
import 'package:pkmn_tb_checker/models/pokemon/pokemon_type.dart';
import 'package:pkmn_tb_checker/notifiers/party_notifier.dart';

void main() {
  PartyNotifier notifier;

  setUp(() {
    notifier = PartyNotifier();
  });

  test('Clearing all pokemons', () {
    expect(notifier.debugState.length, 3);
    notifier.clear();
    expect(notifier.debugState.length, 0);
  });

  test('Creating and removing pokemons', () {
    notifier.createPokemon();
    expect(
      notifier.debugState,
      BuiltList<Pokemon>([
        ...PartyNotifier.initialPokemons,
        Pokemon(
          'ポケモン1',
          PokemonTypeCombination(BuiltSet({PokemonType.normal})),
        ),
      ]),
    );

    notifier.createPokemon();
    notifier.removePokemon(3);
    expect(
      notifier.debugState,
      BuiltList<Pokemon>([
        ...PartyNotifier.initialPokemons,
        Pokemon(
          'ポケモン2',
          PokemonTypeCombination(BuiltSet({PokemonType.normal})),
        ),
      ]),
    );
  });

  test('Renaming pokemon', () {
    notifier.updatePokemon(
      0,
      notifier.debugState[0].copyWith(name: 'ナゾノクサ'),
    );
    expect(notifier.debugState.first.name, 'ナゾノクサ');
  });

  test('Updating types of pokemon', () {
    notifier.updatePokemon(
      2,
      notifier.debugState[2].copyWith(
        typeCombination: PokemonTypeCombination(
          BuiltSet({PokemonType.steel, PokemonType.dragon}),
        ),
      ),
    );
    expect(
      notifier.debugState[2].typeCombination,
      PokemonTypeCombination(BuiltSet({PokemonType.steel, PokemonType.dragon})),
    );
  });
}

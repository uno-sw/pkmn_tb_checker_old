import 'package:flutter/material.dart';

import '../models/pokemon/pokemon.dart';
import '../models/pokemon/pokemon_type.dart';
import '../models/pokemon/pokemon_type_combination.dart';

class PartyNotifier with ChangeNotifier {
  final _pokemons = [
    Pokemon(
      'フシギダネ',
      PokemonTypeCombination({PokemonType.grass, PokemonType.poison}),
    ),
    Pokemon(
      'ヒトカゲ',
      PokemonTypeCombination({PokemonType.fire}),
    ),
    Pokemon(
      'ゼニガメ',
      PokemonTypeCombination({PokemonType.water}),
    ),
  ];

  List<Pokemon> get pokemons => List.unmodifiable(_pokemons);

  void createPokemon() {
    assert(_pokemons.length <= 5);
    final pokemon = Pokemon(
      _nameNewPokemon(),
      PokemonTypeCombination({PokemonType.normal}),
    );
    _pokemons.add(pokemon);
    notifyListeners();
  }

  void renamePokemon(int index, String name) {
    RangeError.checkValidIndex(index, _pokemons);
    _pokemons[index] = _pokemons[index].copyWith(name: name);
    notifyListeners();
  }

  void updatePokemonTypeCombination(
    int index,
    PokemonTypeCombination typeCombination,
  ) {
    RangeError.checkValidIndex(index, _pokemons);
    final pokemon = _pokemons[index];
    if (typeCombination == pokemon.typeCombination) return;
    _pokemons[index] = pokemon.copyWith(
      typeCombination: typeCombination,
    );
    notifyListeners();
  }

  void removePokemon(int index) {
    assert(index < _pokemons.length);
    _pokemons.removeAt(index);
    notifyListeners();
  }

  void removeAllPokemon() {
    _pokemons.clear();
    notifyListeners();
  }

  String _nameNewPokemon() {
    final base = 'ポケモン';
    var suffix = 1;
    
    while (_pokemons.any((p) =>
        p.name == base + suffix.toString())) {
      suffix++;
    }

    return '$base$suffix';
  }
}

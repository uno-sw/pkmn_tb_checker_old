import 'package:flutter/material.dart';

import '../models/pokemon/pokemon_type.dart';
import '../models/pokemon/pokemon_type_combination.dart';

class TypeSelectNotifier with ChangeNotifier {
  TypeSelectNotifier({
    @required this.pokemonIndex,
    @required PokemonTypeCombination initialTypeCombination,
  }) : assert(pokemonIndex != null),
       assert(initialTypeCombination != null),
       this._selectedTypes = initialTypeCombination.toList.toSet();

  final int pokemonIndex;
  final Set<PokemonType> _selectedTypes;

  List<PokemonType> get selectedTypes => List.unmodifiable(_selectedTypes);
  bool get maxCountSelected =>
      (_selectedTypes.length >= PokemonTypeCombination.maxTypeCount);
  bool get canSave => _selectedTypes.isNotEmpty;

  bool isSelected(PokemonType type) => _selectedTypes.contains(type);

  bool select(PokemonType type) {
    if (maxCountSelected) return false;
    final result = _selectedTypes.add(type);
    if (result) notifyListeners();
    return result;
  }

  bool unselect(PokemonType type) {
    final result = _selectedTypes.remove(type);
    if (result) notifyListeners();
    return result;
  }
}

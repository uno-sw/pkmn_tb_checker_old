import 'package:meta/meta.dart';

import 'pokemon_type.dart';
import 'pokemon_type_combination.dart';

@immutable
class Pokemon {
  Pokemon(this.name, this.typeCombination)
      : assert(name != null),
        assert(typeCombination != null);

  final String name;
  final PokemonTypeCombination typeCombination;

  List<PokemonType> get types => typeCombination.toList;

  Pokemon copyWith({String name, PokemonTypeCombination typeCombination}) {
    return Pokemon(
      name ?? this.name,
      typeCombination ?? this.typeCombination,
    );
  }
}

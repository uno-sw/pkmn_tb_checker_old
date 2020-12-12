import 'package:built_collection/built_collection.dart';
import 'package:pkmn_tb_checker/models/pokemon/pokemon.dart';
import 'package:state_notifier/state_notifier.dart';

class PartyNotifier extends StateNotifier<BuiltList<Pokemon>> {
  PartyNotifier([List<Pokemon> pokemons])
      : super(BuiltList(pokemons ?? initialPokemons));

  static const fixedNumber = 6;

  static final initialPokemons = <Pokemon>[
    Pokemon(
      'フシギダネ',
      PokemonTypeCombination(BuiltSet({PokemonType.grass, PokemonType.poison})),
    ),
    Pokemon(
      'ヒトカゲ',
      PokemonTypeCombination(BuiltSet({PokemonType.fire})),
    ),
    Pokemon(
      'ゼニガメ',
      PokemonTypeCombination(BuiltSet({PokemonType.water})),
    ),
  ];

  bool get isFull => state.length >= fixedNumber;

  void createPokemon([PokemonTypeCombination typeCombination]) {
    if (isFull) {
      throw StateError('Party is already full.');
    }
    
    final pokemon = Pokemon(
      _buildNewPokemonName(),
      typeCombination == null
          ? PokemonTypeCombination(BuiltSet({PokemonType.normal}))
          : typeCombination,
    );
    state = state.rebuild((list) => list..add(pokemon));
  }
  
  void updatePokemon(int index, Pokemon pokemon) {
    state = state.rebuild((list) => list..[index] = pokemon);
  }

  void removePokemon(int index) {
    state = state.rebuild((list) => list..removeAt(index));
  }

  void clear() {
    state = BuiltList<Pokemon>();
  }

  String _buildNewPokemonName() {
    final base = 'ポケモン';
    var suffix = 1;
    
    while (state.any((p) => p.name == base + suffix.toString())) {
      suffix++;
    }

    return '$base$suffix';
  }
}
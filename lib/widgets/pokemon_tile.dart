import 'package:flutter/material.dart';
import 'package:pkmn_tb_checker/models/party/party_score.dart';
import 'package:provider/provider.dart';

import 'pokemon_rename_dialog.dart';
import 'type_select_dialog.dart';
import '../models/pokemon/pokemon_type.dart';
import '../notifiers/party_notifier.dart';
import '../notifiers/type_select_notifier.dart';

class PokemonTile extends StatelessWidget {
  PokemonTile(this.index);

  final int index;

  @override
  Widget build(BuildContext context) {
    final partyNotifier = Provider.of<PartyNotifier>(context);
    final pokemons = partyNotifier.pokemons;
    final pokemon = pokemons[index];
    final partyScore = PartyScore(
      pokemons.map((pokemon) => pokemon.typeCombination).toList(),
    );

    return ListTile(
      title: Text(pokemon.name),
      subtitle: Text(pokemon.typeCombination.types.map(
          (type) => type.name).join(', ')),
      leading: CircleAvatar(
        child: Text(partyScore.individualScore(index).toString()),
      ),
      trailing: PopupMenuButton<PokemonTileMenu>(
        icon: const Icon(Icons.more_vert),
        onSelected: (value) {
          switch (value) {
            case PokemonTileMenu.rename:
              _showRenameDialog(context);
              break;
            case PokemonTileMenu.editTypeCombination:
              _showTypeSelectDialog(context);
              break;
            case PokemonTileMenu.remove:
              partyNotifier.removePokemon(index);
              break;
          }
        },
        itemBuilder: (_) => const [
          PopupMenuItem(
            value: PokemonTileMenu.rename,
            child: Text('名前を編集'),
          ),
          PopupMenuItem(
            value: PokemonTileMenu.editTypeCombination,
            child: Text('タイプを編集'),
          ),
          PopupMenuItem(
            value: PokemonTileMenu.remove,
            child: Text('削除'),
          ),
        ],
      ),
      // onTap: () => Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (_) => _SimpleListViewScreen(
      //       title: pokemon.name,
      //       children: PokemonType.values.map((type) {
      //         // final give = max<double>(
      //         //   Pokemon('', {type}).damageFactorCausedBy(pokemon.primaryType),
      //         //   Pokemon('', {type}).damageFactorCausedBy(pokemon.secondaryType),
      //         // );
      //         final give = 1.0;
      //         final take = pokemon.damageFactorCausedBy(type);
      //         return ListTile(
      //           title: Text(type.data.name),
      //           subtitle: Text(
      //             '攻撃する時: ${give}x, 受ける時: ${take}x',
      //           ),
      //         );
      //       }).toList(),
      //     ),
      //   ),
      // ),
      onTap: () {},
    );      
  }

  void _showRenameDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => ChangeNotifierProvider<TextEditingController>(
        create: (_) => TextEditingController(
          text: Provider.of<PartyNotifier>(context).pokemons[index].name,
        ),
        child: PokemonRenameDialog(index),
      ),
    );
  }

  void _showTypeSelectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => ChangeNotifierProvider<TypeSelectNotifier>(
        create: (_) => TypeSelectNotifier(
          pokemonIndex: index,
          initialTypeCombination: Provider.of<PartyNotifier>(context)
              .pokemons[index].typeCombination,
        ),
        child: const TypeSelectDialog(),
      ),
    );
  }
}

enum PokemonTileMenu {
  rename,
  editTypeCombination,
  remove,
}

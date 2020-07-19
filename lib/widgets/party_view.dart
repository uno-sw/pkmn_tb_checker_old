import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:pkmn_tb_checker/models/pokemon/pokemon.dart';
import 'package:pkmn_tb_checker/notifiers/party_notifier.dart';
import 'package:provider/provider.dart';

import 'pokemon_tile.dart';

class PartyView extends StatelessWidget {
  const PartyView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pokemonCount = context.watch<BuiltList<Pokemon>>().length;
    
    return Column(
      children: [
        for (var i = 0; i < pokemonCount; i++) PokemonTile(i),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlatButton.icon(
                icon: const Icon(Icons.clear),
                label: const Text('すべてクリア'),
                onPressed: () => context.read<PartyNotifier>().clear(),
              ),
              FlatButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('追加'),
                textTheme: ButtonTextTheme.primary,
                onPressed: context.select((PartyNotifier pn) => pn.isFull)
                    ? null
                    : () => context.read<PartyNotifier>().createPokemon(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// class _SimpleListViewScreen extends StatelessWidget {
//   const _SimpleListViewScreen({
//     Key key,
//     @required this.title,
//     this.children,
//   }) : super(key: key);

//   final String title;
//   final List<Widget> children;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(title)),
//       body: ListView(children: children),
//     );
//   }
// }

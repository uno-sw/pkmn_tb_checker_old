import 'package:flutter/material.dart';

import 'pokemon_tile.dart';
import '../notifiers/party_notifier.dart';

class Party extends StatelessWidget {
  const Party(this.notifier, {Key key})
      : assert(notifier != null), super(key: key);

  final PartyNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < notifier.pokemons.length; i++) PokemonTile(i),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlatButton.icon(
                icon: const Icon(Icons.clear),
                label: const Text('すべてクリア'),
                onPressed: notifier.removeAllPokemon,
              ),
              FlatButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('追加'),
                textTheme: ButtonTextTheme.primary,
                onPressed: notifier.pokemons.length <= 5
                    ? () => notifier.createPokemon()
                    : null,
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

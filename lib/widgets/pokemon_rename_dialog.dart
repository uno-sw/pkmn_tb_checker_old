import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:pkmn_tb_checker/models/pokemon/pokemon.dart';
import 'package:pkmn_tb_checker/notifiers/party_notifier.dart';
import 'package:provider/provider.dart';

class PokemonRenameDialog extends StatelessWidget {
  const PokemonRenameDialog(this.index);

  final int index;
  
  @override
  Widget build(BuildContext context) {
    final party = context.watch<BuiltList<Pokemon>>();
    final pokemon = party[index];
    final controller = context.watch<TextEditingController>();
    final text = controller.text.trim();

    return AlertDialog(
      title: const Text('名前を入力'),
      content: TextField(
        controller: controller,
        autofocus: true,
      ),
      actions: [
        FlatButton(
          textTheme: ButtonTextTheme.normal,
          onPressed: () => Navigator.pop(context),
          child: const Text('キャンセル'),
        ),
        FlatButton(
          onPressed: text.isEmpty || text == pokemon.name
              ? null
              : () {
                  context.read<PartyNotifier>().updatePokemon(
                    index,
                    pokemon.copyWith(name: text),
                  );
                  Navigator.pop(context);
                },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../notifiers/party_notifier.dart';

class PokemonRenameDialog extends StatelessWidget {
  const PokemonRenameDialog(this.index);

  final int index;
  
  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    final partyNotifier = Provider.of<PartyNotifier>(context);
    final controller = Provider.of<TextEditingController>(context);
    final initialName = partyNotifier.pokemons[index].name;
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
          onPressed: () => navigator.pop(),
          child: const Text('キャンセル'),
        ),
        FlatButton(
          onPressed: text.isNotEmpty && text != initialName 
              ? () {
                  partyNotifier.renamePokemon(index, text);
                  navigator.pop();
                }
              : null,
          child: const Text('OK'),
        ),
      ],
    );
  }
}

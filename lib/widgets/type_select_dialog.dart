import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:pkmn_tb_checker/models/pokemon/pokemon.dart';
import 'package:pkmn_tb_checker/notifiers/party_notifier.dart';
import 'package:pkmn_tb_checker/notifiers/type_select_notifier.dart';
import 'package:provider/provider.dart';

class TypeSelectDialog extends StatelessWidget {
  const TypeSelectDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dividerBorderSide = Divider.createBorderSide(context);

    return AlertDialog(
      title: const Text('タイプを${PokemonTypeCombination.maxTypeCount}つまで選択'),
      contentPadding: const EdgeInsets.only(top: 20.0),
      content: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            top: dividerBorderSide,
            bottom: dividerBorderSide,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
          child: Wrap(
            spacing: 4.0,
            children: PokemonType.values.map(
              (type) => _PokemonTypeChip(type),
            ).toList(),
          ),
        ),
      ),
      actions: [
        FlatButton(
          textTheme: ButtonTextTheme.normal,
          onPressed: () => Navigator.pop(context),
          child: const Text('キャンセル'),
        ),
        FlatButton(
          onPressed: context.watch<TypeSelectState>().types.isNotEmpty
              ? () => _onSaveButtonPressed(context)
              : null,
          child: const Text('OK'),
        ),
      ],
    );
  }

  void _onSaveButtonPressed(BuildContext context) {
    final party = context.read<BuiltList<Pokemon>>();
    final pokemon = party[context.read<TypeSelectState>().pokemonIndex];

    context.read<PartyNotifier>().updatePokemon(
      context.read<TypeSelectState>().pokemonIndex,
      pokemon.copyWith(
        typeCombination: PokemonTypeCombination(
          context.read<TypeSelectState>().types,
        ),
      ),
    );

    Navigator.pop(context);
  }
}

class _PokemonTypeChip extends StatelessWidget {
  const _PokemonTypeChip(this.type, {Key key})
      : assert(type != null),
        super(key: key);

  final PokemonType type;

  @override
  Widget build(BuildContext context) {
    final typeSelectState = context.watch<TypeSelectState>();
    final isSelected = typeSelectState.types.contains(type);

    return FilterChip(
      avatar: CircleAvatar(backgroundColor: type.data.color),
      label: Text(type.data.name),
      shape: StadiumBorder(side: Divider.createBorderSide(context)),
      backgroundColor: Colors.white,
      disabledColor: Colors.white,
      selectedColor: Colors.black12,
      selected: isSelected,
      onSelected: (!typeSelectState.maxCountSelected || isSelected)
          ? (value) {
              if (value) context.read<TypeSelectNotifier>().select(type);
              else context.read<TypeSelectNotifier>().deselect(type);
            }
          : null,
    );
  }
}
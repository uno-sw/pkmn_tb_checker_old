import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:pkmn_tb_checker/models/party/party_score.dart';
import 'package:pkmn_tb_checker/models/pokemon/pokemon.dart';
import 'package:pkmn_tb_checker/notifiers/party_notifier.dart';
import 'package:provider/provider.dart';

class RecommendedTypesTile extends StatelessWidget {
  const RecommendedTypesTile({Key key, @required this.partyScore})
      : super(key: key);

  final PartyScore partyScore;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('おすすめタイプ'),
      children: [
        for (final scoredTypes in partyScore.additionalTypeScores())
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 48.0,
                  height: 48.0,
                  child: Center(
                    child: Text(
                      '+${scoredTypes.score}',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Wrap(
                    spacing: 8.0,
                    children: [
                      for (final type in scoredTypes.types)
                        InputChip(
                          label: Text('${type.name}'),
                          onPressed: () {
                            final partyNotifier = context.read<PartyNotifier>();

                            if (partyNotifier.isFull) {
                              return;
                            }

                            partyNotifier.createPokemon(
                              PokemonTypeCombination(BuiltSet({type})),
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
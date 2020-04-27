import 'package:flutter/material.dart';
import 'package:pkmn_tb_checker/models/party/party_score.dart';
import 'package:provider/provider.dart';

import '../notifiers/party_notifier.dart';
import '../widgets/party.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = context.watch<GlobalKey<ScaffoldState>>();
    final partyNotifier = Provider.of<PartyNotifier>(context);
    final partyScore = PartyScore(
      typeCombinations: partyNotifier.pokemons.map(
          (pokemon) => pokemon.typeCombination).toList(),
    );

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Pokemon Type Balance Checker'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('スコア'),
            subtitle: Text(partyScore.total.toString()),
          ),
          _IncreasesListTile(partyScore: partyScore),
          const Divider(),
          Party(partyNotifier),
        ],
      ),
    );
  }
}

class _IncreasesListTile extends StatelessWidget {
  const _IncreasesListTile({Key key, @required this.partyScore})
      : assert(partyScore != null), super(key: key);

  final PartyScore partyScore;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('タイプ追加による増加量'),
      onTap: () {
        final scores = partyScore.additionalTypeScores();

        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
          ),
          isScrollControlled: true,
          builder: (context) => FractionallySizedBox(
            heightFactor: 0.5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'タイプ追加による増加量',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                const Divider(height: 1.0),
                Flexible(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    itemCount: scores.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        title: Text(scores[i].item2),
                        leading: CircleAvatar(child: Text('${scores[i].item1}')),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

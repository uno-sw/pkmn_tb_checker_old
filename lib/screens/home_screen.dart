import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:pkmn_tb_checker/models/party/party_score.dart';
import 'package:pkmn_tb_checker/models/pokemon/pokemon.dart';
import 'package:pkmn_tb_checker/widgets/party_view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final partyScore =
        PartyScore.fromPokemons(context.watch<BuiltList<Pokemon>>());

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('スコア'),
            expandedHeight: 120,
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(120),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: Text(
                  '${partyScore.total}',
                  style: Theme.of(context).textTheme.headline2.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              _IncreasesListTile(partyScore: partyScore),
              const Divider(),
              const PartyView(),
            ]),
          ),
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
      enabled: partyScore.total < 100,
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

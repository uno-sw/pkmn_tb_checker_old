import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:pkmn_tb_checker/models/party/party_score.dart';
import 'package:pkmn_tb_checker/models/pokemon/pokemon.dart';
import 'package:pkmn_tb_checker/widgets/party_view.dart';
import 'package:pkmn_tb_checker/widgets/recommended_types_tile.dart';
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
              if (partyScore.additionalTypeScores().isNotEmpty)
                  RecommendedTypesTile(partyScore: partyScore),
              const PartyView(),
            ]),
          ),
        ],
      ),
    );
  }
}
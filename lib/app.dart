import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';

import 'models/pokemon/pokemon.dart';
import 'notifiers/party_notifier.dart';
import 'screens/home_screen.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return StateNotifierProvider<PartyNotifier, BuiltList<Pokemon>>(
      create: (_) => PartyNotifier(),
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('ja'),
        ],
        theme: ThemeData(primarySwatch: Colors.teal),
        title: 'Pokemon Type Balance Checker',
        home: const HomeScreen(),
      ),
    );
  }
}
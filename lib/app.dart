import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'notifiers/party_notifier.dart';
import 'screens/home_screen.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PartyNotifier>(
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
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        title: 'Pokemon Type Balance Checker',
        home: Provider(
          create: (_) => GlobalKey<ScaffoldState>(),
          child: const HomeScreen(),
        ),
      ),
    );
  }
}

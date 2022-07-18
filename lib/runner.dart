import 'dart:async';

import 'package:endgame/features/list_page/screen/list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// App launch.
Future<void> run() async {
  /// It must be called so that the orientation does not fall.
  WidgetsFlutterBinding.ensureInitialized();

  /// Fix orientation.
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  _runApp();
}

void _runApp() {
  runZonedGuarded<Future<void>>(
        () async {
      runApp(const App());
    },
        (exception, stack) {
      // FirebaseCrashlytics.instance.recordError(exception, stack);
    },
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ListPageScreen(),
    );
  }
}
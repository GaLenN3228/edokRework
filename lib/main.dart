import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:newedok/services/block/block.dart';
import 'package:newedok/services/imports.dart';
import 'package:injectable/injectable.dart';

import 'package:newedok/ui/login_page/login_page.dart';

import 'injection.dart';

final env = Environment.dev;

final logger = Logger(
  filter: env == Environment.dev ? ProductionFilter() : DebugFilter(),
);

final dioLogger = Logger(
  filter: env == Environment.dev ? ProductionFilter() : DebugFilter(),
  printer: SimplePrinter(),
);

void setupLocator() {}

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

  WidgetsFlutterBinding.ensureInitialized();

  Crashlytics.instance.enableInDevMode = false;
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<void> _injectionFuture;

  MyApp({
    Key key,
  })  : _injectionFuture = configureInjection(env),
        super(key: key);

  @override
  Widget build(BuildContext context) => FutureBuilder<void>(
        future: _injectionFuture,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Container();
          } else {
            return ChangeNotifierProvider<MainBloc>(
              builder: (context) => MainBloc(),
              child: new MaterialApp(
                debugShowCheckedModeBanner: false,
                home: LoginPage(),
              ),
            );
          }
        },
      );
}

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:newedok/services/block/block.dart';
import 'package:newedok/services/imports.dart';
import 'package:newedok/themes/fond_and_colors.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:logger_flutter/logger_flutter.dart';
import 'package:newedok/ui/login_page/login_page.dart';

final env = Environment.dev;

final logger = Logger(
  filter: env == Environment.dev ? ProductionFilter() : DebugFilter(),
);

final dioLogger = Logger(
  filter: env == Environment.dev ? ProductionFilter() : DebugFilter(),
  printer: SimplePrinter(),
);



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainBloc>(
      builder: (context) => MainBloc(),
      child: new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    );
  }
}

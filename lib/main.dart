import 'package:flutter/material.dart';
import 'package:newedok/login_page/login_page.dart';
import 'package:newedok/services/block/block.dart';
import 'package:newedok/services/imports.dart';
import 'package:newedok/themes/fond_and_colors.dart';

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

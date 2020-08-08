import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'e_appbar.dart';



class AScaffold extends StatelessWidget {
  final AAppBar appBar;
  final Widget body;
  final bool resizeToAvoidBottomPadding;

  AScaffold({
    Key key,
    this.appBar,
    this.body,
    this.resizeToAvoidBottomPadding = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomPadding,
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              appBar ?? Container(),
              Expanded(child: body ?? Container()),
            ],
          ),
        ],
      ),
    );
  }
}
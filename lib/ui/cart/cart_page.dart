import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:newedok/injection.dart';
import 'package:flutter/rendering.dart';
import 'package:newedok/services/imports.dart';
import 'package:newedok/stores/cities_store.dart';
import 'package:newedok/stores/places_store.dart';
import 'package:newedok/themes/fond_and_colors.dart';
import 'package:newedok/ui/components/e_appbar.dart';
import 'package:newedok/ui/components/e_scaffold.dart';
import 'package:newedok/ui/components/tappable.dart';



class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Thm.of(context).accentColor,
    );
  }
}


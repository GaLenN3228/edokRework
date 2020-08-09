import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newedok/ui/bottom_navigator_bar/home.dart';
import 'package:newedok/ui/components/router/router.gr.dart';
import 'package:newedok/ui/components/router/router.dart';
import 'package:newedok/injection.dart';
import 'package:flutter/rendering.dart';
import 'package:newedok/services/imports.dart';
import 'package:newedok/stores/cities_store.dart';
import 'package:newedok/themes/fond_and_colors.dart';
import 'package:newedok/ui/components/e_appbar.dart';
import 'package:newedok/ui/components/e_scaffold.dart';
import 'package:newedok/ui/components/tappable.dart';

class CitiesPage extends StatefulWidget {

  @override
  _CitiesPageState createState() => _CitiesPageState();
}

class _CitiesPageState extends State<CitiesPage> {
  final CitiesStore _citiesStore = getIt();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: AScaffold(
          appBar: AAppBar(
            title: Text(
              'Выберите ваш город',
              style: Thm.of(context).toolbarTitle,
            ),
            textStyle: Thm.of(context).toolbarTitle,
            leadingIcon: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Icon(
                Icons.arrow_back,
                color: Thm.of(context).blackColor,
              ),
            ),
          ),
          body: CustomScrollView(
            slivers: <Widget>[
              SliverPadding(
                padding: EdgeInsets.only(left: 20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Tappable(
                      padding: EdgeInsets.only(top: 17, bottom: 17),
                      onTap: () {
                        //TODO заменить на EXTENDED NAVIGATOR
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Home(
                                  cityName: _citiesStore.cities.value[index].namePrepositional,
                                  cityId: int.parse(_citiesStore.cities.value[index].id))),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: Text(
                        '${_citiesStore.cities.value[index].cityName}',
                        style: Thm.of(context).contentBodyPrimary,
                      ),
                    ),
                    childCount: _citiesStore.cities.value.length,
                  ),
                ),
              )
            ],
          )),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
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
            sliver:   SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) => Tappable(
                  padding: EdgeInsets.only(top: 17, bottom: 17),
                  onTap: (){
                    print(_citiesStore.cities.value[index].id);
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

        )

      ),
    );
  }

  Widget citiesList() {
    return  ListView.separated(
        separatorBuilder: (_, i) => SizedBox(
          height: 17.0,
        ),
        itemCount: _citiesStore.cities.value.length,
        itemBuilder: (context, index) {
          return Tappable(
            padding: EdgeInsets.only(top: 15, bottom: 15),
            onTap: (){},
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                '${_citiesStore.cities.value[index].cityName}',
                style: Thm.of(context).contentBodyPrimary,
              ),
            ),
          );
        },
      );
  }
}

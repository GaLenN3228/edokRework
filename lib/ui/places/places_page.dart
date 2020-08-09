import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:newedok/injection.dart';
import 'package:flutter/rendering.dart';
import 'package:newedok/services/imports.dart';
import 'package:newedok/ui/cities_page/cities_page.dart';
import 'package:newedok/ui/components/router/router.gr.dart';
import 'package:newedok/stores/places_store.dart';
import 'package:newedok/themes/fond_and_colors.dart';
import 'package:newedok/ui/components/e_appbar.dart';
import 'package:newedok/ui/components/e_scaffold.dart';
import 'package:newedok/ui/components/tappable.dart';

import '../../main.dart';

class PlacesPage extends StatefulWidget {
  final int id;
  final String cityName;

  const PlacesPage({Key key, @required this.id, @required this.cityName})
      : super(key: key);

  @override
  _PlacesPageState createState() => _PlacesPageState();
}

class _PlacesPageState extends State<PlacesPage> {
  final PlacesStore _placesStore = getIt();

  @override
  void initState() {
    _placesStore.fetchPlaces(widget.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {});
    });
    return AScaffold(
        appBar: AAppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Tappable(
                onTap: () {
                  //TODO заменить на EXTENDED NAVIGATOR
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CitiesPage()));
                },
                child: Row(
                  children: <Widget>[
                    Text(
                      'Заведения в ',
                      style: Thm.of(context).toolbarTitleNormal,
                    ),
                    Text(
                      widget.cityName,
                      style: Thm.of(context).toolbarTitle,
                    ),
                    Icon(Icons.arrow_drop_down)
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Категории',
                    style: Thm.of(context).contentBodySecondary,
                  ),
                  Container(),
                ],
              ),
            ],
          ),
          leadingIcon: Padding(
            padding: const EdgeInsets.only(top: 30, left: 10),
            child: Icon(Icons.filter_list),
          ),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverList(
                delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
                        color: Thm.of(context).primaryColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                                width: MediaQuery.of(context).size.width * 0.8213,
                                child: Text(
                                  _placesStore.places.value[index].name,
                                  style: Thm.of(context).contentBodyTitle,
                                  overflow: TextOverflow.ellipsis,
                                )),
                            Container(
                              color: Thm.of(context).primaryColor,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    _placesStore.places.value[index].rating,
                                    style: Thm.of(context).contentBodyTitle,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Thm.of(context).orangeEdok,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        color: Thm.of(context).primaryColor,
                        height: 170,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, i) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        height: 115,
                                        width: 145,
                                        child: Image.network(
                                            'https://edok.kz/images/food_photo/${_placesStore.places.value[index].dish[i].photo}', fit: BoxFit.fill,)),
                                    Container(
                                        padding: EdgeInsets.only(top: 5),
                                        child: Text('${_placesStore.places.value[index].dish[i].price} ₸', style: Thm.of(context).contentBodySecondaryOrange)),

                                  ],
                                ),
                            separatorBuilder: (_, i) => SizedBox(
                                  width: 13.0,
                                ),
                            itemCount: 3
                        ),
                      ),
                      Container(
                        color: Thm.of(context).primaryColor,
                        padding: EdgeInsets.fromLTRB(15, 0, 5, 5),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Европейская',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              ' - Итальянская - ',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              'Азиатская',
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
              childCount: _placesStore.places.value.length,
            ))
          ],
        ));
  }
}

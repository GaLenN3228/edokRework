import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:newedok/injection.dart';
import 'package:flutter/rendering.dart';
import 'package:newedok/stores/cities_store.dart';


class CitiesPage extends StatefulWidget  {
  @override
  _CitiesPageState createState() => _CitiesPageState();
}

class _CitiesPageState extends State<CitiesPage> {
  final CitiesStore _citiesStore = getIt();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('123'),
      ),
      body: ListView.builder(
        itemCount: _citiesStore.cities.value.length,
        itemBuilder: (context, index){
          return Text('${_citiesStore.cities.value[index].cityName}');
        },
      ),
    );
  }
}

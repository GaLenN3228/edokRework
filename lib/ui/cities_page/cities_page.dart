import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newedok/models/cities_model.dart';
import 'package:newedok/services/api_services/requests.dart';


class CitiesPage extends StatefulWidget {
  @override
  _CitiesPageState createState() => _CitiesPageState();
}

class _CitiesPageState extends State<CitiesPage> {


  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('123'),
      ),
      body: ListView.builder(
        itemCount: 12,
        itemBuilder: (context, index){
          return Text('123');
        },
      ),
    );
  }
}

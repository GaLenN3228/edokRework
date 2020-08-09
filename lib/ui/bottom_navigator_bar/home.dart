import 'package:flutter/cupertino.dart';
import 'package:newedok/services/imports.dart';
import 'package:newedok/ui/cart/cart_page.dart';
import 'package:newedok/ui/places/places_page.dart';
import 'package:newedok/ui/profile/profile_page.dart';
import 'package:newedok/ui/promo/promo_page.dart';

import 'bottm_appbar_animation.dart';

class Home extends StatefulWidget {

  final int cityId;
  final String cityName;

  const Home({Key key, this.cityId, this.cityName}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedBarIndex = 0;
  Widget currentPage;
  List<Widget> pages;
  List<BarItem> barItems = [
    BarItem(
      text: "",
    imageicon: 'assets/tabsimages/main.png',
      color: Colors.white,
    ),
    BarItem(
      text: "",
      imageicon: 'assets/tabsimages/shopbag.png',
      color: Colors.white,
    ),
    BarItem(
      text: "",
      imageicon: 'assets/tabsimages/Star.png',
      color: Colors.white,
    ),
    BarItem(
      text: "",
      imageicon: 'assets/tabsimages/User.png',
      color: Colors.white,
    ),
  ];

  @override
  void initState() {
    pages = [PlacesPage(id: widget.cityId, cityName: widget.cityName,), CartPage(), PromoPage(),ProfilePage() ];
    currentPage = pages[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.cityId);
    var bloc = Provider.of<MainBloc>(context);
    if (bloc.cart != null) {
      setState(() {
        barItems[1].text = bloc.counter > 0 ? bloc.counter.toString() : '';
      });
    }
    return Scaffold(
      body: currentPage,
      bottomNavigationBar: AnimatedBottomBar(
          barItems: barItems,
          animationDuration: const Duration(milliseconds: 150),
          barStyle: BarStyle(fontSize: 20.0, iconSize: 24.0),
          onBarTap: (index) {
            setState(() {
              selectedBarIndex = index;
              currentPage = pages[index];
              bloc.pageId = selectedBarIndex;
            });
          }),
    );
  }
}


import 'dart:io';

import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter/widgets.dart';
import 'package:newedok/ui/cities_page/cities_page.dart';
import 'package:newedok/ui/login_page/login_page.dart';



@CupertinoAutoRouter(generateNavigationHelperExtension: true)
class $Router {
  @initial
    LoginPage loginPage;
    CitiesPage citiesPage;
}

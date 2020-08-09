import 'package:auto_route/auto_route_annotations.dart';
import 'package:newedok/ui/bottom_navigator_bar/home.dart';
import 'package:newedok/ui/cart/cart_page.dart';
import 'package:newedok/ui/cities_page/cities_page.dart';
import 'package:newedok/ui/login_page/login_page.dart';
import 'package:newedok/ui/places/places_page.dart';
import 'package:newedok/ui/profile/profile_page.dart';
import 'package:newedok/ui/promo/promo_page.dart';



@CupertinoAutoRouter(generateNavigationHelperExtension: true)
class $Router {
  @initial
    LoginPage loginPage;
    CitiesPage citiesPage;
    Home home;


    PlacesPage placesPage;
    CartPage cartPage;
    PromoPage promoPage;
    ProfilePage profilePage;


}

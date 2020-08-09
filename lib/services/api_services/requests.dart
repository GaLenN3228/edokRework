import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../imports.dart';

class ApiService {
/*

Auth request

 */

  Future phoneSend(String phoneNumber) async {
    try {
      var response =
          await http.post('https://edok.kz/api/rest/userlogin', body: {
        'phone': phoneNumber,
      }, headers: {
        "x-rest-username": "mp@admplaces",
        "x-rest-password": "mp@7uf98HKHf"
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  static Future phoneCodeSend(String phoneNumber, String authKey, context) async {
    try {
      var response =
          await http.post('https://edok.kz/api/rest/useractivate', body: {
        'phone': phoneNumber,
        'code': authKey,
      }, headers: {
        "x-rest-username": "mp@admplaces",
        "x-rest-password": "mp@7uf98HKHf"
      });
      if (response.statusCode == 200) {
        var userData = json.decode(response.body);
        var bloc = Provider.of<MainBloc>(context);
        bloc.setUserData(userData['user']);
        return true;
      } else {
        print(response.statusCode);
        return false;
      }
    } catch (error) {
      print('Error: $error');
    }
  }


  static Future getHistory(context) async {
    try {
      var bloc = Provider.of<MainBloc>(context);
      http.Response response = await http
          .get("https://edok.kz/api/rest/orders?token=${bloc.userToken}", headers: {
        "x-rest-username": "mp@admplaces",
        "x-rest-password": "mp@7uf98HKHf"
      });

      bloc.orders = json.decode(response.body)['orders'];
      print(response.body);

    } catch (error) {
      print(error);
    }
  }

/*

request for cities

 */
  static Future getCities(context) async {
    try {
      http.Response response = await http
          .get("https://edok.kz/api/rest/cities?id_country=1", headers: {
        "x-rest-username": "mp@admplaces",
        "x-rest-password": "mp@7uf98HKHf"
      });
      var bloc = Provider.of<MainBloc>(context);
      bloc.cities = json.decode(response.body)['cities'];



    } catch (error) {
      print(error);
    }
  }



  static Future getCitiesV2() async {
    final response = await http.get("https://edok.kz/api/rest/cities?id_country=1", headers: {
      "x-rest-username": "mp@admplaces",
      "x-rest-password": "mp@7uf98HKHf"
    });
    if (response.statusCode == 200) {
      Map data = json.decode(response.body);
      print(data['cities'][0]);
//      return Cities.fromJson();
    } else {
      throw Exception('Failed to load album');
    }
  }




  static Future getDistrictsByPlace(context)async {
    var bloc = Provider.of<MainBloc>(context);
    try {
      http.Response response = await http.get('https://edok.kz/api/rest/placesdistricts?id_place=${bloc.currentPlaceId}',
          headers: {
            "x-rest-username": "mp@admplaces",
            "x-rest-password": "mp@7uf98HKHf"
          });
        bloc.placeDistricts = json.decode(response.body)
        ['districts'];

    }catch (error) {
      print(error);
    }
  }

  /*

request for places and filtered places

 */

  static Future getPlacesData(context, idPlace) async {
    var bloc = Provider.of<MainBloc>(context);

        String url =
            "https://edok.kz/api/rest/placesv2?id_city=$idPlace";
        if (bloc.selectedCategoriesList.length > 0) {
          url = modifyUrlByFilters(url, bloc.selectedCategoriesList);
          print(url);
        }

        http.Response response = await http.get(url, headers: {
          "x-rest-username": "mp@admplaces",
          "x-rest-password": "mp@7uf98HKHf"
        });

  }
/*

request for place menu and filtered place menu

 */


  static Future getPlaceMenu(BuildContext context) async {
    var bloc = Provider.of<MainBloc>(context);
    String url =
        "https://edok.kz/api/rest/dishesv2?id_place=${bloc.currentPlaceId}";
    if (bloc.selectedCategoriesList.length > 0) {
      url = modifyUrlByFilters(url, bloc.selectedCategoriesList);
      print(url);
    }
    http.Response response = await http.get(
        url,
        headers: {
          "x-rest-username": "mp@admplaces",
          "x-rest-password": "mp@7uf98HKHf"
        });
    bloc.currentPlaceMenu = json.decode(response.body)["dishes"];
  }


  /*

request for current place categories

 */
  static Future getCategoriesForPlace(context) async {
    var bloc = Provider.of<MainBloc>(context);

    http.Response response = await http.get(
        "https://edok.kz/api/rest/placesdistricts?id_place=${bloc.currentPlaceId}",
        headers: {
          "x-rest-username": "mp@admplaces",
          "x-rest-password": "mp@7uf98HKHf"
        });
    bloc.currentPlaceCategories = json.decode(response.body)['items'];
  }

  /*

request for places categories

 */

  static Future getCategories(context) async {
    var bloc = Provider.of<MainBloc>(context);
    http.Response response = await http.get(
        "https://edok.kz/api/rest/filtersv2?tab=tab_places_food",
        headers: {
          "x-rest-username": "mp@admplaces",
          "x-rest-password": "mp@7uf98HKHf"
        });
    bloc.placesCategories = json.decode(response.body)['items'];
  }


  /*





  * */
  static Future sendOrder(data)async {
    var orderData = json.encode(data);
    http.Response response = await http.post(
       "https://edok.kz/api/rest/makefoodorder",
        body: orderData,
        headers: {
          "x-rest-username": "mp@admplaces",
          "x-rest-password": "mp@7uf98HKHf"
        });
      print(response.body);
  }


}



/*

url modify for places categories

 */




String modifyUrlByFilters(String url, List filtersList) {
  filtersList.forEach((element)=>{
    url += '&filters[]=$element',
  });
  return url;
}

class DishService {
  List collectDishes(List dishesList, Map keys) {
    Map dishesMap = processDishesToMap(dishesList);
    List result = List();
    keys.forEach((key, val) => {
          if (dishesMap.containsKey(key.toString()))
            {
              result.add(dishesMap[key.toString()]),
            }
        });
    return result;
  }
  Map processDishesToMap(List dishes) {
    Map dishesMap =
        Map.fromIterable(dishes, key: (v) => v['id'], value: (v) => v);
    return dishesMap;
  }
}

class MenuService {
  List searchForDishes(query, List dishes){
    List searchResult = List();
    dishes.forEach((e){
      e['name'].toString().toUpperCase().startsWith(query.toString().toUpperCase())? searchResult.add(e):null;
    });
    return searchResult;
  }
}

class CityService {
  List searchForCities(query, List cities){
    List searchResult = List();
    cities.forEach((e){
      e['city_name'].toString().toUpperCase()
          .startsWith(query.toString().toUpperCase())
          ? searchResult.add(e) : null;
    });
    return searchResult;
  }
}

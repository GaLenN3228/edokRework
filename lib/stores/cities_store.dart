import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:newedok/a_observable_future/a_observable_future.dart';
import 'package:newedok/api/edok_api.dart';
import 'package:newedok/main.dart';
import 'package:newedok/ext/ext.dart';
import 'package:newedok/models/cities_model.dart';

part 'cities_store.g.dart';


@singleton
class CitiesStore = CitiesStoreBase with _$CitiesStore;

abstract class CitiesStoreBase with Store {
  final EdokApi _api;


  CitiesStoreBase(this._api) {
    fetchCities();
  }

  @observable
  AObservableFuture<ObservableList<Cities>> cities;
  @action
  void fetchCities() {
    cities = _api.getCities().then((value) {
      logger.d(value);
      return value.cities.toObservableList();
    }).replaceObservableFuture(cities);
  }
}

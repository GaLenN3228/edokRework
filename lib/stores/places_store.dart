import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:newedok/a_observable_future/a_observable_future.dart';
import 'package:newedok/api/edok_api.dart';
import 'package:newedok/main.dart';
import 'package:newedok/ext/ext.dart';
import 'package:newedok/models/cities_model.dart';
import 'package:newedok/models/places_model.dart';
import 'package:newedok/services/imports.dart';

part 'places_store.g.dart';


@singleton
class PlacesStore = PlacesStoreBase with _$PlacesStore;

abstract class PlacesStoreBase with Store {
  final EdokApi _api;
  int id;


  PlacesStoreBase(this._api, ) {
    fetchPlaces(id);
  }

  @observable
  AObservableFuture<ObservableList<Places>> places;
  @action
  void fetchPlaces(int id) {
    places = _api.getPlaces(id).then((value) {
      logger.d(value);
      return value.places.toObservableList();
    }).replaceObservableFuture(places);
  }
}

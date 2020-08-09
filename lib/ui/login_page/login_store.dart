import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:newedok/injection.dart';
import 'package:newedok/stores/cities_store.dart';
import 'package:newedok/ui/places/places_page.dart';


part 'login_store.g.dart';

@injectable
class LoginPageStore = LoginPageStoreBase with _$LoginPageStore;


abstract class LoginPageStoreBase with Store {
 final CitiesStore _citiesStore;



  @observable
  bool rentRideTextVisible = true;

  @observable
  bool retryBtnVisible = false;

  @observable
  bool showAdditionalLoading = false;

  @observable
  bool showRetry = false;

  LoginPageStoreBase(this._citiesStore,){
    _citiesStore.fetchCities();
  }




}
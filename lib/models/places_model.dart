import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'places_model.g.dart';
part 'places_model.freezed.dart';



@freezed
abstract class PlacesResponse with _$PlacesResponse {
  factory PlacesResponse({
    @JsonKey(name: 'places') List<Places> places,
  }) = _PlacesResponse;

  factory PlacesResponse.fromJson(Map<String, dynamic> json) =>
      _$PlacesResponseFromJson(json);
}

@freezed
abstract class Places with _$Places {
  factory Places({
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'name') String name,
    @JsonKey(name: 'address') String address,
    @JsonKey(name: 'logotype') String logotype,
    @JsonKey(name: 'email') String email,
    @JsonKey(name: 'phones') String phones,
    @JsonKey(name: 'rating') String rating,
    @JsonKey(name: 'order_min_price') String orderMinPrice,
    @JsonKey(name: 'free_delievery_price') String freeDeliveryPrice,
    @JsonKey(name: 'worсkmode') List<Workmode> workmode,
    @JsonKey(name: 'dish') List<Dish> dish,
  }) = _Places;

  factory Places.fromJson(Map<String, dynamic> json) =>
      _$PlacesFromJson(json);
}

@freezed
abstract class Workmode with _$Workmode {
  factory Workmode({
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'weekday') String weekday,
    @JsonKey(name: 'work_from') String workFrom,
    @JsonKey(name: 'work_to') String workTo,
    @JsonKey(name: 'id_place') String idPlace,
  }) = _Workmode;

  factory Workmode.fromJson(Map<String, dynamic> json) =>
      _$WorkmodeFromJson(json);
}


@freezed
abstract class Dish with _$Dish {
  factory Dish({
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'name') String name,
    @JsonKey(name: 'description') String description,
    @JsonKey(name: 'photo') String photo,
    @JsonKey(name: 'price') String price,
  }) = _Dish;

  factory Dish.fromJson(Map<String, dynamic> json) =>
      _$DishFromJson(json);
}
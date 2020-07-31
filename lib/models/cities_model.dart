import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cities_model.g.dart';
part 'cities_model.freezed.dart';


@freezed
abstract class CitiesResponse with _$CitiesResponse {
  factory CitiesResponse({
    @JsonKey(name: 'cities') List<Cities> cities,
  }) = _CitiesResponse;

  factory CitiesResponse.fromJson(Map<String, dynamic> json) =>
      _$CitiesResponseFromJson(json);
}

@freezed
abstract class Cities with _$Cities {
  factory Cities({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'city_name') String cityName,
    @JsonKey(name: 'name_prepositional') String namePrepositional,
  }) = _Cities;

  factory Cities.fromJson(Map<String, dynamic> json) => _$CitiesFromJson(json);
}
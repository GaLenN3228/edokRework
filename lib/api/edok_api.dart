import 'package:newedok/models/cities_model.dart';
import 'package:newedok/models/places_model.dart';
import 'package:retrofit/retrofit.dart';


import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

part 'edok_api.g.dart';

@singleton
@RestApi()
abstract class EdokApi {
  @factoryMethod
  factory EdokApi(
      Dio dio, {
        @required @Named('baseUrl') String baseUrl,
      }) = _EdokApi;

  @GET('cities?id_country=1')
  Future<CitiesResponse> getCities();

  @GET('placesv2?id_city={id}')
  Future<PlacesResponse> getPlaces(@Path() int id);

}

class NetworkError implements Exception {
  final RequestOptions request;
  final Response response;
  final DioErrorType type;

  NetworkError(DioError dioError)
      : request = dioError.request,
        response = dioError.response,
        type = dioError.type;
}

class CancelError implements Exception {
  final RequestOptions request;
  final DioErrorType type;

  CancelError(DioError dioError)
      : request = dioError.request,
        type = dioError.type;
}

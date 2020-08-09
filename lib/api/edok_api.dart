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

/*  @GET('/car')
  Future<CarsResponse> getCars();

  @GET('/deal?statuses=new,paid,verify,inuse')
  Future<DealResponse> fetchActiveDeals();

  @POST('/deal')
  Future<Deal> createDeal(@Body() DealCreateRequest request);

  @GET('/deal/{id}')
  Future<Deal> fetchDeal(@Path() int id);

  @GET('/deal?statuses=closed,canceled,penny')
  Future<DealResponse> fetchHistoryDeals();

  @POST('/register')
  Future<Profile> register(
      @Body() RegistrationStartRequest registrationStartRequest);

  @POST('/verify')
  Future<Profile> verify(
      @Body() RegistrationFinishRequest registrationFinishRequest);

  @POST('/token')
  Future<Profile> token(@Body() TokenRequest tokenRequest);

  @POST('/password/reset')
  Future<List<int>> passwordReset(@Body() RecoverPassword recoverPassword);

  @POST('/revoke')
  Future<String> removeAccount();

  @POST('/logout')
  Future<String> logoutFromApp();

  @POST('/password/confirm')
  Future<Profile> passwordConfirm(
      @Body() RecoverPasswordConfirm recoverPasswordConfirm);

  @GET('/car/{id}/services/rent')
  Future<List<AdditionalEquipment>> getAdditionalEquipments(@Path() int id);

  @GET('/car/{id}/services/delivery')
  Future<List<Delivery>> getDeliveries(@Path() int id);

  @POST('/car/{id}/calendar')
  Future<CarCalendar> getCalendar(@Path() int id);

  @GET('/profile')
  Future<Profile> getProfile();

  @POST('/profile/document')
  @MultiPart()
  Future<DocResponse> uploadFile(
      @Part(name: 'type') String docType,
      @Part(name: 'upload') File file,
      );

  @DELETE('/profile/document/{id}')
  Future<dynamic> deleteFile(
      @Path() int id,
      DocRemove docRemove,
      );

  @POST('/deal/{id}/payment')
  Future<DealPayment> getPaymentInfo(
      @Path() int id,
      );

  @POST('/deal/fine/{id}/payment')
  Future<DealPayment> getPaymentInfoOneFine(
      @Path() int id,
      );

  @POST('/deal/{id}/fine/payment')
  Future<DealPayment> getPaymentAllFines(
      @Path() int id,
      );*/
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
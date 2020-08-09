import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:newedok/api/edok_api.dart';
import 'package:newedok/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'injection.iconfig.dart';


final GetIt getIt = GetIt.instance;


@module
abstract class RegisterModule {
  @Named('baseUrl')
  String get baseUrl => 'https://edok.kz/api/rest/';


  @singleton
  Dio provideDio() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: 20000,
        receiveTimeout: 20000,
        headers: <String, dynamic> {
          'x-rest-username': 'mp@admplaces',
          'x-rest-password': 'mp@7uf98HKHf',
        },
      ),
    );

    dio.interceptors
      ..add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: dioLogger.d,
      ))
      ..add(InterceptorsWrapper(onError: (error) {
        return _handleDioError(error);
      }));
    return dio;
  }

  @singleton
  @preResolve
  Future<SharedPreferences> provideSharedPreferences() =>
      SharedPreferences.getInstance();
}

@injectableInit
Future<void> configureInjection(String env) {
  return $initGetIt(getIt, environment: env);
}



dynamic _handleDioError(
    dynamic error,
    ) {
  if (error is DioError) {
    switch (error.type) {
      case DioErrorType.CONNECT_TIMEOUT:
      case DioErrorType.SEND_TIMEOUT:
      case DioErrorType.RECEIVE_TIMEOUT:
        return NetworkError(error);
        break;
      case DioErrorType.CANCEL:
        return CancelError(error);
        break;
      case DioErrorType.DEFAULT:
        if (error.error is SocketException) {
          return NetworkError(error);
        } else {
          return error;
        }
        break;
      case DioErrorType.RESPONSE:
        try {

        } catch (serializeError) {
          logger.e(serializeError);
          return error;
        }
        break;
      default:
        return error;
        break;
    }
  } else {
    return error;
  }
}

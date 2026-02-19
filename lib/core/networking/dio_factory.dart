import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../helper/constants.dart';
import '../helper/shared_pref_helper.dart';

class DioFactory {
  /// private constructor as I don't want to allow creating an instance of this class
  DioFactory._();

  static Dio? dio;

  static Future<Dio> getDio({bool withToken = true}) async {
    Duration timeOut = const Duration(seconds: 60);

    if (dio == null) {
      dio =
          Dio()
            ..options.connectTimeout = timeOut
            ..options.receiveTimeout = timeOut;
      addDioInterceptor();
    }

    await addDioHeaders();

    return dio!;
  }

  static Future<void> addDioHeaders() async {
    final token = await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.userToken,
    );
    dio?.options.headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  static void setTokenIntoHeaderAfterSignUp(String token) {
    dio?.options.headers['Authorization'] = 'Bearer $token';
  }

  static void addDioInterceptor() {
    dio?.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }
}
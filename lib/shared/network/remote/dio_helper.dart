import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        connectTimeout: 60 * 1000,
        receiveTimeout: 60 * 1000,
        validateStatus: (status) => true,
      ),
    );
  }

  static Future<Response> getData(
      {required String url,
      String lang = 'ar',
      String? token,
      Map<String, dynamic>? query}) async {
    dio!.options.headers = {
      'Lang': lang,
      'Authorization': token,
      'Content-Type': 'application/json'
    };

    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'ar',
    String? token,
    required Map<String, dynamic>? data,
  }) async {
    dio!.options.headers = {
      'lang': lang,
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    return await dio!.post(url, data: data, queryParameters: query);
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'ar',
    String? token,
    required Map<String, dynamic>? data,
  }) async {
    dio!.options.headers = {
      'lang': lang,
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    return await dio!.put(url, data: data, queryParameters: query);
  }
}

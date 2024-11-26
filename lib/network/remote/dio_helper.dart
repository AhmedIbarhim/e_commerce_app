import 'package:dio/dio.dart';
import 'package:ecommerce_app/network/end_points.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
        BaseOptions(baseUrl: baseUrl,
            receiveDataWhenStatusError: true)
    );
  }

  static Future<Response> postData(
      {required String end_point,
      Map<String, dynamic>? data,
      Map<String, dynamic>? query,
      String? token
      })
    async {dio.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };

    return await dio.post(end_point, data: data, queryParameters: query);
  }

  static Future<Response> getData(
      {required String end_point,
      Map<String, dynamic>? query,
      String? token}) async {
    dio.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };

    return await dio.get(end_point, queryParameters: query);
  }

  static Future<Response> putData(
      {required String end_point,
      Map<String, dynamic>? data,
      Map<String, dynamic>? query,
      String? token}) async {
    dio.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };

    return await dio.put(end_point, data: data, queryParameters: query);
  }

  static Future<Response> deleteData(
      {required String end_point,
      Map<String, dynamic>? data,
      Map<String, dynamic>? query,
      String? token}) async {
    dio.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };

    return await dio.delete(end_point, data: data, queryParameters: query);
  }
}

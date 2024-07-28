import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio;

  DioClient() : _dio = Dio();

  Future<Response> get(String path) async {
    return await _dio.get(path);
  }
}

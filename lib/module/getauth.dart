import 'package:dio/dio.dart';

class GetAuth {
  final Dio dio1 = Dio();
  Future<Map<String, dynamic>> takeToken() async {
    Options options = Options(
      headers: {
    'content-type': 'application/json; charset=utf-8',
        'x-gapo-workspace-id': '581711080747329',
        'x-gapo-lang': 'vi'
      }
    );
    var data = { "client_id": "6n6rwo86qmx7u8aahgrq",
      "device_model": "Simulator iPhone 11",
      "device_id": "76cce865cbad4d02",
      "password": "4bff60a3797bc8053cd40253218c93afa7962fb966d012c844e254ad7788147e",
      "trusted_device": true,
      "email": "nguyenmanhtoan@gapo.com.vn"
    };
    var response = await dio1.post(
      'https://staging-api.gapowork.vn/auth/v3.0/login',
      data: data,
      options: options,
    );
    return response.data;
  }
}
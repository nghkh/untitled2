import 'package:dio/dio.dart';
import 'getauth.dart';

class GetData {
  final Dio dio2 = Dio();
  final GetAuth r = GetAuth();
  Future<Map<String, dynamic>> getToken() async{
    Map<String, dynamic> getAuth = await r.takeToken();
    Options options = Options(
      headers: {
        'x-gapo-workspace-id': '581860791816317',
        'x-gapo-lang': 'vi',
        'x-gapo-user-id': '1042179540',
        'Authorization': 'Bearer ${getAuth['access_token']}',
      }
    );
    var response = await dio2.get(
      'https://staging-api.gapowork.vn/mini-task/v1.0/notify?workspace_id=582567209681709&limit=30',
      options: options,
    );
    return response.data;
  }
}
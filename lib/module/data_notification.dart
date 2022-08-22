import 'get_data.dart';

class ResponseNotification {
  List<DataNotification>? data;

  final GetData res = GetData();
  Future<List<DataNotification>?> notification() async {
    Map<String, dynamic> getData = await res.getToken();

    if (getData['data'] == null){
      return [];
    } else {
      data?.addAll(getData['data']);
      return data;
    }
  }

}


class DataNotification {
  Body? message;
  String? image;
  String? icon;



List<String> strToHighlights() {
  List<String> strNeedToHighLights = (message?.highlights ?? []).map((e){
    int offset = (e.offset ?? 0);
    int maxOffset = offset + (e.length ?? 0);
    return (message?.body ?? '').substring(offset, maxOffset);
  }).toList();
  return strNeedToHighLights;
}


}

class Body {
  String? body;
  List<Highlights>? highlights;
}

class Highlights {
  int? offset;
  int? length;
}
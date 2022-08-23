

class ResponseNotification {
  final response;
  List<DataNotification>? data;

  ResponseNotification(this.response) {
    List responseData = response['data'];

    for (var element in responseData) {
      data?.add(DataNotification(
        message: element['body'],
        image: element['image'],
        icon: element['icon'],
        highlights: element['highlights'],
      ));
    }
  }
}

class DataNotification {
  final String? message;
  final String? image;
  final String? icon;
  final List? highlights;
  late final List<StringHighlight> listHighlight;

  DataNotification({
    this.message = 'null',
    this.image =
        'https://www.shareicon.net/data/128x128/2016/05/26/771188_man_512x512.png',
    this.icon =
        'https://upload.wikimedia.org/wikipedia/commons/d/d2/Solid_white.png',
    this.highlights,
  }) {
    if ((highlights?.isNotEmpty ?? false) && (message?.isNotEmpty ?? false)) {
      int start = 0;
      listHighlight = [];

      for (var e in highlights!) {
        if (start != 0) {
          start = e['offset'];
        }

        String startStr = message!.substring(start, e['offset']);
        if (startStr.isNotEmpty) {
          listHighlight
              .add(StringHighlight(str: startStr, type: HighlightEnum.normal));
        }
        String strNeedToBeHighlight =
            message!.substring(e['offset'], e['offset'] + e['length']);
        listHighlight.add(StringHighlight(
            str: strNeedToBeHighlight, type: HighlightEnum.highlight));
      }
    }
    
    image?.replaceAll('\$size\$', '100x100');
    icon?.replaceAll('\$size\$', '100x100');

  }
}

class StringHighlight {
  final String str;
  final HighlightEnum type;

  StringHighlight({required this.str, required this.type});
}

enum HighlightEnum { highlight, normal }

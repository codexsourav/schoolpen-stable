import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:schoolpenintern/data/Network/config.dart';

import 'searchProfileMoadel.dart';

class SearchUserHelper {
  static search(userId) async {
    try {
      var url = Uri.parse('http://${Config.hostUrl}/get_profile/$userId');

      var req = http.Request('GET', url);

      var res = await req.send();
      Map resdata = jsonDecode(res as String);
      if (res.statusCode >= 200 && res.statusCode < 300) {
        if (resdata.containsKey("message")) {
          return {'error': "User Not Found"};
        } else {
          return SearchProfileModel(res);
        }
      } else {
        return {'error': "User Not Found"};
      }
    } catch (e) {
      return {'error': "Search User Filled Error!"};
    }
  }
}

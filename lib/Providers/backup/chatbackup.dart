import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../data/Network/config.dart';

class ChatUserProvider extends ChangeNotifier {
  List? listchatUsers;
  List? student;
  List? teacher;
  List? parent;
  Dio _dio = Dio();
  List _allusers = [];
  bool loading = false;

  setChatUsers(id) async {
    loading = true;
    notifyListeners();
    try {
      http.Response res =
          await http.get(Uri.parse("${Config.chatserverUrl}/users/${id}"));
      print("======================");
      Map response = jsonDecode(res.body);
      response = response['users'];
      var newResponse = [];
      // shortUsers() async {      // }
      for (var i = 0; i < response.length; i++) {
        Map userData = response[i];

// GEt LAst MEssage Here
        String url;
        if (userData['role'] == 'student') {
          url =
              ('${Config.chatserverUrl}/last_message/${id}/${userData['user_id']}');
        } else if (userData['role'] == 'teacher') {
          url =
              ('${Config.chatserverUrl}/last_message/${id}/${userData['profile']['useridname_password']['userid_name']}');
        } else {
          url =
              ('${Config.chatserverUrl}/last_message/${userData['parent_useridname']}/${id}');
        }
        print("=======PRINT ON HERE==========");
        print(url);
        var data = await _dio.get(url);
        print({
          ...response,
          "created_at": data.data['created_at'],
          "message": data.data['message']
        });
      }

      listchatUsers = response['users'];
      _allusers = response['users'];
      loading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      _allusers = [];
      loading = false;
      notifyListeners();
    }
  }

  sortsetChatUsers(by) {
    student = [];
    teacher = [];
    parent = [];
    listchatUsers = [];
    notifyListeners();
    for (Map data in _allusers!) {
      if (data['role'] == by) {
        listchatUsers!.add(data);
      }
    }
    switch (by) {
      case 'student':
        student = listchatUsers;
        break;
      case 'teacher':
        teacher = listchatUsers;
        break;
      case 'parent':
        parent = listchatUsers;
        break;
      default:
        listchatUsers = _allusers;
    }

    notifyListeners();
  }

  resetChatUsers() {
    listchatUsers = _allusers;
    notifyListeners();
  }
}

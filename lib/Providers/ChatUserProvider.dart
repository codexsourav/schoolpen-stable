import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../data/Network/config.dart';

class ChatUserProvider extends ChangeNotifier {
  List? listchatUsers;
  List? student;
  List? teacher;
  List? parent;

  List _allusers = [];
  bool loading = false;

  setChatUsers(id) async {
    loading = true;
    notifyListeners();
    try {
      http.Response res =
          await http.get(Uri.parse("${Config.chatserverUrl}/users/${id}"));
      print("======================");
      var response = jsonDecode(res.body);
      print(response);
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

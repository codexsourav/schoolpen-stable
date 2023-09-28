import 'package:http/src/streamed_response.dart';

class SearchProfileModel {
  String? _sId;
  String? _about;
  String? _gender;
  String? _role;
  String? _statusDescription;
  String? _statusTitle;
  String? _userId;
  String? _userImage;
  String? _username;

  SearchProfileModel(StreamedResponse res,
      {String? sId,
      String? about,
      String? gender,
      String? role,
      String? statusDescription,
      String? statusTitle,
      String? userId,
      String? userImage,
      String? username}) {
    if (sId != null) {
      _sId = sId;
    }
    if (about != null) {
      _about = about;
    }
    if (gender != null) {
      _gender = gender;
    }
    if (role != null) {
      _role = role;
    }
    if (statusDescription != null) {
      _statusDescription = statusDescription;
    }
    if (statusTitle != null) {
      _statusTitle = statusTitle;
    }
    if (userId != null) {
      _userId = userId;
    }
    if (userImage != null) {
      _userImage = userImage;
    }
    if (username != null) {
      _username = username;
    }
  }

  String? get sId => _sId;
  set sId(String? sId) => _sId = sId;
  String? get about => _about;
  set about(String? about) => _about = about;
  String? get gender => _gender;
  set gender(String? gender) => _gender = gender;
  String? get role => _role;
  set role(String? role) => _role = role;
  String? get statusDescription => _statusDescription;
  set statusDescription(String? statusDescription) =>
      _statusDescription = statusDescription;
  String? get statusTitle => _statusTitle;
  set statusTitle(String? statusTitle) => _statusTitle = statusTitle;
  String? get userId => _userId;
  set userId(String? userId) => _userId = userId;
  String? get userImage => _userImage;
  set userImage(String? userImage) => _userImage = userImage;
  String? get username => _username;
  set username(String? username) => _username = username;

  SearchProfileModel.fromJson(Map<String, dynamic> json) {
    _sId = json['_id'];
    _about = json['about'];
    _gender = json['gender'];
    _role = json['role'];
    _statusDescription = json['status_description'];
    _statusTitle = json['status_title'];
    _userId = json['user_id'];
    _userImage = json['user_image'];
    _username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = _sId;
    data['about'] = _about;
    data['gender'] = _gender;
    data['role'] = _role;
    data['status_description'] = _statusDescription;
    data['status_title'] = _statusTitle;
    data['user_id'] = _userId;
    data['user_image'] = _userImage;
    data['username'] = _username;
    return data;
  }
}

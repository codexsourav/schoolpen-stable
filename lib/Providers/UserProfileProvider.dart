import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Screens/StartupDashBord/Models/ParentMoadel.dart';
import 'models/StudentProfilemodels.dart';
import 'models/TeacherProfilemodels.dart';

class UserProfileProvider extends ChangeNotifier {
  String? dbid;
  String? userid;
  String? roal;
  StudentProfileModel? profileData;
  TeacherProfileModel? teacherdata;
  ParentProfileDataModel? parentprofile;

  setProfileData(data) {
    profileData = StudentProfileModel.fromJson(data);
    dbid = profileData!.sId;
    roal = 'student';
    userid = profileData!.userId;
    notifyListeners();
  }

  setTeacherData(data) {
    teacherdata = TeacherProfileModel.fromJson(data);
    print(data);
    dbid = teacherdata!.profile!.useridnamePassword!.useridName;
    userid = teacherdata!.profile!.useridnamePassword!.useridName;
    roal = "teacher";
    notifyListeners();
  }

  setParentData(data) {
    parentprofile = ParentProfileDataModel.fromJson(data);
    dbid = parentprofile!.parentUseridname;
    userid = parentprofile!.parentUseridname;
    roal = 'parent';
    notifyListeners();
  }

  userlogout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  setUSerAuthCradencials(
      {required usernameid, required useroal, required String id}) {}
}

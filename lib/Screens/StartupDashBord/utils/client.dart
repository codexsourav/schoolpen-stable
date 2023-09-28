import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:schoolpenintern/Screens/Profile/ViewProfile/view_parent_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Providers/UserProfileProvider.dart';
import '../../../data/Network/api_network.dart';
import '../../../data/Network/config.dart';
import '../../Student/home_screen.dart';
import '../Models/signup_model.dart';

class ProfileController extends GetxController {
  RxString futureRole = "".obs;
  RxString role = "".obs;
  RxString name = "".obs;
  RxString region = "".obs;
  Future<signupModel?> logIn(context, String username, String password) async {
    try {
      final requestData = {
        'username': username,
        'password': password,
      };
      final dio = Dio();
      const url = '${Config.hostUrl}/login_user';
      final response = await dio.post(url,
          data: jsonEncode(requestData),
          options: Options(
            contentType: Headers.jsonContentType,
          ));
      if (response.statusCode == 200) {
        print(response.data);
        print(signupModel.fromJson(response.data).message);
        print(signupModel.fromJson(response.data).userId);
        print(response.data);
        return signupModel.fromJson(response.data);
        // print(response.data);
        // print(signupModel.fromJson(response.data).message);
        // print(signupModel.fromJson(response.data).userId);

        // bool res =
        //     await Provider.of<UserProfileProvider>(context, listen: false)
        //         .setUSerAuthCradencials(
        //   usernameid: response.data['user_id'],
        //   useroal: response.data["role"],
        //   id: "",
        // );
        // if (res) {
        //   Fluttertoast.showToast(
        //       msg: SignupModel.fromJson(response.data).message!);

        // bool res =
        //     await Provider.of<UserProfileProvider>(context, listen: false)
        //         .setUSerAuthCradencials(
        //   usernameid: response.data['user_id'],
        //   useroal: response.data["role"],
        //   id: "",
        // );
        // if (res) {
        //   Fluttertoast.showToast(
        //       msg: SignupModel.fromJson(response.data).message!);

        //   Get.offAll(const StudentHomeScreen());
        // } else {
        //   Fluttertoast.showToast(msg: "Something went wrong");
        // }
        // print("============================================");
        //   Get.offAll(const StudentHomeScreen());
        // } else {
        //   Fluttertoast.showToast(msg: "Something went wrong");
        // }
      } else {
        Fluttertoast.showToast(
            msg: signupModel.fromJson(response.data).message!);
        print(response.statusCode);
        return null;
      }
    } on DioException catch (e) {
      if (e.response!.data != null) {
        Fluttertoast.showToast(
            msg: signupModel.fromJson(e.response!.data).message ??
                "Something went wrong");
      }
      return null;
    }
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import 'package:schoolpenintern/Screens/Profile/ViewProfile/view_parent_profile.dart';
import 'package:schoolpenintern/Screens/Student/home_screen.dart';
import 'package:schoolpenintern/data/Network/api_network.dart';

import '../Providers/UserProfileProvider.dart';
import '../Routes/routes_names.dart';
import '../bloc/main_bloc/main_bloc.dart';
import 'StartupDashBord/views/admin_user.dart';
import 'Teacher/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // Provider.of<UserProfileProvider>(context).userlogout();
    Timer(
      const Duration(seconds: 3),
      () => BlocProvider.of<AppSetUpBloc>(context).add(HomeEvent()),

      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) {

      //       return StudentHomeScreen();
      //     },
      //   ),
      // ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppSetUpBloc, InitialStates>(
      listener: (context, state) async {
        if (state is StudentScreenState) {
          try {
            var res =
                await ApiNetwork.sendGetRequest('get_user/' + state.username);
            Provider.of<UserProfileProvider>(context, listen: false)
                .setProfileData(res);
            Get.offAll(
              const StudentHomeScreen(
                role: 'student',
              ),
            );
          } catch (e) {
            Fluttertoast.showToast(msg: "Check Your Internet");
          }
        } else if (state is TeacherScreenState) {
          try {
            var res = await ApiNetwork.sendGetRequest(
                'get_teacher_profile/' + state.username);
            Provider.of<UserProfileProvider>(context, listen: false)
                .setTeacherData(res);
            Get.offAll(const TeacherHomePage());
            print(res);
          } catch (e) {
            Fluttertoast.showToast(msg: "Check Your Internet");
          }
        } else if (state is ParentScreenState) {
          try {
            var res = await ApiNetwork.sendGetRequest(
                'get_parent_data/' + state.username);
            Provider.of<UserProfileProvider>(context, listen: false)
                .setParentData(res);
            Get.offAll(ViewParentProfile());
          } catch (e) {
            print(e);
            Fluttertoast.showToast(msg: "Check Your Internet");
          }
        } else {
          Get.offAll(const RoleScreen());
        }
      },
      child: Scaffold(
        body: splashScreen(context),
      ),
    );
  }
}

Widget splashScreen(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/Group3862.png'),
        const SizedBox(
          height: 25,
        ),
        Image.asset('assets/SchoolPen.png'),
        const SizedBox(
          height: 25,
        ),
        const CircularProgressIndicator(
          color: Color(0xFF9163D7),
        ),
      ],
    ),
  );
}
// sharedpref() async{
//        final SharedPreferences prefs = await SharedPreferences.getInstance();
//        if (prefs.getString("user_id") != null &&
//           prefs.getString("roal") != null) {
//         if (prefs.getString("roal") == "student") {
//           Get.to(()=>StudentHomeScreen());
//         } else if (prefs.getString("roal") == "teacher") {
//            Get.to(()=>TeacherHomePage());
//         } else if (prefs.getString("roal") == "parent") {
//           Fluttertoast.showToast(msg: "Not implemented");
          
//         } else {
//           Get.to(()=>RoleScreen());
//         }

//           }else{
//             Get.to(()=>RoleScreen());
//           }
// }
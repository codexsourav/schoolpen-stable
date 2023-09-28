import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:schoolpenintern/Providers/UserProfileProvider.dart';
import 'package:schoolpenintern/Screens/Profile/ViewUserProfile.dart';

import '../../../Theme/Colors/appcolors.dart';
import '../../../utiles/LoadImage.dart';
import '../ChatRequest/RequestPage.dart';

AppBar chatHomeAppbar(context, {role, image, uid}) {
  print("thisuis if=======================" + uid);
  return AppBar(
    centerTitle: true,
    leading: IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: Icon(
        Icons.arrow_back_ios_rounded,
        color: role == "student"
            ? AppColors.purple
            : role == "teacher"
                ? AppColors.pinkDarkcolor
                : const Color.fromARGB(255, 117, 185, 119),
      ),
    ),
    title: Text(
      "Chat",
      style: TextStyle(color: AppColors.graymdm, fontWeight: FontWeight.w400),
    ),
    actions: [
      IconButton(
        onPressed: () {
          Get.to(RequestPage(
            id: uid,
          ));
        },
        icon: const Icon(Icons.notifications),
        color: role == "student"
            ? AppColors.purple
            : role == "teacher"
                ? AppColors.pinkDarkcolor
                : const Color.fromARGB(255, 117, 185, 119),
      ),
      const SizedBox(width: 20),
      GestureDetector(
        onTap: () {
          if (role == 'student') {
            Get.to(ViewUserProfile(
              role: 'student',
              userid: uid,
            ));
          } else if (role == 'teacher') {
            Get.to(
              ViewUserProfile(
                role: 'teacher',
                userid: uid,
              ),
            );
          } else if (role == 'parent') {
            print(role);
            Get.to(
              ViewUserProfile(
                role: 'parent',
                userid: uid,
              ),
            );
          } else {
            Fluttertoast.showToast(msg: "I Dont Know Who Are You");
          }
        },
        child: Container(
          height: 35,
          width: 35,
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              loadImage(image, role),
            ),
          ),
        ),
      ),
      const SizedBox(width: 20),
    ],
  );
}

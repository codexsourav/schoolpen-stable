import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:schoolpenintern/Screens/Teacher/Theme/Colors/appcolors.dart';

import '../../Providers/UserProfileProvider.dart';
import '../StartupDashBord/views/admin_user.dart';

class TeacherDrawerScreen extends StatefulWidget {
  const TeacherDrawerScreen(
      {super.key,
      required this.schoolName,
      required this.location,
      required this.profileImg});
  final String schoolName;
  final String location;
  final String profileImg;
  @override
  State<TeacherDrawerScreen> createState() => _TeacherDrawerScreenState();
}

class _TeacherDrawerScreenState extends State<TeacherDrawerScreen> {
  bool academicSubIcon = false;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Column(children: [
      Container(
        height: h * 0.1,
        margin: const EdgeInsets.only(top: 50, left: 20),
        child: Row(
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Image.asset("assets/about.png"),
            ),
            const SizedBox(
              width: 10,
            ),
            // .............................................// Add School Button Sections ^^^>>>>>>>>>>>>>>>>>>>>>

            GestureDetector(
              onTap: () {},
              child: Container(
                width: 150,
                height: 45,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Add school',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.parentPrimary,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            )

            //   Flexible(
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Text(
            //           "Hrllo",
            //           maxLines: 2,
            //           overflow: TextOverflow.ellipsis,
            //           style: TextStyle(
            //             color: Colors.white,
            //             fontWeight: FontWeight.bold,
            //             fontSize: w * 0.05,
            //           ),
            //         ),
            //         Text(
            //           widget.location,
            //           overflow: TextOverflow.ellipsis,
            //           maxLines: 1,
            //           style: TextStyle(
            //             color: Colors.white,
            //             fontSize: w * 0.04,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            //
          ],
        ),
      ),
      ListTileTheme(
        textColor: Colors.white,
        iconColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.people_alt),
              title: const Text("Teacher"),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.person_rounded),
              title: const Text("Student"),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.library_books),
              title: const Text("Time Table"),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.edit_calendar_sharp),
              title: const Text("Attendance"),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.calendar_month),
              title: const Text("Calender"),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.push_pin),
              title: const Text("School Board"),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.currency_rupee),
              title: const Text("Subscription"),
            ),
            ListTile(
              onTap: () {
                Provider.of<UserProfileProvider>(context, listen: false)
                    .userlogout();
                Get.offAll(RoleScreen());
              },
              leading: const Icon(Icons.output),
              title: const Text("Exit"),
            ),
          ],
        ),
      ),
    ]);
  }
}

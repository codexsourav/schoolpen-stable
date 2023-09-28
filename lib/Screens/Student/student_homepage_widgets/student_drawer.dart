import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:schoolpenintern/Providers/UserProfileProvider.dart';
import 'package:schoolpenintern/Screens/StartupDashBord/views/admin_user.dart';

import '../../SearchUser/SearchUsers.dart';

class StudentDrawerScreen extends StatefulWidget {
  const StudentDrawerScreen(
      {super.key,
      required this.schoolName,
      required this.location,
      required this.profileImg});
  final String schoolName;
  final String location;
  final String profileImg;
  @override
  State<StudentDrawerScreen> createState() => _StudentDrawerScreenState();
}

class _StudentDrawerScreenState extends State<StudentDrawerScreen> {
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
                      color: Color(0xFF9163D7),
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
              leading: const Icon(Icons.person_rounded),
              title: const Text("Teacher"),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.people_alt),
              title: const Text("Classmates"),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.library_books),
              title: const Text("Syllabus"),
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
              // trailing: ,
              title: const Text("School Board"),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.currency_rupee),
              title: const Text("Fee Portal"),
            ),
            SizedBox(height: h * 0.12),
            ListTile(
              onTap: () {
                Provider.of<UserProfileProvider>(context, listen: false)
                    .userlogout();
                Get.offAll(const RoleScreen());
              },
              leading: const Icon(Icons.logout),
              title: const Text("Exit"),
            ),
          ],
        ),
      ),
    ]);
  }
}

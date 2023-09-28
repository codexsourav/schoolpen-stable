import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:schoolpenintern/utiles/LoadImage.dart';

import '../../../Providers/UserProfileProvider.dart';
import '../../Profile/ViewUserProfile.dart';
import '../../StartupDashBord/views/admin_user.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({
    super.key,
    required this.location,
  });

  final String location;

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  bool academicSubIcon = false;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Column(children: [
      GestureDetector(
        onTap: () {
          Get.to(ViewUserProfile(
              userid: Provider.of<UserProfileProvider>(context, listen: false)
                  .parentprofile!
                  .parentUseridname
                  .toString(),
              role: 'parent'));
        },
        child: Container(
          height: h * 0.1,
          margin: const EdgeInsets.only(top: 50, left: 20),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Image.network(
                    loadImage(
                        Provider.of<UserProfileProvider>(context, listen: false)
                            .parentprofile!
                            .parentImage
                            .toString(),
                        "parent"),
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Provider.of<UserProfileProvider>(context, listen: false)
                          .parentprofile!
                          .parentName
                          .toString(),
                      maxLines: 3,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: w * 0.05,
                      ),
                    ),
                    Text(
                      Provider.of<UserProfileProvider>(context, listen: false)
                          .parentprofile!
                          .parentUseridname
                          .toString(),
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: w * 0.04,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
              title: const Text("Management"),
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

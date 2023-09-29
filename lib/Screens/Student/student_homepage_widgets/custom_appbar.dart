import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:schoolpenintern/Providers/UserProfileProvider.dart';
import 'package:schoolpenintern/Screens/Profile/ViewUserProfile.dart';
import 'package:schoolpenintern/Screens/Student/student_homepage_widgets/appbar_icon_widget.dart';

import '../../../utiles/LoadImage.dart';

class StudentCustomAppbarWidget extends StatelessWidget {
  const StudentCustomAppbarWidget({
    super.key,
    required this.controller,
  });

  final AdvancedDrawerController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 180,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                controller.showDrawer();
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  // top: 28,
                  left: 20,
                ),
                child: SvgPicture.asset(
                  "assets/images/student_section_images/homepage_images/header_images/hamburger_icon.svg",
                  width: 30,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Spacer(),
            Row(
              children: [
                AppbarIconWidget(),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(ViewUserProfile(
                            userid: Provider.of<UserProfileProvider>(context,
                                    listen: false)
                                .userid
                                .toString(),
                            role: 'student'));
                      },
                      child: Image.network(
                        loadImage(
                            Provider.of<UserProfileProvider>(context,
                                    listen: false)
                                .profileData!
                                .userImage,
                            "student"),
                        // "https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80",
                        // "https://m.media-amazon.com/images/I/41EvGpCFECL._AC_UF1000,1000_QL80_.jpg",
                        width: 36,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromRGBO(248, 96, 5, 1),
          Color.fromRGBO(248, 209, 5, 1),
          // Color.fromRGBO(242, 154, 102, 0),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)));
  }
}

class TeacherCustomAppbar extends StatelessWidget {
  final AdvancedDrawerController controller;
  const TeacherCustomAppbar({super.key, required this.controller});
  @override
  Widget build(BuildContext context) {
    UserProfileProvider userData = Provider.of<UserProfileProvider>(context);
    return Container(
        height: 200,
        child: Row(
          children: [
            Spacer(),
            Row(
              children: [
                AppbarIconWidget(),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        loadImage(
                            Provider.of<UserProfileProvider>(context)
                                .teacherdata!
                                .userImage
                                .toString(),
                            "teacher"),
                        width: 36,
                        height: 36,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/images/parent_bg.png",
              ),
              fit: BoxFit.fitWidth),
        ));
    ;
  }
}

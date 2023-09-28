import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:schoolpenintern/Providers/UserProfileProvider.dart';
import 'package:schoolpenintern/Screens/Student/student_homepage_widgets/appbar_icon_widget.dart';
import '../../../data/Network/config.dart';

import '../../../utiles/LoadImage.dart';
import '../../Profile/ViewProfile/view_student_profile.dart';
import '../../Profile/ViewUserProfile.dart';

class HeaderWidget extends StatelessWidget {
  final String role;
  AdvancedDrawerController drawerController = AdvancedDrawerController();

  HeaderWidget({
    super.key,
    required this.role,
    required this.drawerController,
  });

  @override
  Widget build(BuildContext context) {
    var getdata = Provider.of<UserProfileProvider>(context);
    print("===============================================");
    print(getdata.dbid);
    final screenWidth = MediaQuery.of(context).size.width;
// <<<<<<< checkit
    return Consumer<UserProfileProvider>(
      builder: (context, value, child) {
        return Stack(
          children: [
            // SvgPicture.asset(
            //   "assets/images/student_section_images/homepage_images/header_images/header_background_1.svg",
            //   width: screenWidth,
            //   fit: BoxFit.cover,
            // ),

            Image.asset(
              "assets/Vector.png",
              width: screenWidth,
              // height: 200,
              fit: BoxFit.cover,
            ),
            SvgPicture.asset(
              "assets/images/student_section_images/homepage_images/header_images/header_background_2.svg",
              width: screenWidth,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 45,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  drawerController.showDrawer();
                },
                child: SvgPicture.asset(
                  "assets/images/student_section_images/homepage_images/header_images/hamburger_icon.svg",
                  width: 30,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 100,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // value.userlogout();
                        },
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => ViewUserProfile(
                                  role: 'student',
                                  userid: Provider.of<UserProfileProvider>(
                                          context,
                                          listen: false)
                                      .userid
                                      .toString(),
                                ));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              loadImage(
                                  getdata.profileData!.userImage, "student"),
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: SizedBox(
                            width: 140,
                            child:
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Welcome back",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  // "",
                                  // "${data.profileData!.username}",
                                  "${getdata.profileData!.username}",
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            )
                            //   ],
                            // ),
                            // =======
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     const Text(
                            //       "Welcome back",
                            //       style: TextStyle(
                            //           fontSize: 16, fontWeight: FontWeight.w400),
                            //     ),
                            //     Text(
                            //       // "",
                            //       // "${data.profileData!.username}",
                            //       data.profileData!.username.toString(),
                            //       style: const TextStyle(
                            //           fontSize: 22, fontWeight: FontWeight.w700),
                            //     ),
                            // ],
                            // >>>>>>> master
                            ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const AppbarIconWidget()
                  // SizedBox(
                  //   width: 140,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       SvgPicture.asset(
                  //         "assets/images/student_section_images/homepage_images/header_images/search_icon.svg",
                  //         width: 36,
                  //       ),
                  //       GestureDetector(
                  //         onTap: () => Get.to(ChatHomeScreen(
                  //           myid: value.dbid.toString(),
                  //           image: value.profileData!.userImage.toString(),
                  //           role: value.roal.toString(),
                  //         )),
                  //         child: SvgPicture.asset(
                  //           "assets/images/student_section_images/homepage_images/header_images/chat_icon.svg",
                  //           width: 36,
                  //         ),
                  //       ),
                  //       SvgPicture.asset(
                  //         "assets/images/student_section_images/homepage_images/header_images/notification_icon.svg",
                  //         width: 36,
                  //       ),
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ),
            Positioned(
              right: 13,
              top: 104,
              child: Image.asset(
                "assets/images/student_section_images/homepage_images/header_images/girl_image.png",
                width: 159,
              ),
            ),
          ],
        );
      },
    );
  }
}

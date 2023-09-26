import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:schoolpenintern/Providers/UserProfileProvider.dart';

import '../../Chat/ChatHome/ChatHomeScreen.dart';

class AppbarIconWidget extends StatelessWidget {
  const AppbarIconWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    UserProfileProvider userData = Provider.of<UserProfileProvider>(context);
    return SizedBox(
      width: 140,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(
            "assets/images/student_section_images/homepage_images/header_images/search_icon.svg",
            width: 36,
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => ChatHomeScreen(
                    myid: userData.dbid.toString(),
                    myuserid: userData.userid.toString(),
                    image: userData.profileData!.userImage.toString(),
                    role: userData.profileData!.role.toString(),
                  ));
            },
            child: SvgPicture.asset(
              "assets/images/student_section_images/homepage_images/header_images/chat_icon.svg",
              width: 36,
            ),
          ),
          SvgPicture.asset(
            "assets/images/student_section_images/homepage_images/header_images/notification_icon.svg",
            width: 36,
          ),
        ],
      ),
    );
  }
}

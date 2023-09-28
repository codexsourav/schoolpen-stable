import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:schoolpenintern/Providers/UserProfileProvider.dart';

import 'package:schoolpenintern/Screens/Profile/ViewProfile/view_student_profile.dart';

import '../../Profile/ViewUserProfile.dart';
import '../../constants/strings.dart';
import '../constants/ConstantColors.dart';

class CommonTextfield extends StatelessWidget {
  final String Text;
  final String type;
  final TextEditingController inputcontroller;
  const CommonTextfield(
      {super.key,
      required this.Text,
      required this.inputcontroller,
      required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 241, 234, 250),
          borderRadius: BorderRadius.circular(32)),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 65,
      child: TextField(
        obscureText: type == "pwd" ? true : false,
        controller: inputcontroller,
        decoration: InputDecoration(
            hintText: Text,
            hintStyle: GoogleFonts.lato(),
            border: const OutlineInputBorder(borderSide: BorderSide.none)),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final bool loading;
  final VoidCallback callback;
  const CustomButton({
    super.key,
    required this.callback,
    required this.text,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      height: 60,
      width: MediaQuery.of(context).size.width * 0.9,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(ConstantColors.buttonClr),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ))),
        onPressed: callback,
        child: loading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(text,
                style: GoogleFonts.lato(fontSize: 18, color: Colors.white)),
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  final Color selectedCol;
  final VoidCallback callback;
  final String text;
  const CategoryWidget(
      {super.key,
      required this.text,
      required this.callback,
      required this.selectedCol});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        child: Center(
            child: Text(
          text,
          style: GoogleFonts.lato(
              fontSize: 14,
              color: selectedCol == ConstantColors.buttonClr
                  ? Colors.white
                  : Colors.black),
        )),
        width: 145,
        height: 55,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: selectedCol),
      ),
    );
  }
}

class MultiTextInputField extends StatelessWidget {
  final Color color;
  final bool isNumbered;
  final String title;
  final String hinttext1;
  final String hinttext2;
  final TextEditingController controller1;
  final TextEditingController controller2;
  MultiTextInputField(
      {super.key,
      required this.controller1,
      required this.controller2,
      required this.title,
      required this.hinttext1,
      required this.hinttext2,
      required this.isNumbered,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            title,
            textAlign: TextAlign.left,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(30)),
                width: MediaQuery.of(context).size.width * 0.9 / 2,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    keyboardType: TextInputType.streetAddress,
                    controller: controller1,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: hinttext1,
                        hintStyle: const TextStyle(color: Colors.grey)),
                  ),
                ),
              ),
            ),
            Container(
                height: 50,
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(30)),
                width: MediaQuery.of(context).size.width * 0.9 / 2.5,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    keyboardType: isNumbered
                        ? TextInputType.number
                        : TextInputType.streetAddress,
                    controller: controller2,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: hinttext2,
                        hintStyle: const TextStyle(color: Colors.grey)),
                  ),
                ))
          ],
        ),
      ],
    );
  }
}

class HeaderWidget1 extends StatelessWidget {
  final String role;
  const HeaderWidget1({
    super.key,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Consumer<UserProfileProvider>(
      builder: (context, value, child) {
        return Stack(
          children: [
            SvgPicture.asset(
              "assets/images/bgteacher_top_background.svg",
              width: screenWidth,
              fit: BoxFit.cover,
            ),
            SvgPicture.asset(
              "assets/images/bgteacher_top_background.svg",
              width: screenWidth,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 45,
              left: 20,
              child: SvgPicture.asset(
                "assets/images/bgteacher_top_background.svg",
                width: 30,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 100,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                              // "https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80",
                              "https://m.media-amazon.com/images/I/41EvGpCFECL._AC_UF1000,1000_QL80_.jpg",
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Welcome back",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          Consumer<UserProfileProvider>(
                              builder: (context, value, child) {
                            return const Text(
                              "Rishabh",
                              // value.profileData!.username.toString() ?? "",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                            );
                          })
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: 140,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.search,
                            color: AppColors.parentPrimary,
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              // Get.to(()=>ChatHomeScreen(role: "student"));
                            },
                            child: const CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.messenger,
                                color: AppColors.parentPrimary,
                              ),
                            )),
                        const CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.notifications,
                            color: AppColors.parentPrimary,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

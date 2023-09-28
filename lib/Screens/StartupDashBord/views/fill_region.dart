import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:schoolpenintern/Providers/AddUsersProvider.dart';
import 'package:schoolpenintern/Providers/UserProfileProvider.dart';

import '../../../utiles/reagins.dart';
import '../../Profile/Addprofile/Components/SelectOptionDropDown.dart';
import '../constants/ConstantStrings.dart';
import '../utils/Common_widgets.dart';
import '../utils/client.dart';
import 'choose_profile.dart';

class FillRegion extends StatefulWidget {
  FillRegion({super.key});

  @override
  State<FillRegion> createState() => _FillRegionState();
}

class _FillRegionState extends State<FillRegion> {
  String? reagins;
  String? city;

  ProfileController profileController = Get.put(ProfileController());

  TextEditingController regionControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                "assets/initimages/background_3.png",
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.07,
              ),
              child: Text(
                "Welcome ${profileController.name.value},\nWhat is your region?",
                textAlign: TextAlign.left,
                style: GoogleFonts.lato(
                    color: const Color(0xff9163D7),
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.03),
              child: Center(
                // child: CommonTextfield(
                //   type: "Normal",
                //   Text: ConstantString.str8,
                //   inputcontroller: regionControler,
                // ),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Column(
                      children: [
                        SelectOptionDropDown(
                          // padding: inputPadding,
                          title: "",
                          inputfillColor:
                              const Color.fromARGB(111, 251, 227, 255),
                          value: reagins,
                          items: [...reagainData.keys],
                          hintText: "Select Your Region",
                          onChenge: (v) {
                            setState(() {
                              reagins = v;
                            });
                            // dataProvider.setData(getuserClass: v);
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        reagins != null
                            ? SelectOptionDropDown(
                                // padding: inputPadding,
                                title: "",
                                inputfillColor:
                                    const Color.fromARGB(111, 251, 227, 255),
                                value: city,
                                items: [...reagainData[reagins]],
                                hintText: "Select Your City",
                                onChenge: (v) {
                                  setState(() {
                                    city = v;
                                  });
                                  return null;
                                },
                              )
                            : const SizedBox(),
                      ],
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Center(
                child: CustomButton(
                  callback: () {
                    if (reagins != null && city != null) {
                      Provider.of<AddUsersProvider>(context, listen: false)
                          .setData(setregion: "$reagins ==> $city");
                      Get.to(
                        () => ChooseProfile(),
                        transition: Transition.fadeIn,
                      );
                    } else {
                      Fluttertoast.showToast(
                        msg: "Please Selct Your Region",
                      );
                    }
                  },
                  text: ConstantString.str6,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

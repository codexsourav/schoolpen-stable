import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:schoolpenintern/Screens/constants/strings.dart';

import 'components/custom_button.dart';

class ProfileFormPage extends StatefulWidget {
  const ProfileFormPage({
    super.key,
  });

  @override
  _ProfileFormPageState createState() => _ProfileFormPageState();
}

class _ProfileFormPageState extends State<ProfileFormPage> {
  TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.432,
              child: Stack(children: [
                ClipPath(
                  clipper: OvalBottomBorderClipper(),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.30,
                    alignment: Alignment.bottomCenter,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppAssets.backDrop),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  // margin: const EdgeInsets.only(top: 80),
                  child: Image.asset(
                    AppAssets.thinking1,
                    fit: BoxFit.cover,
                    width: 250,
                    height: 250,
                  ),
                ),
              ]),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                AppString.userNameTitle,
                style: TextStyle(
                    fontSize: 24,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: AppString.userName,
                  contentPadding: const EdgeInsets.only(
                    left: 20,
                    top: 40,
                  ),
                  fillColor: AppColors.lightPurple.withOpacity(0.3),
                  filled: true,
                  hintStyle: const TextStyle(
                      color: AppColors.lightGrey, fontWeight: FontWeight.w400),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(top: 150),
              child: const RoundedButton(
                  text: Text(AppString.next,
                      style: const TextStyle(
                          fontSize: 14, color: AppColors.white)),
                  width: 87,
                  height: 55,
                  bg: AppColors.primary),
            ),
          ],
        ),
      )),
    );
  }
}

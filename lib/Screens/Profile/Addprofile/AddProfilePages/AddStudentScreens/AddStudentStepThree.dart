//  * Created by: Sourav Bapari
//  * ----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:schoolpenintern/Screens/StartupDashBord/views/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../Helper/snackBarHelper.dart';
import '../../../../../Providers/UserProfileProvider.dart';

import '../../../../../data/Network/api_network.dart';
import '../../../../Student/home_screen.dart';
import '../../Components/AddUsersAppBar.dart';
import '../../Components/InputBox.dart';
import '../../Components/SubmitButton.dart';
import '../../Validator/Validate.dart';
import '../../../../../Providers/AddUsersProvider.dart';
import '../../Components/StepsBar.dart';

class AddStudentStepThree extends StatefulWidget {
  const AddStudentStepThree({super.key});

  @override
  State<AddStudentStepThree> createState() => AddStudentStepThreeState();
}

class AddStudentStepThreeState extends State<AddStudentStepThree> {
  Color themeDark = const Color(0xFF9163D7);
  Color secColor = const Color(0x4CE7D8F8);

  final GlobalKey<FormState> _formvaliduid = GlobalKey<FormState>();
  final GlobalKey<FormState> _formvalidpass = GlobalKey<FormState>();
  final GlobalKey<FormState> _formvalidcpass = GlobalKey<FormState>();

  TextEditingController uid = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController cpass = TextEditingController();

  EdgeInsets inputPadding =
      const EdgeInsets.only(left: 15, bottom: 10, top: 20);

  checkvalidate() async {
    AddUsersProvider dataProvider =
        Provider.of<AddUsersProvider>(context, listen: false);
    dataProvider.setData(
        getuserid: uid.text, getpassword: pass.text, repassword: cpass.text);
    if (pass.text != cpass.text) {
      showSnackBar(
        context,
        message: "Password Not Matched!",
        color: Colors.red,
      );
    } else {
      var addDataresponse = await dataProvider.addStudentDatabase(context);
      if (addDataresponse != false) {
        print(addDataresponse);

        try {
          var res = await ApiNetwork.sendGetRequest(
            'get_user/' + addDataresponse['user_id'],
          );
          Provider.of<UserProfileProvider>(context, listen: false)
              .setProfileData(res);
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("roal", "student");
          prefs.setString("user_id", res['user_id']);
          Get.offAll(StudentHomeScreen(
            role: "student",
          ));
        } catch (e) {
          print(e);
          Get.offAll(Login());
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    AddUsersProvider dataProvider =
        Provider.of<AddUsersProvider>(context, listen: false);
    uid.text = dataProvider.userid ?? "";
    pass.text = dataProvider.pass ?? "";
    cpass.text = dataProvider.cpass ?? "";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: addUsersAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: StepBar(
                  steps: [
                    StepOption(
                      title: "Personal Info",
                      themecolor: themeDark,
                      done: true,
                      checked: true,
                    ),
                    StepOption(
                      title: "School info",
                      themecolor: themeDark,
                      done: true,
                      checked: true,
                    ),
                    StepOption(
                      title: "Account info",
                      themecolor: themeDark,
                      done: true,
                    ),
                  ],
                  themecolor: themeDark,
                ),
              ),
              const SizedBox(height: 40),
              Form(
                key: _formvaliduid,
                child: InputBox(
                  padding: inputPadding,
                  cursorColor: themeDark,
                  inputfillColor: secColor,
                  title: "User id",
                  controller: uid,
                  validate: (e) {
                    if (int.tryParse(e ?? "") != null) {
                      return "Enter Some characters";
                    } else if (e!.length <= 5) {
                      return "Username Min 5 characters";
                    } else if (!RegExp(r'^[a-zA-Z_][a-zA-Z0-9_-]{5,20}$')
                        .hasMatch(
                      e.toString(),
                    )) {
                      return 'Invalid username. Must be 5-20 characters';
                    }
                    return null;
                  },
                ),
              ),
              Form(
                key: _formvalidpass,
                child: InputBox(
                  padding: inputPadding,
                  cursorColor: themeDark,
                  inputfillColor: secColor,
                  title: "Password",
                  secure: true,
                  controller: pass,
                  validate: (v) => Validate.isPasswordValid(v!),
                  keyupText: (v) {
                    _formvalidpass.currentState!.validate();
                    return null;
                  },
                ),
              ),
              Form(
                key: _formvalidcpass,
                child: InputBox(
                  padding: inputPadding,
                  cursorColor: themeDark,
                  inputfillColor: secColor,
                  title: "Retype password",
                  secure: true,
                  controller: cpass,
                  keyupText: (v) {
                    _formvalidcpass.currentState!.validate();
                    return null;
                  },
                  validate: (v) {
                    if (cpass.text != pass.text) {
                      return "PassWord Not Match";
                    }
                    return null;
                  },
                ),
              ),
              Consumer<AddUsersProvider>(
                builder: (context, value, child) {
                  return SubmitButton(
                    text: "Create Your Account",
                    color: themeDark,
                    loading: value.loading,
                    disabled: value.loading,
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    onPressed: () {
                      if (_formvaliduid.currentState!.validate() &&
                          _formvalidcpass.currentState!.validate() &&
                          _formvalidpass.currentState!.validate()) {
                        checkvalidate();
                      }
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

//  * Created by: Sourav Bapari
//  * ----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:schoolpenintern/Screens/Parents/parent_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../Helper/snackBarHelper.dart';
import '../../../../../Providers/UserProfileProvider.dart';
import '../../../../../data/Network/api_network.dart';
import '../../../../StartupDashBord/views/login_screen.dart';
import '../../../ViewProfile/view_parent_profile.dart';
import '../../Components/AddUsersAppBar.dart';
import '../../Components/InputBox.dart';
import '../../Components/SubmitButton.dart';
import '../../Validator/Validate.dart';
import '../../../../../Providers/AddUsersProvider.dart';
import '../../Components/StepsBar.dart';

class ParentAddStepTow extends StatefulWidget {
  const ParentAddStepTow({super.key});

  @override
  State<ParentAddStepTow> createState() => ParentAddStepTowState();
}

class ParentAddStepTowState extends State<ParentAddStepTow> {
  Color themeDark = const Color(0xFF56E484);
  Color secColor = const Color(0xFFEEFCF3);

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
      var resd = await dataProvider.addParentDatabase(context);

      //print("==============>" + resd);

      if (resd != false) {
        try {
          var res = await ApiNetwork.sendGetRequest(
            'get_parent_data/' + resd,
          );
          // ignore: use_build_context_synchronously
          Provider.of<UserProfileProvider>(context, listen: false)
              .setParentData(res);
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("roal", "parent");
          prefs.setString("user_id", res['parent_useridname']);
          Get.offAll(ParentHomePage());
        } catch (e) {
          Fluttertoast.showToast(msg: "A Error occured!!");
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
    pass.text = dataProvider.cpass ?? "";
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
                    text: "Submit",
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

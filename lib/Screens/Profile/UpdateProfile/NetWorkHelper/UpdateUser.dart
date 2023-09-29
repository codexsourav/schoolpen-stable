import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:schoolpenintern/Providers/UserProfileProvider.dart';
import 'package:schoolpenintern/Screens/Profile/Addprofile/Components/InputBox.dart';
import 'package:schoolpenintern/Screens/Profile/Addprofile/Components/SubmitButton.dart';
import 'package:schoolpenintern/Screens/Profile/Addprofile/Validator/Validate.dart';
import 'package:schoolpenintern/Screens/StartupDashBord/views/admin_user.dart';
import 'package:schoolpenintern/data/Network/config.dart';

class UpdateUser {
  Future<Map> updateUserData(route,
      {required Map<String, String> data,
      required String userId,
      String? file}) async {
    var url = Uri.parse('${Config.hostUrl}$route/$userId');

    print("========UPDATE DATA==========");
    print(url);
    print(data);
    var req = http.MultipartRequest('PUT', url);
    req.fields.addAll(data);
    if (file != null) {
      req.files.add(await http.MultipartFile.fromPath('user_image', file));
    }

    try {
      var res = await req.send();
      final resBody = await res.stream.bytesToString();
      Map resdata = jsonDecode(resBody) as Map;
      if (res.statusCode >= 200 && res.statusCode < 300) {
        return resdata;
      } else {
        print(resBody);
        if (resdata.containsKey('error')) {
          return {"error": resdata['error']};
        } else {
          return {"error": "Error!! Maybe Server Error"};
        }
      }
    } catch (e) {
      print('===============UPDATE ERROR=================');
      print(e);
      return {"error": "Error!! Data Not Updated"};
    }
  }

  String? getEndPoient(role) {
    if (role == "student") {
      return "/update_student_profile";
    } else if (role == 'teacher') {
      return "/update_teacher";
    } else if (role == 'parent') {
      return "/update_parent";
    } else {
      return null;
    }
  }

// Update Form Box User ID
  showUpdateProfileNameAlertDialog(BuildContext context,
      {color, darkcolor, id, oldusername, role, others = ''}) {
    getEndPoient(role);

    TextEditingController _username = TextEditingController(text: oldusername);
    TextEditingController _other = TextEditingController(text: others);

    GlobalKey<FormState> _form = GlobalKey();

    Future updatename() async {
      Map<String, String> studentData = {
        "username": _username.text,
      };

      Map<String, String> teacherData = {
        "username": _username.text,
        "languages": _other.text,
      };

      Map<String, String> parentData = {
        "parent_name": _username.text,
      };

// Get Usrr Date A pass here===============
      Map<String, String>? getData(role) {
        if (role == "student") {
          return studentData;
        } else if (role == 'teacher') {
          return teacherData;
        } else if (role == 'parent') {
          return parentData;
        } else {
          return null;
        }
      }

      Fluttertoast.showToast(msg: "Updating....");
      updateUserData(getEndPoient(role), data: getData(role)!, userId: id)
          .then((val) {
        if (val.containsKey('error')) {
          Fluttertoast.showToast(msg: val['error']);
        } else {
          Fluttertoast.showToast(msg: "Update Complete");
        }
      });
    }

    // set up the button
    Widget okButton = Padding(
      padding: const EdgeInsets.all(18.0),
      child: SubmitButton(
          color: darkcolor,
          text: "Update Detiles",
          onPressed: () {
            if (_form.currentState!.validate()) {
              updatename();
            }
          }),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      insetPadding: const EdgeInsets.all(10),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      titlePadding: const EdgeInsets.all(20),
      title: const Text("Update Detiles"),
      content: Form(
        key: _form,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InputBox(
                borderRadius: 10,
                title: "Name",
                padding: const EdgeInsets.only(bottom: 8, left: 8),
                cursorColor: darkcolor,
                inputfillColor: color,
                controller: _username,
              ),
              const SizedBox(height: 10),
              role == "teacher"
                  ? InputBox(
                      borderRadius: 10,
                      title: role == "teacher" ? "Languages" : "",
                      padding: const EdgeInsets.only(bottom: 8, left: 8),
                      cursorColor: darkcolor,
                      inputfillColor: color,
                      controller: _other,
                    )
                  : const SizedBox(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

// Update Form Box User ID
  showUpdateNameAlertDialog(BuildContext context,
      {color, darkcolor, id, oldusername, role}) {
    getEndPoient(role);

    TextEditingController _username = TextEditingController(text: oldusername);
    TextEditingController _pass = TextEditingController();
    TextEditingController _cpass = TextEditingController();

    GlobalKey<FormState> _form = GlobalKey();

    Future updateUsername() async {
      Map<String, String> studentData = {
        "user_id": _username.text,
        "password": _pass.text,
      };

      Map<String, String> teacherData = {
        "userid_name": _username.text,
        "password": _pass.text,
      };

      Map<String, String> parentData = {
        "parent_useridname": _username.text,
        "new_password": _pass.text,
      };

// Get Usrr Date A pass here===============
      Map<String, String>? getData(role) {
        if (role == "student") {
          return studentData;
        } else if (role == 'teacher') {
          return teacherData;
        } else if (role == 'parent') {
          return parentData;
        } else {
          return null;
        }
      }

      Fluttertoast.showToast(msg: "Updating....");
      updateUserData(getEndPoient(role), data: getData(role)!, userId: id)
          .then((val) {
        if (val.containsKey('error')) {
          Fluttertoast.showToast(msg: val['error']);
        } else {
          Fluttertoast.showToast(
              msg: "Update Complete UserId Changed To ${_username.text}");
          Provider.of<UserProfileProvider>(context, listen: false).userlogout();
          Get.offAll(const RoleScreen());
        }
      });
    }

    // set up the button
    Widget okButton = Padding(
      padding: const EdgeInsets.all(18.0),
      child: SubmitButton(
        color: darkcolor,
        text: "Update Info",
        onPressed: () {
          if (_form.currentState!.validate()) {
            if (_pass.text != _cpass.text) {
              Fluttertoast.showToast(msg: "Password Not Matched!");
            } else {
              updateUsername();
            }
          }
        },
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      insetPadding: const EdgeInsets.all(10),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      titlePadding: const EdgeInsets.all(20),
      title: const Text("Update UserID Or Password"),
      content: Form(
        key: _form,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InputBox(
                borderRadius: 10,
                title: "User ID",
                padding: const EdgeInsets.only(bottom: 8, left: 8),
                cursorColor: darkcolor,
                inputfillColor: color,
                controller: _username,
                validate: (u) => Validate.username(u),
              ),
              const SizedBox(height: 10),
              InputBox(
                borderRadius: 10,
                title: "Password",
                padding: const EdgeInsets.only(bottom: 8, left: 8),
                showeye: true,
                secure: true,
                cursorColor: darkcolor,
                inputfillColor: color,
                controller: _pass,
                validate: (p) => Validate.isPasswordValid(p!),
              ),
              const SizedBox(height: 10),
              InputBox(
                borderRadius: 10,
                title: "Re-type Password",
                padding: const EdgeInsets.only(bottom: 8, left: 8),
                showeye: true,
                secure: true,
                cursorColor: darkcolor,
                inputfillColor: color,
                controller: _cpass,
                validate: (p) => Validate.isPasswordValid(p!),
              ),
            ],
          ),
        ),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

// Update Name Fields
// Update Form Box User ID
  showAddressAlertDialog(BuildContext context,
      {color,
      darkcolor,
      id,
      phone,
      emailid,
      street,
      pincode,
      state,
      city,
      role}) {
    getEndPoient(role);

    TextEditingController _phone = TextEditingController(text: phone);
    TextEditingController _email = TextEditingController(text: emailid);
    TextEditingController _street = TextEditingController(text: street);
    TextEditingController _pincode = TextEditingController(text: pincode);
    TextEditingController _state = TextEditingController(text: state);
    TextEditingController _city = TextEditingController(text: city);

    GlobalKey<FormState> _form = GlobalKey();

    Future updateAddress() async {
      Map<String, String> studentData = {
        "phone": _phone.text,
        "email": _email.text,
        "street": _street.text,
        "city": _city.text,
        "state": _state.text,
        "pincode": _pincode.text,
      };

      Map<String, String> teacherData = {
        "phone": _phone.text,
        "email": _email.text,
        "street": _street.text,
        "city": _city.text,
        "state": _state.text,
        "postal_code": _pincode.text,
      };

      Map<String, String> parentData = {
        "parent_phone": _phone.text,
        "parent_email": _email.text,
        "parent_StreetAddress": _street.text,
        "parent_city": _city.text,
        "parent_state": _state.text,
        "parent_PostalCode": _pincode.text,
      };

// Get Usrr Date A pass here===============
      Map<String, String>? getData() {
        if (role == "student") {
          return studentData;
        } else if (role == 'teacher') {
          return teacherData;
        } else if (role == 'parent') {
          return parentData;
        } else {
          return null;
        }
      }

      Fluttertoast.showToast(msg: "Updating....");
      updateUserData(getEndPoient(role), data: getData()!, userId: id)
          .then((val) {
        print(val);
        if (val.containsKey('error')) {
          Fluttertoast.showToast(msg: val['error']);
        } else {
          Fluttertoast.showToast(msg: "Update Complete");
        }
      });
    }

    // set up the button
    Widget okButton = Padding(
      padding: const EdgeInsets.all(18.0),
      child: SubmitButton(
        color: darkcolor,
        text: "Update Info",
        onPressed: () {
          if (_form.currentState!.validate()) {
            updateAddress();
          }
        },
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      insetPadding: const EdgeInsets.all(10),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      titlePadding: const EdgeInsets.all(20),
      title: const Text("Update Your Contact Info"),
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 80,
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InputBox(
                  borderRadius: 10,
                  title: "Mobile Number",
                  padding: const EdgeInsets.only(bottom: 8, left: 8),
                  cursorColor: darkcolor,
                  inputfillColor: color,
                  controller: _phone,
                  textInputType: TextInputType.phone,
                  validate: (p) {
                    if (p!.length != 10) {
                      return "invalid Mobile Number";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 10),
                InputBox(
                  borderRadius: 10,
                  title: "Email Id",
                  padding: const EdgeInsets.only(bottom: 8, left: 8),
                  cursorColor: darkcolor,
                  inputfillColor: color,
                  controller: _email,
                  textInputType: TextInputType.emailAddress,
                  validate: (e) => Validate.fldisValidEmail(e!, "Email"),
                ),
                const SizedBox(height: 10),
                InputBox(
                  borderRadius: 10,
                  title: "Your Area",
                  padding: const EdgeInsets.only(bottom: 8, left: 8),
                  cursorColor: darkcolor,
                  inputfillColor: color,
                  controller: _street,
                ),
                const SizedBox(height: 10),
                InputBox(
                  borderRadius: 10,
                  title: "Your City",
                  padding: const EdgeInsets.only(bottom: 8, left: 8),
                  cursorColor: darkcolor,
                  inputfillColor: color,
                  controller: _city,
                ),
                const SizedBox(height: 10),
                InputBox(
                  borderRadius: 10,
                  title: "Your State",
                  padding: const EdgeInsets.only(bottom: 8, left: 8),
                  cursorColor: darkcolor,
                  inputfillColor: color,
                  controller: _state,
                ),
                const SizedBox(height: 10),
                InputBox(
                  borderRadius: 10,
                  title: "Postal Code",
                  padding: const EdgeInsets.only(bottom: 8, left: 8),
                  cursorColor: darkcolor,
                  inputfillColor: color,
                  controller: _pincode,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

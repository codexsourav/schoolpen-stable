//  * Created by: Abhill
//  * ----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:schoolpenintern/Screens/Profile/UpdateProfile/NetWorkHelper/UpdateUser.dart';

import '../../Providers/UserProfileProvider.dart';
import '../../Screens/Profile/Addprofile/Components/InputBox.dart';

class AboutCard extends StatefulWidget {
  String description;
  final String? role;

  final Color bgcolor;
  final bool isedit;
  final Function()? ontap;

  AboutCard(
      {super.key,
      required this.description,
      this.bgcolor = Colors.white,
      this.isedit = false,
      this.ontap,
      this.role});

  @override
  State<AboutCard> createState() => _AboutCardState();
}

class _AboutCardState extends State<AboutCard> {
  TextEditingController _aboutText = TextEditingController();
  UpdateUser updateData = UpdateUser();
  GlobalKey<FormState> _form = GlobalKey();
  bool showedit = false;

  updateAbout(id) {
    Map<String, String> studentData = {
      "about": _aboutText.text,
    };

    Map<String, String> teacherData = {
      "user_about": _aboutText.text,
    };

    Map<String, String> parentData = {
      "parent_about": _aboutText.text,
    };

// Get Usrr Date A pass here===============
    Map<String, String>? getData() {
      if (widget.role == "student") {
        return studentData;
      } else if (widget.role == 'teacher') {
        return teacherData;
      } else if (widget.role == 'parent') {
        return parentData;
      } else {
        return null;
      }
    }

// check And Send A Api Call
    if (widget.description == _aboutText.text) {
      setState(() {
        showedit = false;
      });
    } else if ((getData() != null &&
        updateData.getEndPoient(widget.role) != null)) {
      updateData
          .updateUserData(updateData.getEndPoient(widget.role),
              data: getData()!, userId: id)
          .then((response) {
        if (response.containsKey("error")) {
          setState(() {
            showedit = false;
          });
          Fluttertoast.showToast(msg: response['error']);
        } else {
          setState(() {
            showedit = false;
          });
          Fluttertoast.showToast(msg: "Your About is Updated");
        }
      });
    } else {
      setState(() {
        showedit = false;
      });
    }
  }

  @override
  void initState() {
    _aboutText.text = widget.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProfileProvider userData = Provider.of<UserProfileProvider>(context);
    return Container(
      decoration: BoxDecoration(
          color: widget.bgcolor, borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            GestureDetector(
              onTap: widget.ontap,
              child: Container(
                alignment: Alignment.topRight,
                child: widget.isedit
                    ? showedit
                        ? SizedBox()
                        : GestureDetector(
                            onTap: () => setState(() {
                                  showedit = true;
                                }),
                            child: const Icon(Icons.edit_square))
                    : const SizedBox(),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "About",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Builder(
                      builder: (context) {
                        if (showedit) {
                          return Column(
                            children: [
                              InputBox(
                                controller: _aboutText,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 10,
                                ),
                                title: "",
                                borderRadius: 10,
                                maxLines: 5,
                                inputfillColor: widget.bgcolor,
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                  onTap: () => updateAbout(userData.userid),
                                  child: const Icon(Icons.save),
                                ),
                              )
                            ],
                          );
                        } else {
                          return Text(_aboutText.text);
                        }
                      },
                    )),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:schoolpenintern/Providers/UserProfileProvider.dart';

import '../../../Profile/Addprofile/Components/InputBox.dart';
import '../../../Profile/Addprofile/Components/SubmitButton.dart';
import '../../../Profile/UpdateProfile/NetWorkHelper/UpdateUser.dart';

class StatusCard extends StatefulWidget {
  final String headline;
  final String description;
  final Color bgcolor;
  final bool isedit;
  final String role;

  const StatusCard({
    super.key,
    required this.headline,
    required this.description,
    this.bgcolor = Colors.white,
    this.isedit = false,
    required this.role,
  });

  @override
  State<StatusCard> createState() => _StatusCardState();
}

class _StatusCardState extends State<StatusCard> {
  UpdateUser updateData = UpdateUser();
  GlobalKey<FormState> _form = GlobalKey();
  bool showedit = false;
  TextEditingController _statusTitle = TextEditingController();
  TextEditingController _statusDescription = TextEditingController();
  @override
  void initState() {
    _statusTitle.text = widget.headline;
    _statusDescription.text = widget.description;
    super.initState();
  }

  updateUserStatus(id) async {
    Map<String, String> studentData = {
      "status_title": _statusTitle.text,
      "status_description": _statusDescription.text,
    };

    Map<String, String> teacherData = {
      "user_designation": _statusTitle.text,
      "user_description": _statusDescription.text
    };

    Map<String, String> getData() {
      if (widget.role == "student") {
        return studentData;
      } else {
        return teacherData;
      }
    }

    if (widget.headline == _statusTitle.text &&
        widget.description == _statusDescription.text) {
      setState(() {
        showedit = false;
      });
      return false;
    } else {
      updateData
          .updateUserData(updateData.getEndPoient(widget.role),
              data: getData(), userId: id)
          .then((res) {
        if (res.containsKey("error")) {
          Fluttertoast.showToast(msg: res['error']);
          setState(() {
            showedit = false;
          });
        } else {
          setState(() {
            showedit = false;
          });
          Fluttertoast.showToast(msg: "Status Updated");
          print(res);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProfileProvider userData = Provider.of<UserProfileProvider>(context);
    return Container(
      decoration: BoxDecoration(
          color: widget.bgcolor, borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            showedit
                ? Container(
                    child: Column(
                      children: [
                        Form(
                          key: _form,
                          child: Column(
                            children: [
                              InputBox(
                                title: "Status Title",
                                inputfillColor: widget.bgcolor,
                                hintText: "Status Title Here...",
                                controller: _statusTitle,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 5),
                              ),
                              SizedBox(height: 8),
                              InputBox(
                                title: "Status Description",
                                hintText: "Status Description Here...",
                                inputfillColor: widget.bgcolor,
                                maxLines: 3,
                                controller: _statusDescription,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 8),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                              onTap: () {
                                if (_form.currentState!.validate()) {
                                  updateUserStatus(userData.userid);
                                }
                              },
                              child: const Icon(Icons.save)),
                        )
                      ],
                    ),
                  )
                : const SizedBox(),
            !showedit
                ? Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Status",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20),
                          ),
                          const Spacer(),
                          widget.isedit
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showedit = true;
                                    });
                                  },
                                  child: const Icon(Icons.edit_square))
                              : const SizedBox(),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            _statusTitle.text,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(_statusDescription.text),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

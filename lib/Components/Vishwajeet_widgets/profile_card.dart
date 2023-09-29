import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:provider/provider.dart';

import '../../Providers/UserProfileProvider.dart';
import '../../Screens/Profile/UpdateProfile/NetWorkHelper/UpdateUser.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({
    super.key,
    required this.backGroundColor,
    required this.userName,
    required this.isStudent,
    required this.std,
    required this.buttonColor,
    required this.onCall,
    this.onMessage,
    required this.image,
    this.edit = false,
    this.borderRedius = 20,
    this.borderwidth = 0,
    this.role,
  });
  final String? role;
  final Color backGroundColor;
  final Color buttonColor;
  final String userName;
  final bool isStudent;
  final String std;
  final double borderRedius;
  final double borderwidth;

  final Function()? onCall;
  final Function()? onMessage;
  final String image;
  final bool edit;

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  UpdateUser updateData = UpdateUser();
  File? updateimage;
  bool loading = false;

  void setImage(id) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      File file = File(result.files.single.path.toString());

      setState(() {
        updateimage = file;
      });

      setState(() {
        loading = true;
      });
      updateData
          .updateUserData(updateData.getEndPoient(widget.role),
              data: {}, userId: id, file: file.path)
          .then((val) {
        setState(() {
          loading = false;
        });
        if (val.containsKey("error")) {
          Fluttertoast.showToast(msg: val['error']);
        } else {
          Fluttertoast.showToast(msg: 'Profile Picture Updated!');
        }
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProfileProvider userData = Provider.of<UserProfileProvider>(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: widget.backGroundColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => widget.edit ? setImage(userData.userid) : null,
                    child: updateimage != null
                        ? ClipRRect(
                            borderRadius:
                                BorderRadius.circular(widget.borderRedius),
                            child: Image.file(
                              updateimage!,
                              height: (h < 700) ? h * 0.25 : h * 0.2,
                              width: w * 0.4,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Stack(
                            children: [
                              Container(
                                height: (h < 700) ? h * 0.25 : h * 0.2,
                                width: w * 0.4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      widget.borderRedius),
                                  color: Colors.grey,
                                  border: widget.borderwidth == 0
                                      ? null
                                      : Border.all(
                                          width: widget.borderwidth,
                                          color: widget.buttonColor),
                                  image: DecorationImage(
                                      image: NetworkImage(widget.image),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              loading
                                  ? SizedBox(
                                      height: (h < 700) ? h * 0.25 : h * 0.2,
                                      width: w * 0.4,
                                      child: Center(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              color: widget.buttonColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: (h < 700) ? h * 0.07 : h * 0.06,
                      ),
                      SizedBox(
                        width: w * 0.4,
                        child: Text(
                          widget.userName.capitalize!,
                          style: TextStyle(fontSize: w * 0.06),
                        ),
                      ),
                      widget.role == "parent"
                          ? SizedBox()
                          : SizedBox(
                              width: w * 0.25,
                              child: Text(
                                widget.isStudent
                                    ? 'Class ${widget.std}'
                                    : widget.std.capitalize!,
                                style: TextStyle(fontSize: w * 0.04),
                              ),
                            ),
                      SizedBox(
                        width: w * 0.25,
                        child: Text(
                          widget.role!.capitalize!,
                          style: TextStyle(fontSize: w * 0.04),
                        ),
                      ),
                      SizedBox(
                        height: h * 0.15,
                        width: w * 0.25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: widget.onCall,
                              child: Container(
                                height: h * 0.1,
                                width: w * 0.1,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: widget.buttonColor),
                                child: const Icon(
                                  Icons.call,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: widget.onMessage,
                              child: Container(
                                height: h * 0.1,
                                width: w * 0.1,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(color: widget.buttonColor)),
                                child: Icon(
                                  Icons.messenger,
                                  color: widget.buttonColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        widget.edit
            ? Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => UpdateUser().showUpdateProfileNameAlertDialog(
                    context,
                    color: widget.backGroundColor,
                    darkcolor: widget.buttonColor,
                    role: widget.role,
                    others: widget.std,
                    id: Provider.of<UserProfileProvider>(context, listen: false)
                        .userid,
                    oldusername: widget.userName,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 10, right: 20),
                    child: Icon(
                      Icons.edit_note,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}

//  * Created by: Sourav Bapari
//  * ----------------------------------------------------------------------------

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import 'package:schoolpenintern/Components/Abhil_widgets/about_card.dart';
import 'package:schoolpenintern/Components/Sourav_widgets/invite_parents.dart';
import 'package:schoolpenintern/Components/Sourav_widgets/student_parent_box.dart';
import 'package:schoolpenintern/Components/Sourav_widgets/user_idinfo_box.dart';
import 'package:schoolpenintern/Components/Vishwajeet_widgets/profile_card.dart';
import 'package:schoolpenintern/Providers/UserProfileProvider.dart';
import 'package:schoolpenintern/Providers/models/ParentProfilemoadels.dart';
import 'package:schoolpenintern/Providers/models/StudentProfilemodels.dart';
import 'package:schoolpenintern/Screens/Chat/ChatHome/NewChatHome.dart';

import 'package:schoolpenintern/Screens/Parents/Components/Abhil_widgets/status_card.dart';
import 'package:schoolpenintern/Screens/Parents/Components/Vishwajeet_widgets/search_widget.dart';
import 'package:schoolpenintern/Screens/Profile/UpdateProfile/NetWorkHelper/UpdateUser.dart';

import 'package:schoolpenintern/Screens/Profile/ViewProfile/Constents.dart';
import 'package:schoolpenintern/Screens/SearchUser/SearchUsers.dart';
import 'package:schoolpenintern/data/Network/config.dart';

import 'package:http/http.dart' as http;
import 'package:schoolpenintern/utiles/LoadImage.dart';

import '../../Components/Abhil_widgets/tile_widget.dart';
import '../../Components/Sourav_widgets/user_contact_info_box.dart';
import '../../Providers/models/TeacherProfilemodels.dart';

class ViewUserProfile extends StatefulWidget {
  final String userid;
  final String role;

  const ViewUserProfile({super.key, required this.userid, required this.role});

  @override
  State<ViewUserProfile> createState() => _ViewUserProfileState();
}

class _ViewUserProfileState extends State<ViewUserProfile> {
  final TextEditingController _controller = TextEditingController();
  late StudentProfileModel studentData;
  late ParentProfileDataModel parentData;
  late TeacherProfileModel teacherData;

  @override
  void initState() {
    getUser();
    print("====================> ${widget.role}");
    super.initState();
  }

  bool loading = true;

  final int tabindex = 0;

  getUser() async {
    setState(() {
      loading = true;
    });
    Uri url;
    if (widget.role == "student") {
      url = Uri.parse('${Config.hostUrl}/get_user/${widget.userid}');
    } else if (widget.role == "teacher") {
      url = Uri.parse('${Config.hostUrl}/get_teacher_profile/${widget.userid}');
    } else if (widget.role == "parent") {
      url = Uri.parse('${Config.hostUrl}/parent_data/${widget.userid}');
    } else {
      return false;
    }

    var req = http.MultipartRequest('GET', url);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      if (widget.role == 'student') {
        studentData = StudentProfileModel.fromJson(jsonDecode(resBody));
      } else if (widget.role == "teacher") {
        teacherData = TeacherProfileModel.fromJson(jsonDecode(resBody));
      } else if (widget.role == 'parent') {
        parentData = ParentProfileDataModel.fromJson(jsonDecode(resBody));
      } else {
        Fluttertoast.showToast(msg: "User Not Found");
      }
      setState(() {
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });

      Fluttertoast.showToast(msg: "User Not Not Load Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: viewProfileTabs[widget.role]['darkcolor'],
      onRefresh: () async => await getUser(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: loading
              ? SizedBox(
                  height: MediaQuery.of(context).size.height - 100,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: viewProfileTabs[widget.role]['darkcolor'],
                    ),
                  ),
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: Column(
                    children: [
                      // Viswajieet Eiget Start
                      Search(
                        controller: _controller,
                        backGroundLightColor: viewProfileTabs[widget.role]
                            ['bgcolor'],
                        searchIconColor: viewProfileTabs[widget.role]
                            ['darkcolor'],
                        onTap: () {},
                        onEditingComplete: () {
                          if (_controller.text.isNotEmpty) {
                            Get.to(
                              SearchUserProfile(
                                userid: _controller.text,
                                role: widget.role,
                              ),
                            );
                          }
                        },
                      ),
                      Builder(
                        builder: (context) {
                          if (widget.role == 'student') {
                            return ProfileCard(
                              edit: true,
                              role: "student",
                              backGroundColor: viewProfileTabs['student']
                                  ['bgcolor'],
                              userName: studentData.username.toString(),
                              image: loadImage(
                                  studentData.userImage.toString(), 'student'),
                              buttonColor: viewProfileTabs["student"]
                                  ['darkcolor'],
                              isStudent: (widget.role == "student"),
                              onCall: () {
                                Fluttertoast.showToast(msg: "Coming soon");
                              },
                              onMessage: () {
                                Get.to(
                                  NewChatHome(
                                    role: 'student',
                                    myid: Provider.of<UserProfileProvider>(
                                            context,
                                            listen: false)
                                        .profileData!
                                        .userId
                                        .toString(),
                                    image: Provider.of<UserProfileProvider>(
                                            context,
                                            listen: false)
                                        .profileData!
                                        .userImage
                                        .toString(),
                                    myuserid: Provider.of<UserProfileProvider>(
                                            context,
                                            listen: false)
                                        .profileData!
                                        .userId
                                        .toString(),
                                  ),
                                );
                              },
                              std: studentData.userClass.toString(),
                            );
                          } else if (widget.role == "parent") {
                            return ProfileCard(
                              role: "parent",
                              edit: true,
                              backGroundColor: viewProfileTabs["parent"]
                                  ['bgcolor'],
                              borderRedius: 100,
                              borderwidth: 2,
                              userName: parentData.parentName.toString(),
                              image: loadImage(
                                  parentData.parentImage.toString(), 'parent'),
                              buttonColor: viewProfileTabs['parent']
                                  ['darkcolor'],
                              isStudent: (widget.role == "student"),
                              onCall: () {
                                Fluttertoast.showToast(msg: "Coming soon");
                              },
                              onMessage: () {
                                Get.to(NewChatHome(
                                    role: 'parent',
                                    myid: Provider.of<UserProfileProvider>(
                                      context,
                                      listen: false,
                                    )
                                        .parentprofile!
                                        .parentUseridname
                                        .toString(),
                                    image: Provider.of<UserProfileProvider>(
                                      context,
                                      listen: false,
                                    ).parentprofile!.parentImage.toString(),
                                    myuserid: Provider.of<UserProfileProvider>(
                                            context,
                                            listen: false)
                                        .parentprofile!
                                        .parentUseridname
                                        .toString()));
                              },
                              std: widget.role,
                            );
                          } else if (widget.role == 'teacher') {
                            return ProfileCard(
                              role: "teacher",
                              edit: true,
                              backGroundColor: viewProfileTabs["teacher"]
                                  ['bgcolor'],
                              userName: teacherData.username.toString(),
                              image: loadImage(
                                  teacherData.userImage.toString(), 'teacher'),
                              buttonColor: viewProfileTabs["teacher"]
                                  ['darkcolor'],
                              isStudent: (widget.role == "student"),
                              onCall: () {
                                Fluttertoast.showToast(msg: "Coming soon");
                              },
                              onMessage: () {
                                Get.to(NewChatHome(
                                    role: 'teacher',
                                    myid: Provider.of<UserProfileProvider>(
                                            context,
                                            listen: false)
                                        .teacherdata!
                                        .profile!
                                        .useridnamePassword!
                                        .useridName
                                        .toString(),
                                    image: Provider.of<UserProfileProvider>(
                                            context,
                                            listen: false)
                                        .teacherdata!
                                        .userImage
                                        .toString(),
                                    myuserid: Provider.of<UserProfileProvider>(
                                            context,
                                            listen: false)
                                        .teacherdata!
                                        .profile!
                                        .useridnamePassword!
                                        .useridName
                                        .toString()));
                              },
                              std: teacherData.languages.toString(),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...List.generate(
                              viewProfileTabs[widget.role]['tabs'].length,
                              (index) => TileWidget(
                                  active: index == 0,
                                  fill: true,
                                  activeColor: viewProfileTabs[widget.role]
                                      ['darkcolor'],
                                  activeTextColor: viewProfileTabs[widget.role]
                                      ['bgcolor'],
                                  text: viewProfileTabs[widget.role]['tabs']
                                      [index]['tabtitle']),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Builder(
                        builder: (context) {
                          if (widget.role == "student") {
                            return StatusCard(
                              role: "student",
                              headline: studentData.statusTitle.toString(),
                              description:
                                  studentData.statusDescription.toString(),
                              bgcolor: viewProfileTabs[widget.role]['bgcolor'],
                              isedit: true,
                            );
                          } else if (widget.role == 'teacher') {
                            return StatusCard(
                              role: 'teacher',
                              headline: teacherData
                                  .profile!.status!.userDesignation
                                  .toString(),
                              description: teacherData
                                  .profile!.status!.userDescription
                                  .toString(),
                              bgcolor: viewProfileTabs[widget.role]['bgcolor'],
                              isedit: true,
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                      const SizedBox(height: 20),

                      // About Section
                      Builder(
                        builder: (context) {
                          if (widget.role == "student") {
                            return Column(
                              children: [
                                AboutCard(
                                  role: "student",
                                  bgcolor: viewProfileTabs[widget.role]
                                      ['bgcolor'],
                                  description: studentData.personalInfo!.about
                                      .toString(),
                                  isedit: true,
                                ),
                                const SizedBox(height: 20),
                                UserIdInfo(
                                  onEditClick: () {
                                    UpdateUser().showUpdateNameAlertDialog(
                                        context,
                                        role: "student",
                                        oldusername: studentData.userId,
                                        color: viewProfileTabs["student"]
                                            ['bgcolor'],
                                        id: studentData.userId,
                                        darkcolor: viewProfileTabs["student"]
                                            ['darkcolor']);
                                  },
                                  userIdText: studentData.userId.toString(),
                                  backgroundColor: viewProfileTabs["student"]
                                      ['bgcolor'],
                                )
                              ],
                            );
                          } else if (widget.role == "parent") {
                            return Column(
                              children: [
                                AboutCard(
                                  role: 'parent',
                                  isedit: true,
                                  bgcolor: viewProfileTabs["parent"]['bgcolor'],
                                  description:
                                      parentData.parentAbout.toString(),
                                ),
                                const SizedBox(height: 20),
                                UserIdInfo(
                                  onEditClick: () {
                                    UpdateUser().showUpdateNameAlertDialog(
                                      context,
                                      color: viewProfileTabs["parent"]
                                          ['bgcolor'],
                                      darkcolor: viewProfileTabs["parent"]
                                          ['darkcolor'],
                                      id: parentData.parentUseridname,
                                      oldusername: parentData.parentUseridname,
                                      role: "parent",
                                    );
                                  },
                                  userIdText:
                                      parentData.parentUseridname.toString(),
                                  backgroundColor: viewProfileTabs["parent"]
                                      ['bgcolor'],
                                ),
                                const SizedBox(height: 20),
                                UserConatctBox(
                                  isedit: true,
                                  onEditClick: () {
                                    UpdateUser().showAddressAlertDialog(context,
                                        role: "parent",
                                        emailid: parentData.parentEmail,
                                        phone: parentData.parentPhone,
                                        city: parentData.parentCity,
                                        pincode: parentData.parentPostalCode,
                                        state: parentData.parentState,
                                        street: parentData.parentStreetAddress,
                                        id: parentData.parentUseridname,
                                        color: viewProfileTabs["parent"]
                                            ['bgcolor'],
                                        darkcolor: viewProfileTabs["parent"]
                                            ['darkcolor']);
                                  },
                                  role: 'parent',
                                  backgroundColor: viewProfileTabs["parent"]
                                      ['bgcolor'],
                                  emailText: parentData.parentEmail.toString(),
                                  phoneText: "+91 ${parentData.parentPhone}",
                                  locationAddress:
                                      "${parentData.parentStreetAddress},${parentData.parentCity},${parentData.parentState},${parentData.parentPostalCode}"
                                          .toString(),
                                ),
                                const SizedBox(height: 20),
                                UserParentsBox(
                                    title: "Kids Details",
                                    bgcolor: viewProfileTabs["parent"]
                                        ['bgcolor'],
                                    darkcolor: viewProfileTabs["parent"]
                                        ['darkcolor'],
                                    data: []),
                                const SizedBox(height: 20),
                              ],
                            );
                          } else if (widget.role == "teacher") {
                            return Column(
                              children: [
                                AboutCard(
                                  role: "teacher",
                                  isedit: true,
                                  bgcolor: viewProfileTabs["teacher"]
                                      ['bgcolor'],
                                  description:
                                      teacherData.profile!.about.toString(),
                                ),
                              ],
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Builder(
                          builder: (context) {
                            if (widget.role == 'student') {
                              return Column(
                                children: [
                                  UserConatctBox(
                                    role: 'student',
                                    isedit: true,
                                    onEditClick: () {
                                      UpdateUser().showAddressAlertDialog(
                                          context,
                                          role: "student",
                                          emailid: studentData
                                              .personalInfo!.contact!.email,
                                          phone: studentData
                                              .personalInfo!.contact!.phone,
                                          city: studentData.personalInfo!
                                              .contact!.address!.city,
                                          pincode: studentData.personalInfo!
                                              .contact!.address!.pincode,
                                          state: studentData.personalInfo!
                                              .contact!.address!.state,
                                          street: studentData.personalInfo!
                                              .contact!.address!.street,
                                          id: studentData.userId,
                                          color: viewProfileTabs["student"]
                                              ['bgcolor'],
                                          darkcolor: viewProfileTabs["student"]
                                              ['darkcolor']);
                                    },
                                    backgroundColor: viewProfileTabs["student"]
                                        ['bgcolor'],
                                    emailText: studentData
                                        .personalInfo!.contact!.email
                                        .toString(),
                                    phoneText:
                                        "+91 ${studentData.personalInfo!.contact!.phone}",
                                    locationAddress:
                                        "${studentData.personalInfo!.contact!.address!.street},${studentData.personalInfo!.contact!.address!.city},${studentData.personalInfo!.contact!.address!.state},${studentData.personalInfo!.contact!.address!.pincode}"
                                            .toString(),
                                  ),
                                  const SizedBox(height: 20),
                                  UserParentsBox(
                                      bgcolor: viewProfileTabs["student"]
                                          ['bgcolor'],
                                      darkcolor: viewProfileTabs["student"]
                                          ['darkcolor'],
                                      data: []),
                                  const SizedBox(height: 20),
                                  inviteParents(),
                                ],
                              );
                            } else if (widget.role == 'teacher') {
                              return Column(
                                children: [
                                  UserIdInfo(
                                    userIdText: teacherData
                                        .profile!.useridnamePassword!.useridName
                                        .toString(),
                                    onEditClick: () {
                                      UpdateUser().showUpdateNameAlertDialog(
                                          context,
                                          role: "teacher",
                                          oldusername: teacherData.profile!
                                              .useridnamePassword!.useridName,
                                          color: viewProfileTabs["teacher"]
                                              ['bgcolor'],
                                          id: teacherData.profile!
                                              .useridnamePassword!.useridName,
                                          darkcolor: viewProfileTabs["teacher"]
                                              ['darkcolor']);
                                    },
                                    backgroundColor: viewProfileTabs["teacher"]
                                        ['bgcolor'],
                                  ),
                                  const SizedBox(height: 20),
                                  UserConatctBox(
                                    onEditClick: () {
                                      UpdateUser().showAddressAlertDialog(
                                          context,
                                          role: "teacher",
                                          emailid: teacherData
                                              .profile!.contact!.email,
                                          phone: teacherData
                                              .profile!.contact!.phone,
                                          city: teacherData
                                              .profile!.contact!.address!.city,
                                          pincode: teacherData.profile!.contact!
                                              .address!.postalCode,
                                          state: teacherData
                                              .profile!.contact!.address!.state,
                                          street: teacherData.profile!.contact!
                                              .address!.street,
                                          id: teacherData.profile!
                                              .useridnamePassword!.useridName,
                                          color: viewProfileTabs["teacher"]
                                              ['bgcolor'],
                                          darkcolor: viewProfileTabs["teacher"]
                                              ['darkcolor']);
                                    },
                                    role: 'teacher',
                                    backgroundColor: viewProfileTabs["teacher"]
                                        ['bgcolor'],
                                    emailText: teacherData
                                        .profile!.contact!.email
                                        .toString(),
                                    phoneText:
                                        "+91 ${teacherData.profile!.contact!.phone}",
                                    isedit: true,
                                    locationAddress:
                                        "${teacherData.profile!.contact!.address!.street}, ${teacherData.profile!.contact!.address!.city},${teacherData.profile!.contact!.address!.state},${teacherData.profile!.contact!.address!.postalCode}"
                                            .toString(),
                                  ),
                                ],
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

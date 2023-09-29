//  * Created by: Sourav Bapari
//  * ----------------------------------------------------------------------------

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:schoolpenintern/Components/Abhil_widgets/about_card.dart';
import 'package:schoolpenintern/Components/Vishwajeet_widgets/profile_card.dart';
import 'package:schoolpenintern/Providers/UserProfileProvider.dart';
import 'package:schoolpenintern/Screens/Chat/ChatMessage/ChatMessageScreen.dart';
import 'package:schoolpenintern/Screens/Chat/ChatMessage/bloc/chat_message_bloc.dart';
import 'package:schoolpenintern/Screens/Parents/Components/Abhil_widgets/status_card.dart';
import 'package:schoolpenintern/Screens/Parents/Components/Vishwajeet_widgets/search_widget.dart';
import 'package:schoolpenintern/Screens/Profile/ViewProfile/Constents.dart';
import 'package:schoolpenintern/Screens/SearchUser/searchProfileMoadel.dart';
import 'package:schoolpenintern/data/Network/config.dart';
import 'package:http/http.dart' as http;
import 'package:schoolpenintern/utiles/LoadImage.dart';

class SearchUserProfile extends StatefulWidget {
  String? userid;
  String? role;

  SearchUserProfile({super.key, this.userid, this.role = 'student'});

  @override
  State<SearchUserProfile> createState() => SearchUserProfileState();
}

class SearchUserProfileState extends State<SearchUserProfile> {
  TextEditingController _controller = TextEditingController();
  SearchProfileModel? searchdata;
  bool loading = false;

  @override
  void initState() {
    if (widget.userid != null) {
      getUser(widget.userid);
    }
    widget.role = Provider.of<UserProfileProvider>(context, listen: false).roal;
    print("====================> ${widget.role}");
    super.initState();
  }

  final int tabindex = 0;

  getUser(id) async {
    var url = Uri.parse('${Config.hostUrl}/get_profile/$id');

    var req = http.Request('GET', url);
    setState(() {
      loading = true;
    });
    var res = await req.send();
    Map<String, dynamic> resBody = jsonDecode(await res.stream.bytesToString());
    setState(() {
      loading = false;
    });
    if (res.statusCode >= 200 && res.statusCode < 300) {
      if (!resBody.containsKey('message')) {
        setState(() {
          searchdata = SearchProfileModel.fromJson(resBody);
        });
      } else {
        Fluttertoast.showToast(msg: "User Not Found");
      }
    } else {
      Fluttertoast.showToast(msg: "User Not Found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Search(
            controller: _controller,
            backGroundLightColor: viewProfileTabs[
                Provider.of<UserProfileProvider>(context, listen: false)
                    .roal]['bgcolor'],
            searchIconColor: viewProfileTabs[
                Provider.of<UserProfileProvider>(context, listen: false)
                    .roal]['darkcolor'],
            onTap: () {},
            onEditingComplete: () {
              if (_controller.text.isNotEmpty) {
                getUser(_controller.text);
              }
            },
          ),
          SingleChildScrollView(
            child: loading
                ? const Center(
                    child: SizedBox(
                        height: 120,
                        child: Center(
                            child: CircularProgressIndicator(
                          color: Colors.black,
                        ))),
                  )
                : searchdata == null
                    ? const SizedBox(
                        height: 200,
                        child: Center(
                          child: Text("Search Profile Here!!"),
                        ),
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ProfileCard(
                              backGroundColor: viewProfileTabs[widget.role]
                                      ['bgcolor'] ??
                                  Colors.blue,
                              userName: searchdata!.username.toString(),
                              std: "",
                              borderRedius:
                                  searchdata!.role == 'parent' ? 100 : 20,
                              borderwidth: searchdata!.role == 'parent' ? 2 : 0,
                              image: loadImage(
                                  searchdata!.userImage, searchdata!.role),
                              buttonColor: viewProfileTabs[widget.role]
                                  ['darkcolor'],
                              isStudent: false,
                              role: searchdata!.role,
                              onMessage: () {
                                Get.to(
                                  BlocProvider(
                                    create: (context) => ChatMessageBloc(),
                                    child: ChatMessageScreen(
                                      myid: Provider.of<UserProfileProvider>(
                                              context,
                                              listen: false)
                                          .userid,
                                      chatuserid: searchdata!.userId,
                                      name: searchdata!.userId,
                                      image: loadImage(searchdata!.userImage,
                                          searchdata!.role),
                                      chatusernameid: searchdata!.userId,
                                      roal: searchdata!.role,
                                    ),
                                  ),
                                );
                              },
                              onCall: () {},
                              edit: false,
                            ),
                          ),
                          searchdata!.role == "parent"
                              ? const SizedBox()
                              : Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: StatusCard(
                                    role: searchdata!.role.toString(),
                                    headline:
                                        searchdata!.statusTitle.toString(),
                                    description: searchdata!.statusDescription
                                        .toString(),
                                    bgcolor: viewProfileTabs[widget.role]
                                        ['bgcolor'],
                                  ),
                                ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: AboutCard(
                              role: "",
                              description: searchdata!.about.toString(),
                              bgcolor: viewProfileTabs[widget.role]['bgcolor'],
                              isedit: false,
                            ),
                          )
                        ],
                      ),
          ),
        ],
      ),
    ));
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:schoolpenintern/Providers/UserProfileProvider.dart';
import 'package:schoolpenintern/Providers/models/ParentProfilemoadels.dart';
import 'package:schoolpenintern/Providers/models/StudentProfilemodels.dart';
import 'package:schoolpenintern/Providers/models/TeacherProfilemodels.dart';
import 'package:schoolpenintern/Screens/Chat/ChatMessage/ChatMessageScreen.dart';
import 'package:schoolpenintern/Screens/Chat/ChatMessage/bloc/chat_message_bloc.dart';
import 'package:schoolpenintern/Screens/Chat/models/userSearchmodel.dart';
import 'package:http/http.dart' as http;
import 'package:schoolpenintern/data/Network/config.dart';
import 'package:schoolpenintern/data/model/StudentProfileModel.dart';
import '../../../Theme/Colors/appcolors.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../../utiles/LoadImage.dart';
import '../../../utiles/TimeToDays.dart';

// ignore: must_be_immutable
class ChatUserListBox extends StatefulWidget {
  dynamic chatuserId;

  ChatUserListBox({
    super.key,
    this.chatuserId,
  });

  @override
  State<ChatUserListBox> createState() => _ChatUserListBoxState();
}

class _ChatUserListBoxState extends State<ChatUserListBox> {
  late String image;
  late String userid;
  late String name;
  late String roal;

  List chatsData = [];
  String lastmessage = "";
  String? date = "";

  getLastMessage(id) async {
    UserProfileProvider userdata =
        Provider.of<UserProfileProvider>(context, listen: false);

    var url = Uri.parse(
        '${Config.chatserverUrl}/last_message/${userdata.userid}/${id}');
    print(url);
    var req = http.MultipartRequest('GET', url);
    var res = await req.send();
    var resBody = await res.stream.bytesToString();
    print('============================================');
    if (res.statusCode >= 200 && res.statusCode < 300) {
      Map resBodymap = jsonDecode(resBody);
      setState(() {
        lastmessage = resBodymap['message'];

        date = changeTimeToDayOrHour(resBodymap['created_at'].toString());
      });
    } else {
      print(res.reasonPhrase);
    }
  }

  @override
  void initState() {
    UserProfileProvider userProvider =
        Provider.of<UserProfileProvider>(context, listen: false);
    // getSearchData();
    print("--------------------");
    if (widget.chatuserId!['role'] == 'student') {
      StudentProfileModel userData =
          StudentProfileModel.fromJson(widget.chatuserId);
      image = userData.userImage!;
      userid = userData.userId!;
      name = userData.username!;
      roal = "student";
      getLastMessage(userid);
    } else if (widget.chatuserId!['role'] == 'teacher') {
      TeacherProfileModel userData =
          TeacherProfileModel.fromJson(widget.chatuserId);
      print("==========TEACHER==========");
      print(widget.chatuserId);
      image = userData.userImage!;
      userid = userData.profile!.useridnamePassword!.useridName!;
      name = userData.profile!.useridnamePassword!.useridName!;
      roal = "teacher";
      getLastMessage(userid);
    } else if (widget.chatuserId!['role'] == 'parent') {
      ParentProfileDataModel userData =
          ParentProfileDataModel.fromJson(widget.chatuserId);
      image = userData.parentImage!;
      userid = userData.parentUseridname!;
      name = userData.parentName!;
      roal = "parent";
      getLastMessage(userid);
    }
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      splashColor: Colors.black12,
      onTap: () {
        var userData = Provider.of<UserProfileProvider>(context, listen: false);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              print("/////////////////////////////");
              print(widget.chatuserId);
              return BlocProvider(
                create: (context) => ChatMessageBloc(),
                child: ChatMessageScreen(
                  myid: userData.userid,
                  chatuserid: userid,
                  name: name,
                  roal: roal,
                  image: image,
                  chatusernameid: userid,
                ),
              );
            },
          ),
        );
      },
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Image.network(
            loadImage(image, roal),
            height: 50,
            width: 50,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            userid ?? "",
            style: TextStyle(
                color: AppColors.graymdm,
                fontWeight: FontWeight.bold,
                fontSize: 14),
          ),
          Text(" |  ${roal}",
              style: TextStyle(color: AppColors.graymdm, fontSize: 14)),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Text(lastmessage),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            date.toString(),
            style: TextStyle(fontSize: 12, color: AppColors.greenlignt),
          ),
          const SizedBox(height: 5),
          // Container(
          //   width: 18,
          //   height: 18,
          //   decoration: BoxDecoration(
          //       color: AppColors.greenlignt,
          //       borderRadius: BorderRadius.circular(50)),
          //   child: const Center(
          //     child: Text(
          //       '1',
          //       style: TextStyle(fontSize: 10, color: Colors.white),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

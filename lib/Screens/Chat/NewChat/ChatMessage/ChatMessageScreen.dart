import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:schoolpenintern/Screens/Chat/ChatMessage/bloc/chat_message_bloc.dart';
import 'package:schoolpenintern/Screens/Chat/Components/ChatBuble.dart';
import 'package:schoolpenintern/Screens/Chat/Components/ChatInput.dart';
import 'package:schoolpenintern/Screens/Profile/ViewUserProfile.dart';
import 'package:schoolpenintern/Theme/Colors/appcolors.dart';
import 'package:schoolpenintern/data/Network/config.dart';
import 'package:schoolpenintern/utiles/TimeToDays.dart';
import '../../Components/ChatAppbar.dart';
import '../Components/ChatAppbar.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:http/http.dart' as http;

class ChatMessageScreen extends StatefulWidget {
  final dynamic myid;
  final dynamic chatuserid;
  final dynamic chatusernameid;
  final dynamic name;
  final dynamic image;
  final dynamic roal;

  const ChatMessageScreen({
    super.key,
    required this.myid,
    required this.chatuserid,
    required this.chatusernameid,
    required this.name,
    required this.image,
    required this.roal,
  });

  @override
  State<ChatMessageScreen> createState() => _ChatMessageScreenState();
}

class _ChatMessageScreenState extends State<ChatMessageScreen> {
  late io.Socket socket;
  late String username;
  late String resiver;
  List chatsData = [];

  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // SErup LOst Chat Server

// Pass User Info On Sever
    Bloc chat = BlocProvider.of<ChatMessageBloc>(context);
    username = widget.myid.toString();
    resiver = widget.chatusernameid.toString();
    print("====================>${widget.chatusernameid} ${widget.myid}");
    String serverUrl = '${Config.chatserverUrl}';
    socket = io.io(serverUrl, <String, dynamic>{
      'transports': ['websocket'],
    });

    socket.onConnect((data) {
      Map user = {"sender": username, "recipient": resiver};
      socket.emit('initConnect', user);
    });

    socket.connect();

    socket.on('getoldmessage', (data) {
      chatsData = data['messages'];

      chat.emit(ChatMessageShow(message: chatsData));
    });

    socket.on("new_private_message", (data) {
      chatsData.add({
        "sender": data['sender'],
        "recipient": data['resiver'],
        "message": data['message'],
        "created_at": data['created_at']
      });

      BlocProvider.of<ChatMessageBloc>(context)
          .emit(ChatMessageShow(message: chatsData));
      _textEditingController.clear();
      _scrollToBottom();
    });

    socket.on('nouserfound', (data) {
      Fluttertoast.showToast(msg: "No User Found!");
      Navigator.of(context).pop();
    });

    super.initState();
  }

  onSendMessage() {
    socket.emit("private_message", {
      "sender": username,
      "recipient": resiver,
      "message": _textEditingController.text
    });

    chatsData.add({
      "sender": username,
      "recipient": resiver,
      "message": _textEditingController.text,
      "created_at": DateTime.now().toString()
    });

    BlocProvider.of<ChatMessageBloc>(context)
        .emit(ChatMessageShow(message: chatsData));
    _textEditingController.clear();
    _scrollToBottom();
  }

  _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Future blockUser() async {
    try {
      http.Response data = await http.get(
          Uri.parse("${Config.chatserverUrl}/block_user/$username/$resiver"));
      var resdata = jsonDecode(data.body);
      print(resdata);
      Fluttertoast.showToast(msg: "User Blocked");
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: "Request Not Send : Error");
    }
  }

  Future unblockUser() async {
    try {
      http.Response data = await http.post(
          Uri.parse("${Config.chatserverUrl}/unblock_user/$username/$resiver"));
      var resdata = jsonDecode(data.body);
      Fluttertoast.showToast(msg: "User UnBlock");
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: "Request Not Send : Error");
    }
  }

  onselect(e) async {
    if (e == "block") {
      await blockUser();
    } else if (e == "unblock") {
      await unblockUser();
    } else if (e == "profile") {
      Get.to(ViewUserProfile(userid: widget.chatusernameid, role: widget.roal));
    } else {
      Fluttertoast.showToast(msg: "This Option Is Coming Soon");
    }
    print(e);
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: chatAppbar(
        context,
        name: widget.chatusernameid,
        typename: widget.roal,
        title: widget.chatusernameid,
        image: widget.image,
        id: widget.chatuserid,
        onMenuselect: onselect,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatMessageBloc, ChatMessageState>(
              builder: (context, state) {
                if (state is ChatMessageInitial) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.purple,
                    ),
                  );
                }
                if (state is ChatMessageShow) {
                  List revmesg = state.message.reversed.toList();
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: revmesg.length,
                    reverse: true,
                    itemBuilder: (_, index) {
                      return ChatBubble(
                          resiver: revmesg[index]['recipient'] != resiver,
                          message: revmesg[index]['message'],
                          sendtext: changeTimeToDayOrHour(
                              revmesg[index]['created_at']));
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.purple,
                    ),
                  );
                }
              },
            ),
          ),
          ChatInput(
            controller: _textEditingController,
            sendMessage: onSendMessage,
          ),
        ],
      ),
    );
  }
}

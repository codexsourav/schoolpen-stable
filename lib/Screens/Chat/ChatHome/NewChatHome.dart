import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:schoolpenintern/Screens/Chat/ChatHome/tabs/ParentTab.dart';
import 'package:schoolpenintern/Screens/Chat/ChatHome/tabs/TeacherTab.dart';
import 'package:schoolpenintern/Screens/Chat/Components/ChatHomeAppbar.dart';
import '../../../Providers/ChatUserProvider.dart';
import '../../../Theme/Colors/appcolors.dart';
import '../Components/Searchusers.dart';
import 'tabs/StudentsTab.dart';

class NewChatHome extends StatefulWidget {
  final String role;
  final String myid;
  final String image;
  final String myuserid;

  const NewChatHome(
      {super.key,
      required this.role,
      required this.myid,
      required this.image,
      required this.myuserid});

  @override
  State<NewChatHome> createState() => _NewChatHomeState();
}

class _NewChatHomeState extends State<NewChatHome> {
  @override
  void initState() {
    Provider.of<ChatUserProvider>(context, listen: false)
        .setChatUsers(widget.myuserid);
    super.initState();
  }

// For Tab Index
  int tabindex = 0;

  @override
  Widget build(BuildContext context) {
    print("----------------------------" + widget.role);
    return Scaffold(
      appBar: chatHomeAppbar(context,
          image: widget.image, role: widget.role, uid: widget.myuserid),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(SearchUsers(
                      myid: widget.myuserid,
                      role: widget.role,
                    ));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 78,
                    height: 50,
                    padding: const EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                          width: 1.5,
                          color: widget.role == "student"
                              ? AppColors.purple
                              : widget.role == "teacher"
                                  ? AppColors.pinkDarkcolor
                                  : const Color.fromARGB(255, 117, 185, 119)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search,
                            size: 25,
                            color: widget.role == "student"
                                ? AppColors.purple
                                : widget.role == "teacher"
                                    ? AppColors.pinkDarkcolor
                                    : const Color.fromARGB(255, 117, 185, 119)),
                        const Padding(
                          padding: EdgeInsets.only(left: 14),
                          child: Text(
                            "Search Classmeat And Teacher...",
                            style: TextStyle(color: Colors.black26),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert_rounded),
                )
              ],
            ),
            const SizedBox(height: 20),
            FlutterToggleTab(
              width: 90,
              isScroll: false,
              borderRadius: 50,
              selectedBackgroundColors: [
                widget.role == "student"
                    ? AppColors.purple
                    : widget.role == "teacher"
                        ? AppColors.pinkDarkcolor
                        : const Color.fromARGB(255, 117, 185, 119)
              ],
              isShadowEnable: false,
              selectedTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
              unSelectedTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
              labels: const ["All", "Students", "Teacher", "Parent"],
              selectedIndex: tabindex,
              unSelectedBackgroundColors: [
                widget.role == "student"
                    ? const Color.fromARGB(255, 216, 185, 238)
                    : widget.role == "teacher"
                        ? const Color.fromARGB(255, 207, 120, 136)
                        : Color.fromARGB(255, 161, 206, 162)
              ],
              selectedLabelIndex: (index) {
                setState(() {
                  tabindex = index;
                });
                switch (index) {
                  case 0:
                    Provider.of<ChatUserProvider>(context, listen: false)
                        .resetChatUsers();
                    break;
                  case 1:
                    Provider.of<ChatUserProvider>(context, listen: false)
                        .sortsetChatUsers('student');
                    break;
                  case 2:
                    Provider.of<ChatUserProvider>(context, listen: false)
                        .sortsetChatUsers('teacher');
                    break;
                  case 3:
                    Provider.of<ChatUserProvider>(context, listen: false)
                        .sortsetChatUsers('parent');
                    break;
                  default:
                    Provider.of<ChatUserProvider>(context, listen: false)
                        .resetChatUsers();
                    break;
                }
              },
            ),
            const SizedBox(height: 20),
            Consumer<ChatUserProvider>(
              builder: (context, value, child) {
                if (value.loading) {
                  return SizedBox(
                    height: 120,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (value.listchatUsers!.isEmpty) {
                  return SizedBox(
                    height: 100,
                    child: Center(
                      child: Text("Lets Connect!"),
                    ),
                  );
                } else {
                  return Column(
                    children:
                        List.generate(value.listchatUsers!.length, (index) {
                      return Builder(builder: (context) {
                        if (value.listchatUsers![index]['role'] == 'student') {
                          return LoadStudentTab(
                            chatuserId: value.listchatUsers![index],
                          );
                          // Text(value.listchatUsers![index]['user_id']);
                        } else if (value.listchatUsers![index]['role'] ==
                            'teacher') {
                          return TeacherTab(
                            chatuserId: value.listchatUsers![index],
                          );
                        } else {
                          return ParentTab(
                            chatuserId: value.listchatUsers![index],
                          );
                        }
                      });
                    }),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

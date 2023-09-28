import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:schoolpenintern/Providers/UserProfileProvider.dart';
import 'package:schoolpenintern/Screens/Chat/ChatHome/NewChatHome.dart';
import 'package:schoolpenintern/Screens/Profile/ViewUserProfile.dart';
import 'package:schoolpenintern/Screens/Teacher/Theme/Colors/appcolors.dart';
import 'package:schoolpenintern/utiles/LoadImage.dart';
import '../SearchUser/SearchUsers.dart';
import 'Components/parent_custom_card.dart';
import 'Components/parent_section_buttons.dart';
import 'Components/parents_your_kids_card.dart';
import 'custom/drawer.dart';

class ParentHomePage extends StatefulWidget {
  const ParentHomePage({super.key});

  @override
  State<ParentHomePage> createState() => _ParentHomePageState();
}

class _ParentHomePageState extends State<ParentHomePage> {
  final CarouselController _controller = CarouselController();
  final AdvancedDrawerController controller = AdvancedDrawerController();
  int itemCount = 4;
  int currentPageToday = 0;
  int currentPageTommorow = 0;

  final List<Map<String, dynamic>> data = [
    // {'imagePath': 'assets/images/tina.png', 'name': 'Tina'},
    // {'imagePath': 'assets/images/rohit.png', 'name': 'Rohit'},
  ];

  final List<Map<String, String>> lessonData = [
    {
      'title': 'Period 1',
      'subtitle': 'Chapter 3: Geometry and its uses',
      'teacherName': 'Sara Blasko',
      'imageAsset': 'assets/images/mask-group-5YV.png',
      'iconAsset': 'assets/images/profile-Ktd.png',
    },
    {
      'title': 'Period 2',
      'subtitle': 'Chapter 3: Geometry and its uses',
      'teacherName': 'Sara Blasko',
      'imageAsset': 'assets/images/mask-group-5YV.png',
      'iconAsset': 'assets/images/profile-Ktd.png',
    },
  ];
  List<Map<String, String>> cardData = [
    {
      'imagePath': 'assets/images/mask-group-Byb.png',
      'title': 'Trigonometry',
      'schoolName': 'Stonehill international school',
      'progress': '73%',
    },
    {
      'imagePath': 'assets/images/mask-group-Byb.png',
      'title': 'Trigonometry',
      'schoolName': 'Stonehill international school',
      'progress': '73%',
    },
    // Add more card data here
  ];
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserProfileProvider parentProvider =
        Provider.of<UserProfileProvider>(context);
    return SafeArea(
      child: AdvancedDrawer(
        controller: controller,
        openScale: 0.7,
        openRatio: 0.65,
        disabledGestures: false,
        backdrop: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child:
                Image.asset("assets/images/backgroud.png", fit: BoxFit.fill)),
        childDecoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        drawer: const DrawerScreen(
          location: '',
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: 0,
            iconSize: 25,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: const Color.fromARGB(255, 81, 196, 133),
            onTap: (value) {},
            unselectedItemColor: AppColors.black.withOpacity(0.5),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.explore),
                label: "Explore",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_book),
                label: "Graph",
              ),
            ],
          ),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    controller.showDrawer();
                  },
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                ),
                toolbarHeight: 70,
                actions: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.white,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(SearchUserProfile());
                      },
                      child: const Icon(
                        Icons.search,
                        size: 25,
                        color: Color(0xff83D39D),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(NewChatHome(
                        myuserid: parentProvider.parentprofile!.parentUseridname
                            .toString(),
                        myid: parentProvider.parentprofile!.parentUseridname
                            .toString(),
                        role: 'parent',
                        image: parentProvider.parentprofile!.parentImage
                            .toString(),
                      ));
                      // Get.to(()=>NewChatHome(role: "parent",myid:"rish03",));
                    },
                    child: const CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.messenger,
                        color: Color(0xff83D39D),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.notifications,
                      size: 25,
                      color: Color(0xff83D39D),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(ViewUserProfile(
                          userid: Provider.of<UserProfileProvider>(context,
                                  listen: false)
                              .parentprofile!
                              .parentUseridname
                              .toString(),
                          role: 'parent'));
                      //     Get.to(()=>ViewParentProfile());
                    },
                    child: Center(
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            loadImage(
                              Provider.of<UserProfileProvider>(context,
                                      listen: false)
                                  .parentprofile!
                                  .parentImage
                                  .toString(),
                              "parent",
                            ),
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
                expandedHeight: 120,
                // stretch: true,
                // stretchTriggerOffset: 100,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    alignment: Alignment.topCenter,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/Vector.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Your Kids",
                          style: GoogleFonts.lato(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      // Icon(
                      //   Icons.calendar_today,
                      //   size: 25,
                      //   color: AppColors.parentPrimary,
                      // )
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: SizedBox(
                    height: 150, // Set the desired height
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.length + 1,
                      itemBuilder: (context, index) {
                        if (index == data.length) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(left: 30, bottom: 30),
                            child: Container(
                              height: 50,
                              width: 50,
                              margin: const EdgeInsets.only(bottom: 5),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFEFFAF3),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.add,
                                  color: Color(0xFF83D39D),
                                ),
                              ),
                            ),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ImageWithName(
                            imagePath: data[index]['imagePath'],
                            name: data[index]['name'],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              // SliverToBoxAdapter(
              //   child: Container(
              //     margin: const EdgeInsets.fromLTRB(10, 0, 10, 4),
              //     padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
              //     width: 328,
              //     height: 64,
              //     decoration: const BoxDecoration(
              //       image: DecorationImage(
              //         fit: BoxFit.cover,
              //         image: AssetImage('assets/images/union.png'),
              //       ),
              //     ),
              //     child: Center(
              //       child: SizedBox(
              //         child: Container(
              //           constraints: const BoxConstraints(
              //             maxWidth: 278,
              //           ),
              //           child: RichText(
              //             text:  TextSpan(
              //               style:GoogleFonts.lato(
              //    fontSize: 16,fontWeight: FontWeight.bold
              //       ),
              //               children: [
              //                 TextSpan(
              //                   text: 'Tina',
              //                   style: GoogleFonts.lato(
              //                     color: Colors.black,
              //    fontSize: 16,fontWeight: FontWeight.bold
              //       )
              //                 ),
              //                 TextSpan(
              //                   text: ' is attending her ',
              //                   style: GoogleFonts.lato(
              //                        color: Colors.black,
              //    fontSize: 16,fontWeight: FontWeight.bold
              //       )
              //                 ),
              //                 TextSpan(
              //                   text: 'Biology',
              //                   style:GoogleFonts.lato(
              //                        color: Colors.black,
              //    fontSize: 16,fontWeight: FontWeight.bold
              //       )
              //                 ),
              //                 TextSpan(
              //                   text: ' Class with Mrs. Shalini ',
              //                   style: GoogleFonts.lato(
              //                        color: Colors.black,
              //    fontSize: 16,fontWeight: FontWeight.bold
              //       )
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // SliverToBoxAdapter(
              //   child: Container(
              //     margin: EdgeInsets.fromLTRB(278, 10, 10, 5),
              //     child: Text(
              //       '5 min ago',
              //       textAlign: TextAlign.right,
              //       style: GoogleFonts.lato(
              //    fontSize: 16,fontWeight: FontWeight.bold
              //       )
              //     ),
              //   ),
              // ),

              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 20,
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 0, 24),
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis
                        .horizontal, // Set the scrolling direction to horizontal
                    children: [
                      SectionButtonComponent(
                        label: 'Class',
                        iconImagePath: 'assets/images/books.png',
                        backgroundColor: const Color(0xff56e484),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      SectionButtonComponent(
                        label: 'Feedbacks',
                        iconImagePath: 'assets/images/vector-Pkm.png',
                        backgroundColor: const Color(0xffd9d9d9),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      SectionButtonComponent(
                        label: 'Homework',
                        iconImagePath: 'assets/images/path-494-YT3.png',
                        backgroundColor: const Color(0xffd9d9d9),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      SectionButtonComponent(
                        label: 'Performance',
                        iconImagePath: 'assets/images/group-3279-Lvm.png',
                        backgroundColor: const Color(0xffd9d9d9),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      SectionButtonComponent(
                        label: 'Notifications',
                        iconImagePath: 'assets/images/vector-cLR.png',
                        backgroundColor: const Color(0xffd9d9d9),
                      ),
                    ],
                  ),
                ),
              ),
              // SliverToBoxAdapter(
              //   child: Container(
              //     margin: const EdgeInsets.fromLTRB(10, 0, 16, 0),
              //     width: double.infinity,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         Text(
              //           'Her Classes',
              //           style: GoogleFonts.lato(
              //    fontSize: 16,fontWeight: FontWeight.bold
              //       )
              //         ),
              //         Opacity(
              //           opacity: 0.7,
              //           child: SizedBox(
              //             width: 30, // Set your custom width here
              //             height: 30, // Set your custom height here
              //             child: Image.asset(
              //               'assets/images/group-3855.png',
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // SliverToBoxAdapter(
              //   child: CarouselSlider.builder(
              //     carouselController: _controller,
              //     itemCount: lessonData
              //         .length, // Use the length of your lessonData list
              //     itemBuilder:
              //         (BuildContext context, int itemIndex, int pageViewIndex) {
              //       final lesson = lessonData[
              //           itemIndex]; // Get the lesson data for the current index
              //       return LessonCard(
              //         title: lesson['title'] ?? '',
              //         subtitle: lesson['subtitle'] ?? '',
              //         teacherName: lesson['teacherName'] ?? '',
              //         imageAsset: lesson['imageAsset'] ?? '',
              //         iconAsset: lesson['iconAsset'] ?? '',
              //       );
              //     },
              //     options: CarouselOptions(
              //       enableInfiniteScroll: false,
              //       viewportFraction: 1,
              //       onPageChanged: (index, reason) {
              //         setState(() {
              //           currentPageToday = index;
              //         });
              //       },
              //     ),
              //   ),
              // ),
//               SliverToBoxAdapter(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     for (int i = 0; i < itemCount; i++)
//                       Container(
//                         width: 8.0,
//                         height: 8.0,
//                         margin: const EdgeInsets.symmetric(
//                             vertical: 10, horizontal: 2),
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: currentPageToday == i
//                               ? AppColors.black
//                               : AppColors.lightGrey,
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//               SliverToBoxAdapter(
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 10),
//                   child: Text(
//                     'Her Class Teacher',
//                     style: GoogleFonts.lato(
//  fontSize: 16,fontWeight: FontWeight.bold
//                     )
//                 ),
//               ),),
//               const SliverToBoxAdapter(child: SizedBox(height: 20)),
//               SliverToBoxAdapter(
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 20.0, right: 20),
//                   child: TeacherInfoCard(
//                       teacherName: 'Shalini Ray',
//                       subject: 'Social Science',
//                       imageUrl:
//                           'https://media.istockphoto.com/id/1309328823/photo/headshot-portrait-of-smiling-male-employee-in-office.jpg?b=1&s=612x612&w=0&k=20&c=eU56mZTN4ZXYDJ2SR2DFcQahxEnIl3CiqpP3SOQVbbI='),
//                 ),
//               ),
//               const SliverToBoxAdapter(child: SizedBox(height: 20)),
//               SliverToBoxAdapter(
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 10),
//                   child: Text(
//                     'All Teachers',
//                     style:  GoogleFonts.lato(
//                  fontSize: 16,fontWeight: FontWeight.bold
//                     )
//                   ),
//                 ),
//               ),
              // const SliverToBoxAdapter(child: SizedBox(height: 20)),
              // SliverToBoxAdapter(
              //   child: Padding(
              //     padding: const EdgeInsets.only(left: 20.0, right: 20),
              //     child: AllTeacherCard(
              //         teacherName: 'Shalini Ray',
              //         subject: 'Social Science',
              //         imageUrl:
              //             'https://media.istockphoto.com/id/1309328823/photo/headshot-portrait-of-smiling-male-employee-in-office.jpg?b=1&s=612x612&w=0&k=20&c=eU56mZTN4ZXYDJ2SR2DFcQahxEnIl3CiqpP3SOQVbbI='),
              //   ),
              // ),
              // const SliverToBoxAdapter(child: SizedBox(height: 20)),
              // SliverToBoxAdapter(
              //   child: Padding(
              //     padding: const EdgeInsets.only(left:10),
              //     child: Text(
              //       'Teachers Note',
              //       style:  GoogleFonts.lato(
              //    fontSize: 16,fontWeight: FontWeight.bold
              //       )
              //     ),
              //   ),
              // ),
              // const SliverToBoxAdapter(child: SizedBox(height: 20)),
              // SliverToBoxAdapter(
              //   child: Padding(
              //     padding: const EdgeInsets.all(10.0),
              //     child: Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: TeachersNoteCard(
              //         teacherName: 'Neetu Kapoor',
              //         subject: 'Science',
              //         imageUrl:
              //             'https://media.istockphoto.com/id/1309328823/photo/headshot-portrait-of-smiling-male-employee-in-office.jpg?b=1&s=612x612&w=0&k=20&c=eU56mZTN4ZXYDJ2SR2DFcQahxEnIl3CiqpP3SOQVbbI=',
              //         description:
              //             'Bring practical notebook to the class, we will conduct some experiments',
              //       ),
              //     ),
              //   ),
              // ),
              // const SliverToBoxAdapter(child: SizedBox(height: 20)),
              // SliverToBoxAdapter(
              //   child: Padding(
              //     padding: const EdgeInsets.only(left: 10),
              //     child:  Text(
              //       'Courses Enrolled',
              //       style:GoogleFonts.lato(
              //    fontSize: 16,fontWeight: FontWeight.bold
              //       )
              //     ),
              //   ),
              // ),
              // const SliverToBoxAdapter(child: SizedBox(height: 20)),
              // SliverToBoxAdapter(
              //   child: SizedBox(
              //     height: 280,
              //     child: ListView.builder(
              //       scrollDirection: Axis.horizontal,
              //       itemCount: cardData.length,
              //       itemBuilder: (context, index) {
              //         final data = cardData[index];
              //         return Padding(
              //           padding: const EdgeInsets.symmetric(vertical: 8.0),
              //           child: TwoColumnCard(
              //             imagePath: data['imagePath'] ?? '',
              //             title: data['title'] ?? '',
              //             schoolName: data['schoolName'] ?? '',
              //             progress: data['progress'] ?? '',
              //           ),
              //         );
              //       },
              //     ),
              //   ),
              // ),
              // const SliverToBoxAdapter(child: SizedBox(height: 20)),
              // SliverToBoxAdapter(
              //   child: Padding(
              //     padding: const EdgeInsets.only(left: 10),
              //     child: Text(
              //       'Similar Courses',
              //       style: GoogleFonts.lato(
              //    fontSize: 16,fontWeight: FontWeight.bold
              //       )
              //     ),
              //   ),
              // ),
              // const SliverToBoxAdapter(child: SizedBox(height: 20)),
              // SliverToBoxAdapter(
              //   child: SizedBox(
              //     height: 280,
              //     child: ListView.builder(
              //       scrollDirection: Axis.horizontal,
              //       itemCount: cardData.length,
              //       itemBuilder: (context, index) {
              //         final data = cardData[index];
              //         return Padding(
              //           padding: const EdgeInsets.symmetric(vertical: 8.0),
              //           child: TwoColumnCard(
              //             imagePath: data['imagePath'] ?? '',
              //             title: data['title'] ?? '',
              //             schoolName: data['schoolName'] ?? '',
              //             progress: data['progress'] ?? '',
              //           ),
              //         );
              //       },
              //     ),
              //   ),
              // ),
              // const SliverToBoxAdapter(child: SizedBox(height: 20)),
              // SliverToBoxAdapter(
              //   child: Padding(
              //     padding: const EdgeInsets.only(left: 10),
              //     child: Text(
              //       'Attendance',
              //       style: GoogleFonts.lato(
              //    fontSize: 16,fontWeight: FontWeight.bold
              //       )
              //     ),
              //   ),
              // ),
              // const SliverToBoxAdapter(child: SizedBox(height: 20)),
              // SliverToBoxAdapter(
              //   child: Padding(
              //     padding: const EdgeInsets.all(18.0),
              //     child: Container(
              //       margin: EdgeInsets.fromLTRB(1, 0, 0, 24),
              //       padding: EdgeInsets.fromLTRB(38, 28, 46.82, 24),
              //       decoration: BoxDecoration(
              //         color: const Color(0x1956e484),
              //         borderRadius: BorderRadius.circular(24),
              //       ),
              //       child: Row(
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: [
              //           Container(
              //             margin: EdgeInsets.fromLTRB(0, 16, 31, 0),
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.center,
              //               children: [
              //                 Center(
              //                   child: Container(
              //                     margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
              //                     child: Text(
              //                       'Present',
              //                       textAlign: TextAlign.center,
              //                       style:GoogleFonts.lato(
              //    fontSize: 24,fontWeight: FontWeight.bold
              //       )
              //                     ),
              //                   ),
              //                 ),
              //                 Container(
              //                   margin: EdgeInsets.fromLTRB(1, 0, 0, 0),
              //                   child: Text(
              //                     'Today',
              //                     style: GoogleFonts.lato(
              //    fontSize: 12,fontWeight: FontWeight.bold
              //       )
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //           Padding(
              //             padding: const EdgeInsets.only(left: 70),
              //             child: Container(
              //               child: Column(children: [
              //                 Text(
              //                           '88%',
              //                           textAlign: TextAlign.center,
              //                           style: GoogleFonts.lato(
              //    fontSize: 24,fontWeight: FontWeight.bold
              //       )
              //                         ),
              //                         Padding(
              //                           padding: const EdgeInsets.only(top: 10),
              //                           child: Text(
              //                                 'October',
              //                                 textAlign: TextAlign.center,
              //                                 style: GoogleFonts.lato(
              //    fontSize: 12,fontWeight: FontWeight.bold
              //       )
              //                               ),
              //                         ),
              //               ],),
              //             ),
              //           )
              //           // Container(

              //           //   width: 130.68,
              //           //   child: Column(
              //           //     crossAxisAlignment: CrossAxisAlignment.center,
              //           //     children: [
              //           //       Center(
              //           //         child: Container(
              //           //           margin: EdgeInsets.fromLTRB(0.32, 0, 0, 20),
              //           //           child: Text(
              //           //             '88%',
              //           //             textAlign: TextAlign.center,
              //           //             style: TextStyle(
              //           //               fontFamily: 'Poppins',
              //           //               fontSize: 24,
              //           //               fontWeight: FontWeight.w700,

              //           //               color: Color(0xff707070),
              //           //             ),
              //           //           ),
              //           //         ),
              //           //       ),
              //           //       // Container(
              //           //       //   width: double.infinity,
              //           //       //   child: Row(
              //           //       //     crossAxisAlignment: CrossAxisAlignment.center,
              //           //       //     children: [
              //           //       //       Container(
              //           //       //         margin: EdgeInsets.fromLTRB(55, 0, 11.5, 0),
              //           //       //         child: Text(
              //           //       //           'October',
              //           //       //           textAlign: TextAlign.center,
              //           //       //           style: TextStyle(
              //           //       //             fontFamily: 'Lato',
              //           //       //             fontSize: 12,
              //           //       //             fontWeight: FontWeight.w400,
              //           //       //             height: 1.3333333333,
              //           //       //             color: const Color(0xff707070),
              //           //       //           ),
              //           //       //         ),
              //           //       //       ),
              //           //       //       // Container(
              //           //       //       //   margin: EdgeInsets.fromLTRB(0, 4.59, 0, 0),
              //           //       //       //   width: 7.18,
              //           //       //       //   height: 4.59,
              //           //       //       //   child: Image.asset(
              //           //       //       //     'assets/images/vector-3TF.png',
              //           //       //       //     width: 7.18,
              // //           //       //       //     height: 4.59,
              // //           //       //       //   ),
              // //           //       //       // ),
              // //           //       //     ],
              // //           //       //   ),
              // //           //       // ),
              // //           //     ],
              // //           //   ),
              // //           // ),
              // //         ],
              // //       ),
              // //     ),
              // //   ),
              // // ),
              // const SliverToBoxAdapter(child: SizedBox(height: 20)),
              // SliverToBoxAdapter(
              //   child: Padding(
              //     padding: const EdgeInsets.only(left: 8.0),
              //     child: Container(
              //       child:  Text(
              //         'Upcoming School Events',
              //         style: GoogleFonts.lato(
              //    fontSize: 16,fontWeight: FontWeight.bold
              //       )
              //       ),
              //     ),
              //   ),
              // ),
              // const SliverToBoxAdapter(child: SizedBox(height: 20)),
              // SliverToBoxAdapter(
              //   child: CarouselSlider.builder(
              //     carouselController: _controller,
              //     itemCount: itemCount,
              //     itemBuilder:
              //         (BuildContext context, int itemIndex, int pageViewIndex) {
              //       return Padding(
              //         padding: const EdgeInsets.only(left: 18.0),
              //         child: UpcomingEvent(
              //           imagePaths: [
              //             'assets/images/mask-group-hFF.png',
              //           ],
              //         ),
              //       );
              //     },
              //     options: CarouselOptions(
              //       enableInfiniteScroll: false,
              //       viewportFraction: 1,
              //       onPageChanged: (index, reason) {
              //         setState(() {
              //           currentPageTommorow = index;
              //         });
              //       },
              //     ),
              //   ),
              // ),
              // SliverToBoxAdapter(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       for (int i = 0; i < itemCount; i++)
              //         Container(
              //           width: 8.0,
              //           height: 8.0,
              //           margin: const EdgeInsets.symmetric(
              //               vertical: 10, horizontal: 2),
              //           decoration: BoxDecoration(
              //             shape: BoxShape.circle,
              //             color: currentPageTommorow == i
              //                 ? AppColors.black
              //                 : AppColors.lightGrey,
              //           ),
              //         ),
              //     ],
              //   ),
              // ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left: 2, right: 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomCard(
                        imagePath: 'assets/leave_request.png',
                        title: 'Leave request',
                      ),
                      CustomCard(
                        imagePath: 'assets/pic3.png',
                        title: 'Attendance',
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left: 2, right: 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomCard(
                        imagePath: 'assets/images/thumbtack-solid.png',
                        title: 'Notices',
                      ),
                      CustomCard(
                        imagePath: 'assets/Events_pic.png',
                        title: 'Events',
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left: 2, right: 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomCard(
                        imagePath: 'assets/fee_payment.png',
                        title: 'Fee payment',
                      ),
                      CustomCard(
                        imagePath: 'assets/about.png',
                        title: 'About School',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

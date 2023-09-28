import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:schoolpenintern/Screens/Profile/Addprofile/AddProfilePages/AddParentScreens/ParentAddStepOne.dart';

import 'package:schoolpenintern/Screens/Profile/Addprofile/AddProfilePages/AddStudentScreens/AddStudentStepOne.dart';
import 'package:schoolpenintern/Screens/Profile/Addprofile/AddProfilePages/AddTeacherScreens/AddTeacherStepOne.dart';
import 'package:schoolpenintern/Screens/StartupDashBord/views/admin_user.dart';
import 'package:schoolpenintern/Screens/Student/home_screen.dart';

import '../Screens/SplashScreen.dart';
import '../Screens/home_screen.dart';
import '../bloc/main_bloc/main_bloc.dart';
import 'routes_names.dart';

class AppRoutes {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    switch (settings.name) {
// Splash Screen ======================
      case RoutesName.splash:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AppSetUpBloc(),
            child: const SplashScreen(),
          ),
        );
// Start Screen ======================
      case RoutesName.startPage:
        return MaterialPageRoute(
          builder: (context) => RoleScreen(),
        );
// Start Screen ======================
      case RoutesName.startPage:
        return MaterialPageRoute(
          builder: (context) => RoleScreen(),
        );

// Student HomeSCree OFter Login ====================
      // case RoutesName.studenthome:
      //   return MaterialPageRoute(
      //     builder: (context) => StudentHomeScreen(),
      //   );

// Chat Home =====================
      // case RoutesName.chatPage:
      //   return MaterialPageRoute(
      //     builder: (context) => ChatHomeScreen(),
      //   );

// Add Student Home =====================
      case RoutesName.addstudentprofile:
        return MaterialPageRoute(
          builder: (context) => AddStudentStepOne(),
        );

// Add Teacher Home =====================
      case RoutesName.addteacherprofile:
        return MaterialPageRoute(
          builder: (context) => AddTeacherStepOne(),
        );

// Add Teacher Home =====================
      case RoutesName.addparentprofile:
        return MaterialPageRoute(
          builder: (context) => ParentAddStepOne(),
        );

// And Default Screen ###################
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text("No Route Found!"),
            ),
          ),
        );
    }
  }
}

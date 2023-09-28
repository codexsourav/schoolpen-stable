//  * Created by: Sourav Bapari
//  * ----------------------------------------------------------------------------

import 'package:flutter/material.dart';

import '../../Screens/Profile/ViewProfile/Constents.dart';
import '../../Theme/Colors/appcolors.dart';

Widget inviteParents({onclick}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    decoration: BoxDecoration(
        color: viewProfileTabs["student"]['bgcolor'],
        borderRadius: BorderRadius.circular(30)),
    child: ListTile(
      title: const Text("Invite your parents and explore our parents app"),
      trailing: GestureDetector(
        onTap: onclick,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 7),
          decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Color(0xFF9163D7),
              ),
              borderRadius: BorderRadius.circular(50)),
          child: Text(
            "Invite",
            style: TextStyle(
                color: Color(0xFF9163D7),
                fontWeight: FontWeight.bold,
                fontSize: 17),
          ),
        ),
      ),
    ),
  );
}

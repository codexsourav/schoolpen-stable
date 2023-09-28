import 'package:flutter/material.dart';

Map viewProfileTabs = {
  "student": {
    'bgcolor': const Color(0XffEBE4F5),
    "darkcolor": const Color(0Xff9163D7),
    "tabs": [
      {
        "tabtitle": "Profile",
        "dbindex": "profile",
      },
      {
        "tabtitle": "Academics",
        "dbindex": "Academics",
      },
      {
        "tabtitle": "Attendance",
        "dbindex": "Attendance",
      },
      {
        "tabtitle": "Performance",
        "dbindex": "Performance",
      },
    ],
  },
  "teacher": {
    'bgcolor': const Color.fromARGB(255, 250, 237, 239),
    "darkcolor": const Color.fromARGB(255, 211, 76, 97),
    "tabs": [
      {
        "tabtitle": "Profile",
        "dbindex": "profile",
      },
      {
        "tabtitle": "Academics",
        "dbindex": "Academics",
      },
      {
        "tabtitle": "Attendance",
        "dbindex": "Attendance",
      },
      {
        "tabtitle": "Performance",
        "dbindex": "Performance",
      },
    ],
  },
  "parent": {
    'bgcolor': const Color(0xFFEEFCF3),
    "darkcolor": const Color(0xFF56E484),
    "tabs": [
      {
        "tabtitle": "Profile",
        "dbindex": "profile",
      },
      {
        "tabtitle": "Performance",
        "dbindex": "Performance",
      },
    ],
  },
  "management": {
    'bgcolor': const Color(0xFFEBE4F5),
    "darkcolor": const Color(0xFF9163D7),
    'tabs': [
      {
        "tabtitle": "Profile",
        "dbindex": "profile",
      },
      {
        "tabtitle": "School performace",
        "dbindex": "Performance",
      },
    ]
  }
};

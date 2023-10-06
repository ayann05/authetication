import 'dart:async';

import 'package:authetication/posts/postscreen.dart';
import 'package:authetication/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if (user != null) {
      Timer(
        Duration(seconds: 5),
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostScreen(),
          ),
        ),
      );
    } else {
      Timer(
        Duration(seconds: 5),
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => loginScreen(),
          ),
        ),
      );
    }
  }
}

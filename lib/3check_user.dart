import 'package:flutter/material.dart';
import 'package:frontend_queueless/4signup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend_queueless/5login_page.dart';
import 'package:frontend_queueless/6bottom_navigator.dart';

class Checkuser extends StatefulWidget {
  const Checkuser({super.key});

  @override
  State<Checkuser> createState() => _CheckuserState();
}

class _CheckuserState extends State<Checkuser> {

  bool loading = true;
  bool loggedIn = false;

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  Future<void> checkUser() async {

    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("jwt");

    if (token != null && token.isNotEmpty) {
      loggedIn = true;
    } else {
      loggedIn = false;
    }

    if (!mounted) return;

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (loggedIn) {
      return BottomNavigator();
    }

    return const SignupPage();
  }
}
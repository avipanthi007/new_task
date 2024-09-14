// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:newrise_task/features/auth/views/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  const HomeScreen({
    Key? key,
    required this.username,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? inactivityTimer;
  Timer? warningTimer;
  int warningCountdown = 30;
  bool warning = false;

  void resetTimer() {
    inactivityTimer?.cancel();
    warningTimer?.cancel();
    setState(() {
      warningCountdown = 30;
      warning = false;
    });
    inactivityTimer = Timer(const Duration(minutes: 1), showInactiveWarning);
  }

  void showInactiveWarning() {
    setState(() {
      warning = true;
    });
    warningTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (warningCountdown > 0) {
        setState(() {
          warningCountdown--;
        });
      } else {
        timer.cancel();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    resetTimer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    inactivityTimer?.cancel();
    warningTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        resetTimer();
      },
      onDoubleTap: () {
        resetTimer();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home Screen"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: Center(
            child: warning
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Inactive",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Log Out In $warningCountdown seconds",
                        style: const TextStyle(fontSize: 20),
                      )
                    ],
                  )
                : Text(
                    widget.username,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
      ),
    );
  }
}

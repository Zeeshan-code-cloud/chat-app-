import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../Controllers/MyApp_style.dart';
import 'SignIn_page.dart';
class Landing_page extends StatefulWidget {
  const Landing_page({Key? key}) : super(key: key);

  @override
  State<Landing_page> createState() => _Landing_pageState();
}

class _Landing_pageState extends State<Landing_page> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Login_page()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 300,
            width: 300,
            margin: const EdgeInsets.symmetric(horizontal: 62.0),
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/logo.png"),
                  fit: BoxFit.contain,
                )),
          ),
          const Gap(22.0),
          const Text(
            "Happy chat",
            style: Myapp_style.fontStyle1,
          ),
        ],
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:future_chat/Views/BottomNaviation_Bar.dart';
import 'package:gap/gap.dart';
import 'package:ndialog/ndialog.dart';
import '../Controllers/MyApp_style.dart';
import 'Main_page.dart';
import 'SignUp_page.dart';

class Login_page extends StatefulWidget {
  const Login_page({Key? key}) : super(key: key);

  @override
  State<Login_page> createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {
  final email_controller = TextEditingController();
  final password_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Myapp_style.bg_color,
      body: Container(
        margin: const EdgeInsets.only(top: 40),
        padding: const EdgeInsets.symmetric(
          horizontal: 33.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 250,
                width: 300,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/login_logo_rb.png"),
                      fit: BoxFit.contain,
                    )),
              ),
              const Gap(33.0),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                    color: Myapp_style.container_color,
                    borderRadius: BorderRadius.circular(25.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400.withOpacity(0.4),
                        blurRadius: 4.0,
                        spreadRadius: 2.0,
                      )
                    ]),
                child: TextField(
                  controller: email_controller,
                  decoration: const InputDecoration(
                    hintText: "Enter email...",
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Myapp_style.prefix_icon,
                      size: 30,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const Gap(33.0),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                    color: Myapp_style.container_color,
                    borderRadius: BorderRadius.circular(25.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400.withOpacity(0.4),
                        blurRadius: 4.0,
                        spreadRadius: 2.0,
                      )
                    ]),
                child: TextField(
                  obscureText: true,
                  controller: password_controller,
                  decoration: const InputDecoration(
                    hintText: "Enter password...",
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Myapp_style.prefix_icon,
                      size: 30,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const Gap(33.0),
              InkWell(
                onTap: () async {
                  var email = email_controller.text.toString().trim();
                  var password = password_controller.text.toString().trim();
                  if (email.isEmpty || password.isEmpty) {
                    Fluttertoast.showToast(msg: "Provide email and password");
                    return;
                  } else {
                    final user_auth = FirebaseAuth.instance;

                    ProgressDialog progressDialog = ProgressDialog(context,
                        title: const Text("Processing"),
                        message: const Text("Please wait"));
                    progressDialog.show();
                    try {
                      UserCredential userCredential =
                      await user_auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (userCredential.user!.uid != null) {
                        progressDialog.dismiss();
                        Fluttertoast.showToast(msg: "Operation done");
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const Bottom_nav()));
                        return;
                      } else {
                        progressDialog.dismiss();
                        Fluttertoast.showToast(msg: "Operation not completed");
                        return;
                      }
                    } on FirebaseAuthException catch (e) {
                      progressDialog.dismiss();
                      if (e.code == "user-not-found") {
                        Fluttertoast.showToast(
                            msg: "User not found with email ");
                        return;
                      } else if (e.code == "wrong-password") {
                        Fluttertoast.showToast(msg: "wrong password");
                        return;
                      } else {
                        progressDialog.dismiss();
                        Fluttertoast.showToast(msg: "something went wrong ");
                        return;
                      }
                    }
                    return;
                  }
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                      color: Myapp_style.container_color,
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400.withOpacity(0.4),
                          blurRadius: 4.0,
                          spreadRadius: 2.0,
                        )
                      ]),
                  child: Center(
                    child: Text(
                      "Login",
                      style: Myapp_style.fontStyle1
                          .copyWith(color: Myapp_style.prefix_icon),
                    ),
                  ),
                ),
              ),
              const Gap(42),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 13.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Don't have account",
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    const Gap(4.0),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const Sign_up()));
                        },
                        child: Text(
                          "Create",
                          style: Myapp_style.fontStyle1.copyWith(
                              color: Myapp_style.prefix_icon, fontSize: 17),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

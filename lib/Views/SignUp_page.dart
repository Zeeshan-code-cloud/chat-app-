import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:ndialog/ndialog.dart';
import '../Controllers/MyApp_style.dart';
import 'SignIn_page.dart';


class Sign_up extends StatefulWidget {
  const Sign_up({Key? key}) : super(key: key);

  @override
  State<Sign_up> createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  final emailController = TextEditingController();
  final name_controller = TextEditingController();
  final password_controller = TextEditingController();
  final confirm_password_controller = TextEditingController();
  final numberController = TextEditingController();
  final addressController = TextEditingController();



  final user_auth = FirebaseAuth.instance;
  final firestore_ref = FirebaseFirestore.instance.collection("users");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Myapp_style.bg_color,
      body: Container(
        margin: const EdgeInsets.only(top: 45.0),
        padding: const EdgeInsets.symmetric(
          horizontal: 23.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20),
                width: 250,
                height: 200,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/register_logo.png"),
                      fit: BoxFit.contain,
                    )),
              ),
              const Gap(15.0),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.97,
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
                  obscureText: false,
                  controller: name_controller,
                  decoration: const InputDecoration(
                    hintText: "name...",
                    prefixIcon: Icon(
                      Icons.person,
                      color: Myapp_style.prefix_icon,
                      size: 30,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const Gap(15.0),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.97,
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
                  obscureText: false,
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: "email...",
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Myapp_style.prefix_icon,
                      size: 30,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const Gap(15.0),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.97,
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
                    hintText: " password...",
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Myapp_style.prefix_icon,
                      size: 30,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const Gap(15.0),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.97,
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
                  controller: confirm_password_controller,
                  decoration: const InputDecoration(
                    hintText: "confirm  password...",
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Myapp_style.prefix_icon,
                      size: 30,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const Gap(15.0),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.97,
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
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  controller: numberController,
                  decoration: const InputDecoration(
                    hintText: "Phone",
                    prefixIcon: Icon(
                      Icons.phone_android_outlined,
                      color: Myapp_style.prefix_icon,
                      size: 30,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const Gap(15.0),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.97,
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
                  obscureText: false,
                  controller: addressController,
                  decoration: const InputDecoration(
                    hintText: "address",
                    prefixIcon: Icon(
                      Icons.location_on,
                      color: Myapp_style.prefix_icon,
                      size: 30,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const Gap(35.0),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        var name = name_controller.text.trim().toString();
                        var email = emailController.text.trim().toString();
                        var password = password_controller.text.trim().toString();
                        var confirm_password = confirm_password_controller.text.trim().toString();
                        var number = numberController.text.trim().toString();
                        var address = addressController.text.trim().toString();
                        if (name.isEmpty || email.isEmpty || password.isEmpty ||
                            confirm_password.isEmpty || number.isEmpty || address.isEmpty) {
                          Fluttertoast.showToast(msg: "All field are mandatory ");
                          return;
                        } else if (password != confirm_password) {
                          Fluttertoast.showToast(msg: "password are not matching");
                          return;
                        } else if (password.length < 6) {
                          Fluttertoast.showToast(msg: "Provide strong password");
                          return;
                        }
                        //to connect the app with firebase as a backend
                        //create user with email and password
                        //by using of cloud firestore packeges
                        ProgressDialog progressDialog = ProgressDialog(context,
                            title: const Text("Processing"),
                            message: const Text("Please wait"));
                        progressDialog.show();
                        try {
                          UserCredential userCredential = await user_auth.createUserWithEmailAndPassword(
                              email: email, password: password);

                          if(userCredential.user != null){
                            String userId = userCredential.user!.uid.toString();
                            firestore_ref.doc(userId).set({
                              "name": name,
                              "email": email,
                              "password": password,
                              "id": userId,
                              "profile image": "",
                              "number" : number,
                              "address" : address,
                            }).then((value) {
                              progressDialog.dismiss();
                              Fluttertoast.showToast(msg: "operation done");
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                                return const  Login_page();
                              }));
                            }).onError((error, stackTrace) {
                              progressDialog.dismiss();
                              Fluttertoast.showToast(msg: "operation failed");
                            });
                          }
                        } on FirebaseAuthException catch (e) {
                          progressDialog.dismiss();
                          if (e.code == "email-already-in-use") {
                            Fluttertoast.showToast(
                                msg: "this email  already taken");
                            return;
                          } else if (e.code == "invalid-email") {
                            Fluttertoast.showToast(msg: "format the email");
                            return;
                          } else if (e.code == "operation-not-allowed") {
                            Fluttertoast.showToast(
                                msg: "Operation not allowed");
                            return;
                          } else {
                            Fluttertoast.showToast(msg: "Something went wrong");
                            return;
                          }
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 12.0),
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
                            "Registered",
                            style: Myapp_style.fontStyle1.copyWith(
                                color: Myapp_style.prefix_icon,
                                fontSize: 19,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Gap(2.0),
                  const Text("OR"),
                  const Gap(2.0),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.only(left: 12.0),
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
                            child: ClipRRect(
                              child: Image.asset("assets/images/google_logo.png"),
                            )),
                      ),
                    ),
                  )
                ],
              ),
              const Gap(22.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Already have account",
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
                                  builder: (context) => const Login_page()));
                        },
                        child: Text(
                          "Login",
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

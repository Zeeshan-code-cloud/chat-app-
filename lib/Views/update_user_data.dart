import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:future_chat/Controllers/MyApp_style.dart';
import 'package:future_chat/Views/Profile_page.dart';
import 'package:gap/gap.dart';

import 'BottomNaviation_Bar.dart';

class Update_data extends StatelessWidget {
  Map<String, dynamic> map11 = {};

  Update_data(this.map11, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NameController = TextEditingController(text: map11["name"]);
    final emailController = TextEditingController(text: map11["email"]);
    final numberController = TextEditingController(text: map11["number"]);
    final addressController = TextEditingController(text: map11["address"]);
    final firestore_ref = FirebaseFirestore.instance.collection("users").doc(
        map11["id"]);

    return Scaffold(
        backgroundColor: Myapp_style.bg_color,
        appBar: AppBar(
          title: const Text("Update data"),
          automaticallyImplyLeading: true,

        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 33.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: NameController,
              ),
              const Gap(22.0),
              TextField(
                controller: emailController,
              ),
              const Gap(22.0),
              TextField(
                keyboardType: TextInputType.number,
                controller: numberController,
              ),
              const Gap(22.0),
              TextField(
                controller: addressController,
              ),
              const Gap(42.0),
              ElevatedButton(onPressed: () {
                var name = NameController.text.trim().toString();
                var email = emailController.text.trim().toString();
                var number = numberController.text.trim().toString();
                var address = addressController.text.trim().toString();
                firestore_ref.update({
                  "name": name,
                  "email": email,
                  "number": number,
                  "address": address,
                });
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const Bottom_nav()));
              }, child: const Text("update"))
            ],
          ),
        )
    );
  }
}

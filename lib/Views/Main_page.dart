import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../Controllers/MyApp_style.dart';
import 'Chat_Details_page.dart';

class Main_page extends StatefulWidget {
  const Main_page({Key? key}) : super(key: key);

  @override
  State<Main_page> createState() => _Main_pageState();
}

class _Main_pageState extends State<Main_page> {
  final SearchController = TextEditingController();
  final user_auth = FirebaseAuth.instance.currentUser;
  final firestore_ref = FirebaseFirestore.instance.collection("users").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Myapp_style.Main_page_bg,

      body: Column(
        children: [
          const Gap(50.0),
          Container(
            margin: const EdgeInsets.only(left: 14.0),
            height: 50,
            width: MediaQuery
                .of(context)
                .size
                .width * 0.92,
            decoration: BoxDecoration(
                color: Myapp_style.drawar_bg,
                borderRadius: BorderRadius.circular(22.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 2.0,
                  )
                ]),
            child: TextField(
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
              controller: SearchController,
              decoration: const InputDecoration(
                labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                hintText: "Search here",
                hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                prefixIcon: Icon(
                    Icons.search,
                    size: 30,
                    color: Myapp_style.prefix_icon
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          const Gap(22.0),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: const Divider(thickness: 1.0, color: Myapp_style.divider)),
          const Gap(22.0),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: firestore_ref,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                      ));
                } else if (snapshot.hasError) {
                  return const ScaffoldMessenger(
                      child: SnackBar(
                        content: Text("something went wrong"),
                      ));
                }

                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      Map<String,dynamic> go_to_detailsPage = {
                        "name" : snapshot.data!.docs[index]["name"].toString(),
                        "id" : snapshot.data!.docs[index]["id"].toString(),
                        "profile image" : snapshot.data!.docs[index]["profile image"].toString(),
                      };

                      return ListTile(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (
                                  context) =>  Chat_Details_page(go_to_detailsPage)));
                        },
                        leading:  Container(
                          margin: EdgeInsets.only(top: 12.0),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(snapshot.data!.docs[index]["profile image"]),
                          ),
                        ),
                        title: Text(snapshot.data!.docs[index]["name"]
                            .toString(),
                          style: Myapp_style.app_text.copyWith(fontSize: 25,),
                        ),
                      );
                    });
              },
            ),
          ),
        ],
      ),

    );
  }
}

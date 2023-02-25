import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:future_chat/Controllers/MyApp_style.dart';
import 'package:future_chat/Views/BottomNaviation_Bar.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import '../Controllers/SignleMessage.dart';

class Chat_Details_page extends StatefulWidget {
  Map<String, dynamic> user_map = {};

  Chat_Details_page(this.user_map, {Key? key}) : super(key: key);

  @override
  State<Chat_Details_page> createState() => _Chat_Details_pageState();
}

class _Chat_Details_pageState extends State<Chat_Details_page> {
  final MessageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Myapp_style.bg_color,
      appBar: AppBar(
        backgroundColor: Myapp_style.drawar_bg,
        toolbarHeight: 72.0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const Bottom_nav()));
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Myapp_style.prefix_icon,
          ),
        ),
        title: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 12.0),
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(widget.user_map["profile image"]),
              ),
            ),
            const Gap(12.0),
            Text(
              widget.user_map["name"],
              style: Myapp_style.app_text,
            ),
          ],
        ),
        actions: [
          Container(
              margin: const EdgeInsets.only(right: 22.0),
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.call,
                    size: 35,
                    color: Myapp_style.prefix_icon,
                  )))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Container(
                padding: const EdgeInsets.all(22.0),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(22.0),
                      topLeft: Radius.circular(22.0),
                    )),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("users").doc(
                      FirebaseAuth.instance.currentUser!.uid).collection(
                      "message").doc(widget.user_map["id"])
                      .collection("chat")
                      .orderBy("date", descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          reverse: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            bool Isme = snapshot.data!
                                .docs[index]["senderId"] == FirebaseAuth
                                .instance.currentUser!.uid;
                            return SingleMessage(message: snapshot.data!
                                .docs[index]["message"], isme: Isme);
                          });
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(strokeWidth: 4,),);
                    }
                    return const Center(
                      child: Text("Say hi", style: Myapp_style.app_text,),);
                  },
                ),
              )),
          Container(
            height: 75,
            padding:
            const EdgeInsets.symmetric(horizontal: 22.0, vertical: 19.0),
            width: MediaQuery
                .of(context)
                .size
                .width * 0.97,
            decoration: BoxDecoration(
              color: Myapp_style.container_color,
              borderRadius: BorderRadius.circular(22.0),
            ),
            child: TextField(
              controller: MessageController,
              decoration: InputDecoration(
                  prefixIcon: IconButton(onPressed: () {
                    SendImageFromGallery();
                  }, icon: Icon(Icons.image, color: Myapp_style.prefix_icon,),),
                  hintText: "enter here",
                  suffixIcon: IconButton(
                      iconSize: 30,
                      color: Myapp_style.prefix_icon,
                      onPressed: () async {
                        //store a message on firestore in a specific collection
                        String message = MessageController.text.trim();
                        MessageController.clear();
                        /////code to send a message
                        await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("message").doc(widget.user_map["id"]).collection("chat").add({
                          "message": message,
                          "type": "text",
                          "receiverId": widget.user_map["id"],
                          "senderId": FirebaseAuth.instance.currentUser!.uid.toString(),
                          "date": DateTime.now(),
                          "profile image": "",
                        }).then((value) {
                          FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("message").doc(widget.user_map["id"]).set({
                            "last message": message.toString(),
                          });
                        });

                        /////code ot receive a message
                        FirebaseFirestore.instance.collection("users").doc(widget.user_map["id"]).collection("message").doc(FirebaseAuth.instance.currentUser!.uid).collection("chat").add({
                          "message": message,
                          "receiverId": widget.user_map["id"],
                          "senderId": FirebaseAuth.instance.currentUser!.uid,
                          "date": DateTime.now(),
                          "profile image": "",
                        }).then((value) {
                          FirebaseFirestore.instance.collection("users").doc(widget.user_map["id"]).collection("message").doc(FirebaseAuth.instance.currentUser!.uid).set({
                            "last message": message.toString(),
                          });
                        });
                      },
                      icon: const Icon(Icons.send)),
                  border: InputBorder.none),
            ),
          )
        ],
      ),
    );
  }

  final pickedImage = ImagePicker();
  File? file;
  String uniquefile = "";


  Future SendImageFromGallery() async {
    final selectImage = await pickedImage.pickImage(
        source: ImageSource.gallery, imageQuality: 100);
    if (selectImage == null) return;
    file = File(selectImage!.path);

    ///here we convert the xfile in file type
    //now to upload the file in to the storage  of the firebase

    //create a refference to storage of the firebase
    uniquefile = DateTime.now().millisecondsSinceEpoch.toString();

    UploadTask uploadTask =   FirebaseStorage.instance.ref().child("mediaFileFir").child(uniquefile).putFile(File(file!.path));
    TaskSnapshot taskSnapshot = await  uploadTask;

    final Mediafileurl = await taskSnapshot.ref.getDownloadURL();

    //now to update the url in the corresponding data in the database

    final file_storage = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("mediaFile").doc(widget.user_map["id"]).collection("file").add({

      "message" : Mediafileurl.toString(),
      "type" : "media file",
      "currentUserId" : FirebaseAuth.instance.currentUser!.uid,
      "receiverId" : widget.user_map["id"],
    });


    }
}

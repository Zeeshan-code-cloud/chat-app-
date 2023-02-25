import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:future_chat/Controllers/MyApp_style.dart';
import 'package:future_chat/Views/SignIn_page.dart';
import 'package:future_chat/Views/update_user_data.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndialog/ndialog.dart';

class Profile_page extends StatefulWidget {
  const Profile_page({Key? key}) : super(key: key);

  @override
  State<Profile_page> createState() => _Profile_pageState();
}

class _Profile_pageState extends State<Profile_page> {
  String? name;
  String? address;
  String? id;
  String? email;
  String? number;
  String unifile = "";
  bool showfileimage = false;

  Future getData_database() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) {
      setState(() {
        name = snapshot.data()!["name"];
        id = snapshot.data()!["id"];
        email = snapshot.data()!["email"];
        address = snapshot.data()!["address"];
        number = snapshot.data()!["number"];
      });
    });
  }

  @override
  void initState() {
    getData_database();
    // TODO: implement initState
    super.initState();
  }

  final user_auth = FirebaseAuth.instance;
  final pickImage = ImagePicker();
  XFile? file;

  Future getImage_camera() async {
    final picked_file = await pickImage.pickImage(
        source: ImageSource.camera, imageQuality: 100);
    file = File(picked_file!.path) as XFile?;
    if (file == null) return;
    //now to upload that picked file to the storage
    // we eliminate the data type of the variable
    unifile = DateTime.now().millisecondsSinceEpoch.toString();
    UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child("user_image")
        .child(unifile)
        .putFile(File(file!.path));
    TaskSnapshot snapshot = await uploadTask;
    String ImgUrl = await snapshot.ref.getDownloadURL();

    print(ImgUrl);

    // save the url in a realtime database firestore of corresponding data
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "profile image": ImgUrl,
    });
  }

  Future getImage_gallery() async {
    final picked_file = await pickImage.pickImage(
        source: ImageSource.gallery, imageQuality: 100);
    file = await XFile(picked_file!.path);
    showfileimage = true;
    setState(() {});
    if (file == null) return;
    //now to upload that picked file to the storage
    // we eliminate the data type of the variable
    ProgressDialog progressDialog = ProgressDialog(context,
        title: Text("Processing"), message: Text("Please wait"));
    progressDialog.show();
    try {
      progressDialog.dismiss();
      unifile = DateTime.now().millisecondsSinceEpoch.toString();
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child("user_image")
          .child(unifile)
          .putFile(File(file!.path));
      TaskSnapshot snapshot = await uploadTask;
      String ImgUrl = await snapshot.ref.getDownloadURL();

      // save the url in a realtime database firestore of corresponding data
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "profile image": ImgUrl,
      });
    } catch (e) {
      progressDialog.dismiss();
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Myapp_style.Main_page_bg,
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(25),
            Container(
              margin: const EdgeInsets.only(top: 100),
              child: Stack(children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: showfileimage == false
                      ? const NetworkImage(
                          "http://pluspng.com/img-png/png-face-profile--700.png",
                        )
                      : FileImage(File(file!.path)) as ImageProvider,
                ),
                Positioned(
                    top: 92,
                    left: 35,
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Choose image"),
                                content: SizedBox(
                                  height: 130,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        onTap: () {
                                          getImage_camera();
                                          Navigator.of(context).pop();
                                        },
                                        leading: const Icon(
                                          Icons.camera_alt_rounded,
                                          color: Myapp_style.prefix_icon,
                                        ),
                                        title: const Text("Camera"),
                                      ),
                                      const Gap(12.0),
                                      ListTile(
                                        onTap: () {
                                          getImage_gallery();
                                          Navigator.of(context).pop();
                                        },
                                        leading: const Icon(
                                          Icons.image,
                                          color: Myapp_style.prefix_icon,
                                        ),
                                        title: const Text("Gallery"),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      icon: const Icon(
                        Icons.add_circle,
                        size: 50,
                        color: Myapp_style.prefix_icon,
                      ),
                    ))
              ]),
            ),
            const Gap(25),
            ReusableRow(
                name: "Name", iconData: (Icons.person), value: name.toString()),
            const Gap(25),
            ReusableRow(
                name: "email",
                iconData: (Icons.email),
                value: email.toString()),
            const Gap(25),
            ReusableRow(
                name: "Number",
                iconData: (Icons.account_box_sharp),
                value: number.toString()),
            const Gap(25),
            ReusableRow(
                name: "Address",
                iconData: (Icons.image),
                value: address.toString()),
            const Gap(25),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      Map<String,dynamic> data_to_updated = {
                        "name": name,
                        "email": email,
                        "number" : number,
                        "address" : address,
                        "id" : id,
                      };
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Update_data(data_to_updated)));
                    },
                    child: const Text("Update"),
                  )),
                  const Gap(22.0),
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Row(
                                  children: const [
                                    Icon(
                                      Icons.warning,
                                      size: 25,
                                      color: Myapp_style.prefix_icon,
                                    ),
                                    Gap(12.0),
                                    Text("Confirmation msg"),
                                  ],
                                ),
                                content: const Text("Are you sure to logout"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        user_auth.signOut();
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return const Login_page();
                                        }));
                                      },
                                      child: const Text("Yes")),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("N0"))
                                ],
                              ));
                    },
                    child: const Text("Logout"),
                  ))
                ],
              ),
            )
          ],
        )));
  }
}

class ReusableRow extends StatelessWidget {
  late String name, titile, value;
  IconData iconData;

  ReusableRow(
      {required this.name,
      required this.iconData,
      required this.value,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        iconData,
        color: Colors.white,
        size: 35,
      ),
      title: Text(
        name,
        style: Myapp_style.fontStyle1,
      ),
      trailing: Text(
        value,
        style: Myapp_style.app_text,
      ),
    );
  }
}

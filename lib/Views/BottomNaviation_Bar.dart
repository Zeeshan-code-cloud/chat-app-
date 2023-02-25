import 'package:flutter/material.dart';
import 'package:future_chat/Controllers/MyApp_style.dart';
import 'package:future_chat/Views/Call_page.dart';
import 'package:future_chat/Views/Main_page.dart';
import 'package:future_chat/Views/Profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Bottom_nav extends StatefulWidget {
  const Bottom_nav({Key? key}) : super(key: key);

  @override
  State<Bottom_nav> createState() => _Bottom_navState();
}

class _Bottom_navState extends State<Bottom_nav> {

  int MyIndex = 0;
 List<Widget> list = [
   const Main_page(),
   const Call_page(),
    Profile_page(),
 ];
  @override
  Widget build(BuildContext context) {
            return Scaffold(
              body: list[MyIndex],
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Myapp_style.Main_page_bg,
                elevation: 0.0,
                currentIndex: MyIndex,
                onTap: (int index){
                  setState(() {
                    MyIndex = index;
                  });
                },
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.indigo,
                iconSize: 30,
                items: const  [
                  BottomNavigationBarItem(icon: Icon(Icons.chat),label: "chat"),
                  BottomNavigationBarItem(icon: Icon(Icons.call),label: "Call"),
                  BottomNavigationBarItem(icon: Icon(Icons.person_pin_sharp),label: "Profile"),
                ],
              ),
            );
        }
        // return

  }


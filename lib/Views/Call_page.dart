import 'package:flutter/material.dart';
import 'package:future_chat/Controllers/MyApp_style.dart';

class Call_page extends StatefulWidget {
  const Call_page({Key? key}) : super(key: key);

  @override
  State<Call_page> createState() => _Call_pageState();
}

class _Call_pageState extends State<Call_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Myapp_style.Main_page_bg,
      appBar: AppBar(
        title: const Text("Call page"),
        centerTitle: true,
      ),
    );
  }
}

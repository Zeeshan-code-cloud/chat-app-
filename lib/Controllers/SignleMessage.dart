import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleMessage extends StatelessWidget {
  final String message;
  final bool isme;
  const SingleMessage({
    required this.message,
    required this.isme,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
       mainAxisAlignment: isme ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(18.0),
          margin: EdgeInsets.all(12.0),
          constraints: BoxConstraints(maxWidth: 200),
          decoration: BoxDecoration(
            color: isme ? Colors.black : Colors.orange,
            borderRadius: BorderRadius.circular(22.0)
          ),
          child: Text(message, style: TextStyle(color: isme ? Colors.white : Colors.black),),
        )
      ],
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';

class SuccessfulSplash extends StatefulWidget {
  String? text;

  SuccessfulSplash({this.text});

  @override
  _SuccessfulSplashState createState() => _SuccessfulSplashState();
}

class _SuccessfulSplashState extends State<SuccessfulSplash> {
  // Redirect Function


  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 2),
          () {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
        }
    );
  }

  @override
  Widget build(BuildContext context) {

    String _text = widget.text ?? "Successful";

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints(minWidth: 200, maxWidth: 500),
          margin: EdgeInsets.symmetric(horizontal: 14.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Successful Icon
                Icon(Icons.check, size: 50),

                SizedBox(height: 30),

                Text(
                  _text,
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
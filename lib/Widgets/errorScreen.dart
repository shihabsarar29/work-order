import 'dart:async';
import 'package:flutter/material.dart';


class ErrorSplash extends StatefulWidget {
  String? text;

  ErrorSplash({this.text});

  @override
  _ErrorSplashState createState() => _ErrorSplashState();
}

class _ErrorSplashState extends State<ErrorSplash> {


  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 2),
          () => Navigator.pop(context),
    );
  }

  @override
  Widget build(BuildContext context) {

    String _text = widget.text ?? "Error";

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
                Icon(Icons.close),

                SizedBox(height: 50),

                // Successful Text
                Text(
                  _text,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color(0xFFF94355),
                  ),
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
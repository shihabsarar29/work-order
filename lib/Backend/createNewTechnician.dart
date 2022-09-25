
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:work_order/Widgets/errorScreen.dart';
import 'package:work_order/Widgets/successfulScreen.dart';

class CreateNewTechnician extends StatelessWidget {
  String name, email, phone, location, workType, qualification;
  DateTime dailyStartTime, dailyEndTime;

  CreateNewTechnician({
    required this.name,
    required this.email,
    required this.phone,
    required this.location,
    required this.workType,
    required this.qualification,
    required this.dailyStartTime,
    required this.dailyEndTime,
  });


  Future<void> _insertData() async {

    try {
        await FirebaseFirestore.instance.collection("Technicians").add({
          'name': name,
          'email': email,
          'phone': phone,
          'location': location,
          'workType': workType,
          'qualification': qualification,
          'dailyStartTime': dailyStartTime,
          'dailyEndTime': dailyEndTime,
          'schedule': [],
        });

    } catch (e) {
      e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: _insertData(),
      builder: (context, snapshot) {

        // Error
        if (snapshot.data != null) {
          print("Error Message: ${snapshot.data}");
          return ErrorSplash(
            text: "Error\nPlease try again later.",
          );
        }

        // Connection Success
        else if (snapshot.connectionState == ConnectionState.done) {
            print("Technician added successfully");
            return SuccessfulSplash(
              text: "Success\nNew Technician added",
            );
        }

        // Loading Screen
        else {
          return Scaffold(
            body: Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        }
      },
    );
  }
}
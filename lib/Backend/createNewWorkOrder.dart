import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:work_order/Widgets/errorScreen.dart';
import 'package:work_order/Widgets/successfulScreen.dart';



class CreateNewWorkOrder extends StatelessWidget {
  String name, description, location, workType, qualification, technicianName, technicianEmail;
  DateTime dailyStartTime, dailyEndTime;

  CreateNewWorkOrder({
    required this.name,
    required this.description,
    required this.location,
    required this.workType,
    required this.qualification,
    required this.dailyStartTime,
    required this.dailyEndTime,
    required this.technicianEmail,
    required this.technicianName,
  });


  Future<void> _insertData() async {


    try {

        await FirebaseFirestore.instance.collection("WorkOrders").add({
          'name': name,
          'description': description,
          'location': location,
          'workType': workType,
          'qualification': qualification,
          'dailyStartTime': dailyStartTime,
          'dailyEndTime': dailyEndTime,
          'technicianName': technicianName,
          'technicianEmail': technicianEmail,
        });

        final Email email = Email(
          body: 'Dear $technicianName,\nA new work order, $name, has been assigned.\nDetails - $description.\nStart Time - $dailyStartTime.\nEnd Time - $dailyEndTime',
          subject: 'New Work Order Assigned',
          recipients: [technicianEmail],
        );

        await FlutterEmailSender.send(email);

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
        // if (snapshot.data == "No Technician found") {
        //   print("Error Message: ${snapshot.error}");
        //   return ErrorSplash(
        //     text: "Error\nNo Technician found.",
        //   );
        // }

        if (snapshot.data != null) {
          print("Error Message: ${snapshot.error}");
          return ErrorSplash(
            text: "Error\nPlease try again later.",
          );
        }

        // Connection Success
        else if (snapshot.connectionState == ConnectionState.done) {
            print("Work Order added successfully");
            return SuccessfulSplash(
              text: "Success\nNew Work Order added",
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
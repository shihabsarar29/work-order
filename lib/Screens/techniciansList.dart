import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:work_order/Screens/technicianInput.dart';


class TechiniciansListScreen extends StatefulWidget {
  const TechiniciansListScreen({Key? key}) : super(key: key);

  @override
  _TechiniciansListScreenState createState() => _TechiniciansListScreenState();
}

class _TechiniciansListScreenState extends State<TechiniciansListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              const Text(
                "Technicians",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                ),
              ),

              SizedBox(height: 20),

              TechnicianCards(),

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const TechnicianInputScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}



class TechnicianCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection("Technicians").get(),
      builder: (context, snapshot) {

        /// Database Error
        if (snapshot.hasError) {
          print("${snapshot.error}");
          return Center(
            child: Text("Something went wrong. Please try again later."),
          );
        }

        /// Database Connection Successful
        else if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            height: MediaQuery.of(context).size.height - 220,
            child: ListView(
              children: snapshot.data!.docs.map((document) {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                              child: Text(document.get("name"), style: TextStyle(fontWeight: FontWeight.bold)),
                          ),

                          SizedBox(height: 5),

                          Row(
                            children: [
                              Text(document.get("email") + "  -  "),
                              Text(document.get("phone")),
                            ],
                          ),

                          SizedBox(height: 5),

                          Row(
                            children: [
                              Text(document.get("location") + ";   "),
                              Text(DateFormat("hh:mm a").format(DateTime.fromMicrosecondsSinceEpoch(document.get("dailyStartTime").microsecondsSinceEpoch)) + " - "),
                              Text(DateFormat("hh:mm a").format(DateTime.fromMicrosecondsSinceEpoch(document.get("dailyEndTime").microsecondsSinceEpoch))),
                            ],
                          ),

                          SizedBox(height: 5),

                          Row(
                            children: [
                              Text(document.get("workType") + "  -  "),
                              Text(document.get("qualification")),
                            ],
                          ),

                        ],
                      ),
                    ),

                    SizedBox(height: 20),
                  ],
                );
              }).toList(),
            ),
          );
        }

        /// Loading Screen
        else {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }
      },
    );
  }
}


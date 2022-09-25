import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:work_order/Backend/createNewWorkOrder.dart';

class WorkOrderInputScreen extends StatefulWidget {
  const WorkOrderInputScreen({Key? key}) : super(key: key);

  @override
  State<WorkOrderInputScreen> createState() => _WorkOrderInputScreenState();
}

class _WorkOrderInputScreenState extends State<WorkOrderInputScreen> {
  List<String> workTypes = ["Electronics", "Technology", "Engineering", "Management"];
  List<String> qualifications = ["Beginner", "Proficient", "Advanced"];


  String selectedWorkType = "";
  String selectedQualification = "";
  DateTime? workStartTime;
  DateTime? workEndTime;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  void initState(){
    selectedWorkType = workTypes[0];
    selectedQualification = qualifications[0];
    workStartTime = DateTime(2022, 1, 1, 8);
    workEndTime = DateTime(2022, 1, 1, 17);
    super.initState();
  }

  TimeOfDay selectedStartTime = TimeOfDay(hour: 8, minute: 0);
  TimeOfDay selectedEndTime = TimeOfDay(hour: 17, minute: 0);

  /// Start Time Picker
  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked_s = await showTimePicker(
      context: context,
      initialTime: selectedStartTime,
    );

    if (picked_s != null && picked_s != selectedStartTime ) {
      setState(() {
        selectedStartTime = picked_s;
        workStartTime = DateTime(2022, 1, 1, picked_s.hour, picked_s.minute);
      });
    }
  }

  /// End Time Picker
  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked_s = await showTimePicker(
      context: context,
      initialTime: selectedEndTime,
    );

    if (picked_s != null && picked_s != selectedEndTime ) {
      setState(() {
        selectedEndTime = picked_s;
        workEndTime = DateTime(2022, 1, 1, picked_s.hour, picked_s.minute);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [

              Text(
                "Create New Work Order",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),

              SizedBox(height: 30),

              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
                controller: nameController,
              ),

              SizedBox(height: 20),

              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 2,
                controller: descriptionController,
              ),


              SizedBox(height: 20),

              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Location',
                ),
                controller: locationController,
              ),

              SizedBox(height: 20),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text("Work Type", style: TextStyle(fontSize: 18)),

                    DropdownButton<String>(
                      value: selectedWorkType,
                      items: workTypes.map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value){
                        setState(() {
                          selectedWorkType = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text("Qualification", style: TextStyle(fontSize: 18)),

                    DropdownButton<String>(
                      value: selectedQualification,
                      items: qualifications.map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value){
                        setState(() {
                          selectedQualification = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        _selectStartTime(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Start Time\n${workStartTime!.hour}:${workStartTime!.minute}",
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),


                    InkWell(
                      onTap: (){
                        _selectEndTime(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "End Time\n${workEndTime!.hour}:${workEndTime!.minute}",
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30),

              InkWell(
                onTap: () async {
                  String technicianName = "";
                  String technicianEmail = "";

                  var snapshot = await FirebaseFirestore.instance.collection("Technicians").get();
                  snapshot.docs.forEach((element) {
                    print(element.get("name"));
                    if(element.get("workType") == selectedWorkType && element.get("qualification") == selectedQualification){
                        technicianName = element.get("name");
                        technicianEmail = element.get("email");
                      }
                  });

                  if(technicianName == ""){
                    Fluttertoast.showToast(
                        msg: "No Technician found",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                    );
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            CreateNewWorkOrder(
                              name: nameController.text,
                              description: descriptionController.text,
                              location: locationController.text,
                              workType: selectedWorkType,
                              qualification: selectedQualification,
                              dailyStartTime: workStartTime!,
                              dailyEndTime: workEndTime!,
                            ),
                      ),
                    );
                  }
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Submit Work Order",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

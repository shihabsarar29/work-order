import 'package:flutter/material.dart';
import 'package:work_order/Backend/createNewTechnician.dart';

class TechnicianInputScreen extends StatefulWidget {
  const TechnicianInputScreen({Key? key}) : super(key: key);

  @override
  State<TechnicianInputScreen> createState() => _TechnicianInputScreenState();
}

class _TechnicianInputScreenState extends State<TechnicianInputScreen> {
  List<String> workTypes = ["Electronics", "Technology", "Engineering", "Management"];
  List<String> qualifications = ["Beginner", "Proficient", "Advanced"];


  String selectedWorkType = "";
  String selectedQualification = "";
  DateTime? workStartTime;
  DateTime? workEndTime;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  void initState(){
    selectedWorkType = workTypes[0];
    selectedQualification = qualifications[0];
    workStartTime = DateTime(2022, 1, 1, 8);
    workEndTime = DateTime(2022, 1, 1, 17);
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {

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

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [

              Text(
                "Enter New Technician",
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
                  labelText: 'Email',
                ),
                controller: emailController,
              ),

              SizedBox(height: 20),

              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone Number',
                ),
                controller: phoneController,
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
                            "Daily Start Time\n${workStartTime!.hour}:${workStartTime!.minute}",
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
                          "Daily End Time\n${workEndTime!.hour}:${workEndTime!.minute}",
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
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CreateNewTechnician(
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                        location: locationController.text,
                        workType: selectedWorkType,
                        qualification: selectedQualification,
                        dailyStartTime: workStartTime!,
                        dailyEndTime: workEndTime!,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Submit form",
                    style: TextStyle(color: Colors.white),
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

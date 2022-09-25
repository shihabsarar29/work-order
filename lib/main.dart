import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:work_order/Screens/workOrdersList.dart';

import 'Screens/techniciansList.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Management System',
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [

              const SizedBox(height: 50),

              const Text(
                  "Work Order\nManagement System",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                ),
              ),

              const SizedBox(height: 50),

              /// Work Orders
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const WorkOrdersScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                     children: const [
                       Icon(
                         Icons.work_history,
                         size: 50,
                         color: Colors.white,
                       ),
                       SizedBox(height: 10),
                       Text(
                         "Work Orders",
                         style: TextStyle(
                           fontSize: 30,
                           color: Colors.white,
                         ),
                       ),
                     ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              /// Technicians
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const TechiniciansListScreen(),
                    ),
                  );
                },
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: const [
                        Icon(
                          Icons.people,
                          size: 50,
                          color: Colors.white,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Technicians",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ],

                    )
                ),
              ),
            ],

          ),
        ),
      ),
    );
  }
}

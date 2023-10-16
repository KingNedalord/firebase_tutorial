import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_tutorial/firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController first_name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  String gotFirstName = "";
  String gotLastName = "";
  CollectionReference student = FirebaseFirestore.instance.collection("ok");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: first_name,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "First name"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: last_name,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Last name"),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                height: 70,
                minWidth: 100,
                onPressed: () {
                  if (first_name.text != "" && last_name.text != ""){
                    student.add({"first name":first_name.text,"last name":last_name.text});
                  }
                },
                child: Text("Send"),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text(gotFirstName),
                      Text(gotLastName),
                    ],
                  ),
                  MaterialButton(
                    height: 70,
                    minWidth: 100,
                    onPressed: () {
                      setState(() {
                        student.doc("QH85zleuRvmxV5QgcIpY").get().then((value) {setState(() {
                          gotFirstName = value["first name"];
                          gotLastName = value["last name"];
                        });});
                      });
                    },
                    child: Text("Get"),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

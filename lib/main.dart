import 'dart:collection';

import 'package:bakkal_app/bakkalInterface.dart';
import 'package:bakkal_app/bussauth.dart';
import 'package:bakkal_app/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'interface.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bakkal_App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> goTo(var uid, bool isbussiness) async {
    if (isbussiness) {
      var ref = FirebaseDatabase.instance.ref().child("Bussiness");
      ref.onValue.listen((event) {
        var data = event.snapshot.value as dynamic;
        data.forEach((key, value) {
          var classes = BussAuth.json(value);
          if (classes.uid == uid) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) =>
                        BakkalInterface(uid, "${key}", true))));
          }
        });
      });
    } else {
      var ref = FirebaseDatabase.instance.ref().child("User");
      ref.onValue.listen((event) {
        var data = event.snapshot.value as dynamic;
        data.forEach((key, value) {
          var classes = BussAuth.json(value);
          if (classes.uid == uid) {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => Interface(uid))));
          }
        });
      });
    }
  }

  Future<void> register(
      bool isBussiness, String name, String email, String password) async {
    var auth = FirebaseAuth.instance;
    try {
      var signUp = auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        if (isBussiness) {
          var ref = FirebaseDatabase.instance.ref().child("Bussiness");
          var map = HashMap();
          map["uid"] = value.user?.uid;
          map["name"] = name;
          ref.push().set(map);
          goTo(value.user?.uid, isBussiness);
        } else {
          var ref = FirebaseDatabase.instance.ref().child("User");
          var map = HashMap();
          map["uid"] = value.user?.uid;
          map["name"] = name;
          ref.push().set(map);
          goTo(value.user?.uid, isBussiness);
        }
      });
    } on FirebaseAuthException {}
  }

  Future<void> logIn(
      bool isBussiness, String name, String email, String password) async {
    var auth = FirebaseAuth.instance;
    try {
      var signUp = auth
          .signInWithEmailAndPassword(email: email.trim(), password: password)
          .then((value) {
        if (isBussiness) {
          goTo(value.user?.uid, isBussiness);
        } else {
          goTo(value.user?.uid, isBussiness);
        }
      });
    } on FirebaseAuthException {}
  }

  var switchData = true;
  var name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Interface"),
          centerTitle: true,
          elevation: 1,
          shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Color.fromRGBO(86, 242, 214, 100),
              ),
              borderRadius: BorderRadius.circular(10)),
          backgroundColor: Color.fromRGBO(86, 242, 214, 100),
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Card(
                  color: Color.fromRGBO(86, 242, 214, 100),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                      width: 300,
                      height: 400,
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: TextField(
                              controller: name,
                              style: TextStyle(
                                  color: Color.fromRGBO(86, 242, 214, 100)),
                              decoration: InputDecoration(
                                  hintText: "Name",
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: Colors.white))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: TextField(
                              controller: email,
                              style: TextStyle(
                                  color: Color.fromRGBO(86, 242, 214, 100)),
                              decoration: InputDecoration(
                                  hintText: "Email",
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: Colors.white))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: TextField(
                              controller: password,
                              style: TextStyle(
                                  color: Color.fromRGBO(86, 242, 214, 100)),
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: Colors.white))),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "is Bussiness",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Switch(
                                value: switchData,
                                onChanged: ((value) {
                                  setState(() {
                                    switchData = value;
                                  });
                                }),
                                activeColor: Color.fromRGBO(86, 242, 214, 100),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: (() {
                                  logIn(switchData, name.text, email.text,
                                      password.text);
                                }),
                                child: Text("Log In"),
                                style: ElevatedButton.styleFrom(
                                    onPrimary:
                                        Color.fromRGBO(86, 242, 214, 100),
                                    primary: Colors.white,
                                    elevation: 0,
                                    minimumSize: Size(85, 45)),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                onPressed: (() {
                                  register(switchData, name.text, email.text,
                                      password.text);
                                }),
                                child: Text("Register"),
                                style: ElevatedButton.styleFrom(
                                    onPrimary:
                                        Color.fromRGBO(86, 242, 214, 100),
                                    primary: Colors.white,
                                    elevation: 0,
                                    minimumSize: Size(85, 45)),
                              ),
                            ],
                          ),
                        ],
                      )))),
        ));
  }
}

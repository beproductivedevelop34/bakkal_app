import 'package:bakkal_app/bakkalInterface.dart';
import 'package:bakkal_app/bussauth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Interface extends StatefulWidget {
  var uid;
  var key;
  Interface(this.uid);

  @override
  State<Interface> createState() => _InterfaceState();
}

class _InterfaceState extends State<Interface> {
  var ref = FirebaseDatabase.instance.ref().child("Bussiness");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Bakkallar"),
          centerTitle: true,
          leading: IconButton(
              onPressed: (() {
                Navigator.pop(context);
              }),
              icon: Icon(Icons.arrow_back_ios)),
          elevation: 1,
          shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Color.fromRGBO(86, 242, 214, 100),
              ),
              borderRadius: BorderRadius.circular(10)),
          backgroundColor: Color.fromRGBO(86, 242, 214, 100),
        ),
        body: StreamBuilder<DatabaseEvent>(
            stream: ref.onValue,
            builder: (context, event) {
              var list = <BussAuth>[];
              var keyList = [];
              if (event.hasData && event.data?.snapshot.value != null) {
                var val = event.data?.snapshot.value as dynamic;
                val.forEach((key, value) {
                  var clasS = BussAuth.json(value);
                  list.add(clasS);
                  keyList.add(key);
                });
              }
              return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: ((context, index) {
                    return Card(
                      color: Color.fromRGBO(86, 242, 214, 100),
                      child: SizedBox(
                        width: 100,
                        height: 150,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                "${list[index].name}",
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              ElevatedButton(
                                onPressed: (() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              BakkalInterface(
                                                  list[index].uid,"${keyList[index]}" ,false))));
                                }),
                                child: Text("Git"),
                                style: ElevatedButton.styleFrom(
                                    onPrimary: Colors.white,
                                    primary: Color.fromRGBO(86, 242, 214, 100),
                                    minimumSize: Size(85, 45)),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }));
            }));
  }
}

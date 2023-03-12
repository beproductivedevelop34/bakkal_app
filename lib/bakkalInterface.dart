import 'dart:collection';

import 'package:bakkal_app/main.dart';
import 'package:bakkal_app/siparisList.dart';
import 'package:bakkal_app/urun.dart';
import 'package:bakkal_app/urunAdd.dart';
import 'package:bakkal_app/urunEdit.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';

class BakkalInterface extends StatefulWidget {
  var uid;
  String keys;
  bool isAuth;
  BakkalInterface(this.uid, this.keys, this.isAuth);

  @override
  State<BakkalInterface> createState() => _BakkalInterfaceState();
}

class _BakkalInterfaceState extends State<BakkalInterface> {
  Future<void> addSiparis() async {
    var ref = FirebaseDatabase.instance.ref().child("Siparisler");
    var permission = await Geolocator.requestPermission();
    var geo = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    var map = HashMap();
    map["enlem"] = geo.latitude;
    map["boylam"] = geo.longitude;
    map["uid"] = widget.uid;
    ref.push().set(map);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Siparis Başarı ile Alındı")));
  }

  @override
  Widget build(BuildContext context) {
    var ref = FirebaseDatabase.instance
        .ref()
        .child("Bussiness/${widget.keys}/Urunler");
    return Scaffold(
      drawer: Visibility(
        visible: widget.isAuth,
        child: Drawer(
            child: ListView(
          children: [
            ListTile(
              title: Text("Main Page"),
              onTap: (() {}),
            ),
            ListTile(
              title: Text("Siparisler"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => SiparisList(widget.uid))));
              },
            )
          ],
        )),
      ),
      appBar: AppBar(
        title: Text("Ürünler"),
        centerTitle: true,
        leading: IconButton(
            onPressed: (() {
              if (widget.isAuth == false) {
                Navigator.pop(context);
              } else {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => MyHomePage())));
              }
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
            var list = <Urun>[];
            var keyList = [];
            if (event.hasData && event.data?.snapshot.value != null) {
              var val = event.data?.snapshot.value as dynamic;
              val.forEach((key, value) {
                var urun = Urun.json(value);
                list.add(urun);
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
                      height: 350,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                "${list[index].imageUrl}",
                                fit: BoxFit.fill,
                                height: 150.0,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Text(
                                "${list[index].name}",
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Visibility(
                              visible: widget.isAuth,
                              child: ElevatedButton(
                                onPressed: (() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => UrunEdit(
                                              widget.uid,
                                              "${keyList[index]}",
                                              widget.keys))));
                                }),
                                child: Text("Urun Edit"),
                                style: ElevatedButton.styleFrom(
                                    onPrimary: Colors.white,
                                    primary: Color.fromRGBO(86, 242, 214, 100),
                                    minimumSize: Size(90, 50)),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Visibility(
                              visible: !widget.isAuth,
                              child: ElevatedButton(
                                onPressed: (() {
                                  addSiparis();
                                }),
                                child: Text("Siparis Et"),
                                style: ElevatedButton.styleFrom(
                                    onPrimary: Colors.white,
                                    primary: Color.fromRGBO(86, 242, 214, 100),
                                    minimumSize: Size(90, 50)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }));
          }),
      floatingActionButton: Visibility(
        visible: widget.isAuth,
        child: FloatingActionButton(
          backgroundColor: Color.fromRGBO(86, 242, 214, 100),
          onPressed: (() {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => UrunAdd(widget.uid, widget.keys))));
          }),
          child: Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}

import 'dart:collection';
import 'dart:io';

import 'package:bakkal_app/interface.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class UrunAdd extends StatefulWidget {
  var uid;
  String keys;
  UrunAdd(this.uid, this.keys);

  @override
  State<UrunAdd> createState() => _UrunAddState();
}

class _UrunAddState extends State<UrunAdd> {
  var namee = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var ref = FirebaseDatabase.instance
        .ref()
        .child("Bussiness/${widget.keys}/Urunler");
    Future<void> add(String name) async {
      var picker = await FilePicker.platform
          .pickFiles(allowMultiple: false, type: FileType.any);
      var auth = FirebaseAuth.instance.signInAnonymously();
      var storage =
          FirebaseStorage.instance.ref().child("${picker!.files.first.name}");
      var storageFile = storage.putFile(File(picker.files.first.path!));
      var url = await storage.getDownloadURL();
      var map = HashMap();
      map["name"] = name;
      map["imageUrl"] = "${url}";
      ref.push().set(map);
      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      Interface(widget.uid))));
    }

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
        body: Center(
            child: Card(
                color: Color.fromRGBO(86, 242, 214, 100),
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Container(
                    width: 300,
                    height: 300,
                    child: Column(children: [
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextField(
                          controller: namee,
                          style: TextStyle(
                              color: Color.fromRGBO(86, 242, 214, 100)),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.white)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.white))),
                        ),
                      ),
                      Container(
                          child: Column(
                        children: [
                      ElevatedButton(
                        onPressed: (() {
                          add(namee.text);
                        }),
                        child: Text("Add"),
                        style: ElevatedButton.styleFrom(
                            onPrimary: Color.fromRGBO(86, 242, 214, 100),
                            primary: Colors.white,
                            elevation: 0,
                            minimumSize: Size(85, 45)),
                      )
                    ])
                    )])
                    )
                    )));
  }
}

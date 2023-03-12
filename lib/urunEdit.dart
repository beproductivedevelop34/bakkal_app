import 'dart:collection';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'interface.dart';

class UrunEdit extends StatefulWidget {
  var uid;
  var urunKey;
  var keys;
  UrunEdit(this.uid, this.urunKey, this.keys);

  @override
  State<UrunEdit> createState() => _UrunEditState();
}

class _UrunEditState extends State<UrunEdit> {
  var textname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var ref = FirebaseDatabase.instance
        .ref()
        .child("Bussiness/${widget.keys}/Urunler");
    Future<void> delete() async {
      ref.child("${widget.urunKey}").remove();
    }

    Future<void> add(String name) async {
      var picker = await FilePicker.platform
          .pickFiles(allowMultiple: false, type: FileType.image);
      var auth = FirebaseAuth.instance.signInAnonymously();
      var storage =
          FirebaseStorage.instance.ref().child("${picker!.files.first.name}");
      var storageFile = storage.putFile(File(picker.files.first.path!));
      var url = await storage.getDownloadURL();
      var map = HashMap<String, dynamic>();
      map["name"] = name;
      map["imageUrl"] = url;
      ref.child("${widget.urunKey}").update(map);
      Navigator.push(context,
          MaterialPageRoute(builder: ((context) => Interface(widget.uid))));
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
                          controller: textname,
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
                      ElevatedButton(
                        onPressed: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      Interface(widget.uid))));
                        }),
                        child: Text("Edit"),
                        style: ElevatedButton.styleFrom(
                            onPrimary: Color.fromRGBO(86, 242, 214, 100),
                            primary: Colors.white,
                            elevation: 0,
                            minimumSize: Size(85, 45)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: (() {
                          delete();
                        }),
                        child: Text("Delete"),
                        style: ElevatedButton.styleFrom(
                            onPrimary: Color.fromRGBO(86, 242, 214, 100),
                            primary: Colors.white,
                            elevation: 0,
                            minimumSize: Size(85, 45)),
                      )
                    ])))));
  }
}

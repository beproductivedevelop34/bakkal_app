import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'interface.dart';

class BakkalAdd extends StatefulWidget {
  var uid;
  BakkalAdd(this.uid);

  @override
  State<BakkalAdd> createState() => _BakkalAddState();
}

class _BakkalAddState extends State<BakkalAdd> {
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
        body: Center(
            child: Card(
                color: Color.fromRGBO(86, 242, 214, 100),
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Container(
                    width: 300,
                    height: 300,
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextField(
                            style: TextStyle(
                                color: Color.fromRGBO(86, 242, 214, 100)),
                            decoration: InputDecoration(
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
                        ElevatedButton(
                          onPressed: (() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => Interface(widget.uid))));
                          }),
                          child: Text("Devam Et"),
                          style: ElevatedButton.styleFrom(
                              onPrimary: Color.fromRGBO(86, 242, 214, 100),
                              primary: Colors.white,
                              elevation: 0,
                              minimumSize: Size(85, 45)),
                        ),
                      ],
                    )))));
  }
}

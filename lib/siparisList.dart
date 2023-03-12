import 'package:bakkal_app/siparis.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:map_launcher/map_launcher.dart';

class SiparisList extends StatefulWidget {
  var uid;
  SiparisList(this.uid);

  @override
  State<SiparisList> createState() => _SiparisListState();
}

class _SiparisListState extends State<SiparisList> {
  Future<void> siparisSil(String key) async {
    var database = FirebaseDatabase.instance.ref().child("Siparisler");
    database.child("${key}").remove();
  }

  Future<void> mapLauncher(double enlem,double boylam) async {
    var isMap = await MapLauncher.isMapAvailable(MapType.google) ?? false;
    if (isMap) {
      await MapLauncher.showDirections(
          mapType: MapType.google, destination: Coords(enlem.toDouble(), boylam.toDouble()));
    }
  }

  @override
  Widget build(BuildContext context) {
    var ref = FirebaseDatabase.instance.ref().child("Siparisler");
    return Scaffold(
      appBar: AppBar(
        title: Text("Siparisler"),
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
            var list = <Siparis>[];
            var keyList = [];
            if (event.hasData && event.data?.snapshot.value != null) {
              var val = event.data?.snapshot.value as dynamic;
              val.forEach((key, value) {
                var urun = Siparis.json(value);
                if(urun.uid == widget.uid){
                  list.add(urun);
                  keyList.add(key);
                }
              });
            }
            return ListView.builder(
                itemCount: list.length,
                itemBuilder: ((context, index) {
                  return Card(
                    color: Color.fromRGBO(86, 242, 214, 100),
                    child: SizedBox(
                      width: 400,
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Siparis ${index}",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            ElevatedButton(
                              onPressed: (() {
                                mapLauncher(
                                    list[index].enlem, list[index].boylam);
                              }),
                              child: Text("Git"),
                              style: ElevatedButton.styleFrom(
                                  onPrimary: Color.fromRGBO(86, 242, 214, 100),
                                  primary: Colors.white,
                                  elevation: 0,
                                  minimumSize: Size(70, 30)),
                            ),
                            SizedBox(width: 10,),
                            ElevatedButton(
                              onPressed: (() {
                                siparisSil("${keyList[index]}");
                              }),
                              child: Text("Sil"),
                              style: ElevatedButton.styleFrom(
                                  onPrimary: Color.fromRGBO(86, 242, 214, 100),
                                  primary: Colors.white,
                                  elevation: 0,
                                  minimumSize: Size(70, 30)),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }));
          }),
    );
  }
}

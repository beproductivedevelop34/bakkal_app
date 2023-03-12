class BussAuth {
  String name;
  var uid;
  BussAuth(this.name, this.uid);
  factory BussAuth.json(Map map) {
    return BussAuth(map["name"],map["uid"] );
  }
}

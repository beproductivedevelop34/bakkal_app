class Siparis {
  double enlem;
  double boylam;
  var uid;
  Siparis(this.enlem, this.boylam, this.uid);
  factory Siparis.json(Map<dynamic, dynamic> map) {
    return Siparis(map["enlem"], map["boylam"], map["uid"]);
  }
}

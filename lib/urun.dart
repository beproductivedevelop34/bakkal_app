class Urun {
  String name;
  String imageUrl;
  Urun(this.name, this.imageUrl);
  factory Urun.json(Map map){
    return Urun(map["name"],map["imageUrl"]);
  }
}

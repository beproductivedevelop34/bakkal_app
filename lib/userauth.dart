class UserAuth {
  String name;
  var uid;
  UserAuth(this.name, this.uid);
  factory UserAuth.json(Map map) {
    return UserAuth(map["uid"], map["name"]);
  }
}
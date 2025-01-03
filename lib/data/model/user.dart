class User {
  int? id;
  String? username;
  String? imgUrl;

  User.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        username = map["username"],
        imgUrl = map["imgUrl"];
}

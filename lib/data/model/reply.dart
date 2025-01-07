import 'package:flutter_blog/data/model/user.dart';
import 'package:intl/intl.dart';

class Reply {
  int? id;
  String? comment;
  DateTime? createdAt;
  User? replyUser;

  Reply.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        comment = map["comment"],
        createdAt = DateFormat("yyyy-mm-dd").parse(map["createdAt"]),
        replyUser = User.fromMap(map["replyUser"]);
}

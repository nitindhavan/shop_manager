import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class UserModel{
  String UID;
  String name;
  String shopName;

  UserModel({required this.UID, required this.name, required this.shopName});

  UserModel.fromMap(Map<dynamic, dynamic> map)
      : UID = map['UID'],
        name = map['name'],
        shopName = map['shopName'];

  toMap() {
    return {
      'UID': UID,
      'name': name,
      'shopName': shopName,
    };
  }
}

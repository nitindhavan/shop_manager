import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class SupplierModel{
  String UID;
  String name;
  String phone;
  String address;
  String shopUID;


  SupplierModel(this.UID, this.name, this.phone, this.address,this.shopUID);

  SupplierModel.fromMap(Map<dynamic, dynamic> map)
      : UID = map['UID'],
        name = map['name'],
        phone=map['phone'],
        address=map['address'],
        shopUID=map['shopUID'];

  toMap() {
    return {
      'UID': UID,
      'name': name,
      'phone': phone,
      'address': address,
      'shopUID': shopUID
    };
  }
}

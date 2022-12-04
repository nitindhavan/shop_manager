import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ProductModel{
  String key;
  String name;
  String price;

  ProductModel(this.key, this.name, this.price);

  ProductModel.fromMap(Map<dynamic, dynamic> map)
      : key = map['key'],
        name = map['name'],
        price=map['price'];

  toMap() {
    return {
      'key': key,
      'name': name,
      'price': price,
    };
  }
}

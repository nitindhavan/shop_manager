import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ItemModel{
  String name;
  int quantity;
  int price;

  ItemModel(this.name,this.quantity, this.price);

  ItemModel.fromMap(Map<dynamic, dynamic> map)
      : name = map['name'],
        quantity=map['price'],
        price=map['price'];

  toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'price': price,
    };
  }
}

import 'package:shop_management/models/ItemModel.dart';

class BillModel{
  String key;
  String userID;
  String date;
  String type;
  int total;
  String userType;
  List<Map> item;

  BillModel(this.key, this.userID,this.date, this.type,this.total,this.item,this.userType);

  BillModel.fromMap(Map<dynamic, dynamic> map)
      : key = map['key'],
        userID = map['userID'],
        date=map['date'],
        type=map['type'],
        total=map['total'],
        userType=map['userType'],
        item=List<Map<dynamic,dynamic>>.from(map['item'].map((x) => x));

  toMap() {
    return {
      'key': key,
      'userID': userID,
      'date': date,
      'type': type,
      'total': total,
      'userType': userType,
      'item': item,
    };
  }
}

import 'package:flutter/material.dart';

class Item extends StatefulWidget {
  const Item({Key? key}) : super(key: key);

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          padding: EdgeInsets.only(left: 16,right: 16),
          width: double.infinity,
          margin: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
          decoration: BoxDecoration(
            color: Colors.blue.shade200,
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.center,
          child: TextField(textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),cursorColor: Colors.white,decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Enter Item Name',
            hintStyle: TextStyle(color: Colors.white)
          ),),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 60,
                padding: EdgeInsets.only(left: 16,right: 16),
                width: double.infinity,
                margin: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: TextField(textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),cursorColor: Colors.white,decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Quantity',
                    hintStyle: TextStyle(color: Colors.white)
                ),),
              ),
            ),
            Expanded(
              child: Container(
                height: 60,
                padding: EdgeInsets.only(left: 16,right: 16),
                width: double.infinity,
                margin: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: TextField(textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),cursorColor: Colors.white,decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Rate',
                    hintStyle: TextStyle(color: Colors.white)
                ),),
              ),
            ),
          ],
        )
      ],
    );
  }
}

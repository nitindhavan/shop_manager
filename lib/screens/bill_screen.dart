import 'package:flutter/material.dart';
import 'package:shop_management/screens/add_product_screen.dart';
import 'package:shop_management/screens/invoice_screen.dart';

class BillPage extends StatefulWidget {
  const BillPage({super.key});

  @override
  State<BillPage> createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                'Bills',
                style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 24,
                    fontWeight: FontWeight.w900),
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.only(left: 16,right: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(style: TextStyle(fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search Date or Time ...',
                          hintStyle: TextStyle(color: Colors.black54)
                      ),),
                  ),
                  Icon(Icons.search,color: Colors.black54,),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> InvoicePage())),
                  child: Container(
                    height: 60,
                    padding: EdgeInsets.only(left: 16,right: 16),
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade200,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Bill Date $index',textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                        Text('Bill Time',textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                      ],
                    ),
                  ),
                );
              },itemCount: 200,),
            ),
          ],
        ),
      ),
    );
  }
}

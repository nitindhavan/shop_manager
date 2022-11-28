import 'package:flutter/material.dart';
import 'package:shop_management/screens/add_product_screen.dart';
import 'package:shop_management/screens/invoice_screen.dart';

import '../widgets/item.dart';

class AddBillPage extends StatefulWidget {
  const AddBillPage({super.key});

  @override
  State<AddBillPage> createState() => _AddBillPageState();
}

class _AddBillPageState extends State<AddBillPage> {
  String currentBillType='Cash';
  List<Widget> items=[Item()];
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
                'Create Bill',
                style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 24,
                    fontWeight: FontWeight.w900),
              ),
            ),
            Row(
              children: [
                Expanded(child: Container(
                  height: 60,
                  padding: EdgeInsets.only(left: 16,right: 16),
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
                  decoration: BoxDecoration(
                    color: currentBillType=='Cash' ? Colors.green : Colors.blue.shade200,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Text('Cash',textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                ),),
                Expanded(child: Container(
                  height: 60,
                  padding: EdgeInsets.only(left: 16,right: 16),
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade200,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Text('Credit',textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                ),),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(itemBuilder: (BuildContext context, int index) {
                      return items[index];
                    },itemCount: items.length,shrinkWrap: true,physics: NeverScrollableScrollPhysics(),),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          items.add(Item());
                        });
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        margin: EdgeInsets.only(right: 16,top: 32,bottom: 8),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(60),
                            boxShadow: [BoxShadow(blurRadius: 4,color: Colors.green)]
                        ),
                        alignment: Alignment.center,
                        child: Icon(Icons.add,color: Colors.white,),
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> InvoicePage())),
              child: Container(
                height: 60,
                padding: EdgeInsets.only(left: 16,right: 16),
                width: double.infinity,
                margin: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: Text('Create Invoice',textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

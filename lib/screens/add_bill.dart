import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shop_management/models/BillModel.dart';
import 'package:shop_management/screens/bill_screen.dart';

import '../models/ItemModel.dart';
import '../widgets/item.dart';

class AddBillPage extends StatefulWidget {
  const AddBillPage({super.key,required this.userType,required this.uid});

  final String userType;
  final String uid;
  @override
  State<AddBillPage> createState() => _AddBillPageState();
}

class _AddBillPageState extends State<AddBillPage> {
  String currentBillType='Cash';
  List<TextEditingController> nameControllers=[];
  List<TextEditingController> quantityControllers=[];
  List<TextEditingController> priceControllers=[];
  List<Widget> items=[];
  bool once=false;
  @override
  Widget build(BuildContext context) {
    if(!once){
      nameControllers.add(TextEditingController());
      quantityControllers.add(TextEditingController());
      priceControllers.add(TextEditingController());
      int index=nameControllers.length-1;
      items.add(Item(name: nameControllers[index], quantity: quantityControllers[index], price: priceControllers[index]));
      once=true;
    }
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
                Expanded(child: GestureDetector(
                  onTap: (){
                    setState(() {
                    currentBillType='Cash';
                  });
                    },
                  child: Container(
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
                  ),
                ),),
                Expanded(child: GestureDetector(
                  onTap: (){
                    setState(() {
                      currentBillType='Credit';
                    });
                  },
                  child: Container(
                    height: 60,
                    padding: EdgeInsets.only(left: 16,right: 16),
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
                    decoration: BoxDecoration(
                      color: currentBillType=='Credit' ? Colors.green : Colors.blue.shade200,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: Text('Credit',textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                  ),
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
                          nameControllers.add(TextEditingController());
                          quantityControllers.add(TextEditingController());
                          priceControllers.add(TextEditingController());
                          int index=nameControllers.length-1;
                          items.add(Item(name: nameControllers[index], quantity: quantityControllers[index], price: priceControllers[index]));
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
              onTap: (){
                var ref=FirebaseDatabase.instance.ref('bills').child(FirebaseAuth.instance.currentUser!.uid);
                String key=ref.push().key!;
                List<Map> itemList=[];
                int total=0;
                for(int i=0; i< nameControllers.length;i++){
                  String name=nameControllers[i].text;
                  String quantityString=quantityControllers[i].text;
                  String priceString=priceControllers[i].text;

                  int quantity=0;
                  int price=0;
                  try{
                    quantity=int.parse(quantityString);
                    price= int.parse(priceString);
                    ItemModel item=ItemModel(name, quantity, price);
                    itemList.add(item.toMap());
                    total+=quantity*price;
                  }catch(e){
                    print('not valid values');
                  }
                }
                BillModel billModel=BillModel(key, widget.uid, DateTime.now().toIso8601String(), currentBillType, total, itemList,widget.userType);
                ref.child(key).set(billModel.toMap()).then((value){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> BillPage(uid: widget.uid, type: widget.userType)));
                });
              },
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
                child: Text('Create Bill',textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

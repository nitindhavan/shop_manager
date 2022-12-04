import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shop_management/models/BillModel.dart';
import 'package:shop_management/models/CustomerModel.dart';
import 'package:shop_management/screens/add_product_screen.dart';
import 'package:shop_management/screens/invoice_screen.dart';
import 'package:intl/intl.dart';

class BillPage extends StatefulWidget {
  const BillPage({super.key,required this.uid,required this.type});
  final String uid;
  final String type;
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
                          hintText: 'Search Date or Total ...',
                          hintStyle: TextStyle(color: Colors.black54)
                      ),),
                  ),
                  Icon(Icons.search,color: Colors.black54,),
                ],
              ),
            ),
            Expanded(
              child : FutureBuilder(builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if(!snapshot.hasData) return Center(child: Text('No Bills Found'),);
                List<BillModel> billList=[];
                for(DataSnapshot snap in snapshot.data!.snapshot.children){
                  BillModel model =BillModel.fromMap(snap.value as Map);
                  billList.add(model);
                }
                return ListView.builder(itemBuilder: (BuildContext context, int index) {
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
                          Text('Bill Date: ${DateFormat('dd-MMM-yyyy').format(DateTime.parse(billList[index].date))}',textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                          Text('Bill Total: ${billList[index].total}',textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                        ],
                      ),
                    ),
                  );
                },itemCount: billList.length,);
              },future: FirebaseDatabase.instance.ref('bills').child(FirebaseAuth.instance.currentUser!.uid).orderByChild('userID').equalTo(widget.uid).once(),)

            ),
          ],
        ),
      ),
    );
  }
}

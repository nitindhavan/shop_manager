import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shop_management/models/BillModel.dart';
import 'package:shop_management/screens/customer_screen.dart';
import 'package:shop_management/screens/pricing_screen.dart';
import 'package:shop_management/screens/profile_screen.dart';
import 'package:shop_management/screens/supplier_screen.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import '../models/UserModel.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key,required this.userModel});
  final UserModel userModel;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool pickerVisible=false;
  String _range='Select Date range';
  DateTime startDate=DateTime.now().add(const Duration(days: -6));
  DateTime endDate=DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hello User!',
                      style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 24,
                          fontWeight: FontWeight.w900),
                    ),
                    GestureDetector(
                        onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage(model : widget.userModel))),
                        child: Icon(Icons.person))
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    pickerVisible=!pickerVisible;
                  });
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text('${DateFormat('dd-MMM-yyyy').format(startDate)} -'
                        ' ${DateFormat('dd-MMM-yyyy').format(endDate)}',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
              if(pickerVisible)Padding(
                padding: const EdgeInsets.all(8.0),
                child: SfDateRangePicker(
                  onSelectionChanged:(DateRangePickerSelectionChangedArgs args){
                    if (args.value is PickerDateRange) {
                      this.setState(() {
                        var value =args.value as PickerDateRange;
                        startDate=value.startDate!;
                        endDate=value.endDate!;
                      });

                    }
                  },
                  selectionMode: DateRangePickerSelectionMode.range,
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Purchase Details',
                  style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 16,
                      fontWeight: FontWeight.w900),
                ),
              ),
              StreamBuilder(key: Key(startDate.toString()+endDate.toString()+"a"),builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if(!snapshot.hasData) return Container(
                  margin: EdgeInsets.all(16),
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade200,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(child: CircularProgressIndicator(color: Colors.white,),),
                );

                int cash=0;
                int credit=0;
                for(DataSnapshot snap in snapshot.data!.snapshot.children){
                  BillModel model=BillModel.fromMap(snap.value as Map);
                  DateTime date=DateTime.parse(model.date);
                 if(compareRange(date, startDate, endDate)) {
                    if (model.type == 'Cash') {
                      cash += model.total;
                    } else {
                      credit += model.total;
                    }
                  }
                }


                return Container(
                  margin: EdgeInsets.all(16),
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade200,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const SizedBox(height: 16,),
                            const Text('Credit',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                            Text('$credit',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24),),
                            const Text('Cash',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                            Text('$cash',style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24),),
                            const SizedBox(height: 16,),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        width: 2,
                        margin: EdgeInsets.only(top: 16,bottom: 16),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text('Total',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                            Text('${cash+credit}',style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24),),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },stream: FirebaseDatabase.instance.ref('bills').child(FirebaseAuth.instance.currentUser!.uid).orderByChild('userType').equalTo('suppliers').onValue),
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Sell Details',
                  style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 16,
                      fontWeight: FontWeight.w900),
                ),
              ),
              StreamBuilder(key: Key(startDate.toString()+endDate.toString()),builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if(!snapshot.hasData) {
                  return Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade200,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(child: CircularProgressIndicator(color: Colors.white,),),
                );
                }

                int cash=0;
                int credit=0;
                for(DataSnapshot snap in snapshot.data!.snapshot.children){
                  BillModel model=BillModel.fromMap(snap.value as Map);
                  DateTime date=DateTime.parse(model.date);
                 if(compareRange(date, startDate, endDate)) {
                    if (model.type == 'Cash') {
                      cash += model.total;
                    } else {
                      credit += model.total;
                    }
                  }
                }


                return Container(
                  margin: EdgeInsets.all(16),
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade200,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const SizedBox(height: 16,),
                            const Text('Credit',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                            Text('$credit',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24),),
                            const Text('Cash',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                            Text('$cash',style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24),),
                            const SizedBox(height: 16,),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        width: 2,
                        margin: EdgeInsets.only(top: 16,bottom: 16),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text('Total',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                            Text('${cash+credit}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24),),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },stream: FirebaseDatabase.instance.ref('bills').child(FirebaseAuth.instance.currentUser!.uid).orderByChild('userType').equalTo('customers').onValue),
              GestureDetector(
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> SupplierPage())),
                child: Container(
                  height: 60,
                  padding: EdgeInsets.only(left: 16),
                  width: double.infinity,
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.centerLeft,
                  child: const Text('View Suppliers',textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              ),
              GestureDetector(
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> CustomerPage())),
                child: Container(
                  height: 60,
                  padding: EdgeInsets.only(left: 16),
                  width: double.infinity,
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.centerLeft,
                  child: const Text('View Customers',textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              ),
              GestureDetector(
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> PricingPage())),
                child: Container(
                  height: 60,
                  padding: EdgeInsets.only(left: 16),
                  width: double.infinity,
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.centerLeft,
                  child: const Text('View Pricing',textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  bool compareRange(DateTime date,DateTime startDate,DateTime endDate){
    DateTime start=DateTime(startDate.year,startDate.month,startDate.day);
    DateTime end=DateTime(endDate.year,endDate.month,endDate.day);
    DateTime newDate=DateTime(date.year,date.month,date.day);
    return (newDate.isAfter(start)|| newDate.isAtSameMomentAs(start)) && (newDate.isBefore(end)|| newDate.isAtSameMomentAs(end));

  }
}

import 'package:flutter/material.dart';
import 'package:shop_management/screens/add_bill.dart';
import 'package:shop_management/screens/bill_screen.dart';
import 'package:shop_management/screens/edit_profile.dart';
import 'package:shop_management/screens/edit_supplier.dart';
import 'package:shop_management/screens/home_screen.dart';
class SupplierProfilePage extends StatefulWidget {
  const SupplierProfilePage({super.key});


  @override
  State<SupplierProfilePage> createState() => _SupplierProfilePageState();
}

class _SupplierProfilePageState extends State<SupplierProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(16),
                    child: Text(
                      'Supplier Profile', style: TextStyle(color: Colors.indigo,fontSize: 32,fontWeight: FontWeight.w900),
                    ),
                  ),
                  SizedBox(width: 16,),
                  GestureDetector(onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> EditSupplierPage())),child: Icon(Icons.edit)),
                ],
              ),
              SizedBox(height: 50,),
              Center(child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(200)),child: ClipRRect(borderRadius: BorderRadius.circular(200),child: Image.asset('shop_icon.png',height: 200,width: 200,)))),
              SizedBox(height: 25,),
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
              Container(
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
                          SizedBox(height: 16,),
                          Text('Credit',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                          Text('2,00,000',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24),),
                          Text('Cash',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                          Text('2,00,000',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24),),
                          SizedBox(height: 16,),
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
                          Text('Total',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                          Text('4,00,000',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Supplier Details',
                  style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 16,
                      fontWeight: FontWeight.w900),
                ),
              ),
              Container(
                margin: EdgeInsets.all(16),
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Name:\nNitin Dhavan',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                      Text('Phone:\n+919325508604',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                      Text('Address:\nAt post Nighoj Taluka Parner District Ahmednagar',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50,),

              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>BillPage()));
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        margin: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(child: Text('View Bills',style: TextStyle(color: Colors.white),)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddBillPage()));
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        margin: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(child: Text('Add Bill',style: TextStyle(color: Colors.white),)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
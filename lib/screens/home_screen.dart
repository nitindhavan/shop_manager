import 'package:flutter/material.dart';
import 'package:shop_management/screens/customer_screen.dart';
import 'package:shop_management/screens/pricing_screen.dart';
import 'package:shop_management/screens/profile_screen.dart';
import 'package:shop_management/screens/supplier_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                        onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage())),
                        child: Icon(Icons.person))
                  ],
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
                child: Center(
                  child: Text('Last 7 Days',style: TextStyle(fontWeight: FontWeight.bold),),
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
                  'Sell Details',
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
                  child: Text('View Suppliers',textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.bold),),
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
                  child: Text('View Customers',textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.bold),),
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
                  child: Text('View Pricing',textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

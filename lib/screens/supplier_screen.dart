import 'package:flutter/material.dart';
import 'package:shop_management/screens/add_supplier_page.dart';
import 'package:shop_management/screens/supplier_profile.dart';

class SupplierPage extends StatefulWidget {
  const SupplierPage({super.key});

  @override
  State<SupplierPage> createState() => _SupplierPageState();
}

class _SupplierPageState extends State<SupplierPage> {
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
                'Suppliers',
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
                      hintText: 'Search...',
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
                  onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> SupplierProfilePage())),
                  child: Container(
                    height: 60,
                    padding: EdgeInsets.only(left: 16),
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade200,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text('Supplier Number $index',textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                  ),
                );
              },itemCount: 200,),
            ),
            GestureDetector(
              onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterSupplierPage())),
              child: Container(
                height: 60,
                padding: EdgeInsets.only(left: 16),
                width: double.infinity,
                margin: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(blurRadius: 4,color: Colors.pink)]
                ),
                alignment: Alignment.center,
                child: Text('Add new Supplier',textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
              ),
            )
          ],
        ),
      ),
    );
  }
}

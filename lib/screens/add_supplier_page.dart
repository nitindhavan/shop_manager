import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shop_management/models/CustomerModel.dart';
import 'package:shop_management/screens/supplier_screen.dart';
class RegisterSupplierPage extends StatefulWidget {
  const RegisterSupplierPage({super.key});


  @override
  State<RegisterSupplierPage> createState() => _RegisterSupplierPageState();
}

class _RegisterSupplierPageState extends State<RegisterSupplierPage> {

  var name=TextEditingController();
  var phone=TextEditingController();
  var address=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(16),
                child: Text(
                  'Add Supplier', style: TextStyle(color: Colors.indigo,fontSize: 32,fontWeight: FontWeight.w900),
                ),
              ),
              SizedBox(height: 30,),
              Center(child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(200)),child: ClipRRect(borderRadius: BorderRadius.circular(200),child: Image.asset('shop_icon.png',height: 200,width: 200,)))),
              SizedBox(height: 30,),
              Column(
                children: [
                  Container(
                    height: 50,
                    padding: EdgeInsets.only(left: 16),
                    width: double.infinity,
                    margin: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.centerLeft,
                    child: TextField(controller: name,textAlign: TextAlign.start,style: TextStyle(color: Colors.white),cursorColor: Colors.white,decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Supplier Name',
                        hintStyle: TextStyle(color: Colors.white)
                    ),),
                  ),
                  Container(
                    height: 50,
                    padding: EdgeInsets.only(left: 16),
                    width: double.infinity,
                    margin: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.centerLeft,
                    child: TextField(controller: phone,textAlign: TextAlign.start,style: TextStyle(color: Colors.white),cursorColor: Colors.white,decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Supplier Phone',
                        hintStyle: TextStyle(color: Colors.white)
                    ),),
                  ),
                  Container(
                    height: 50,
                    padding: EdgeInsets.only(left: 16),
                    width: double.infinity,
                    margin: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.centerLeft,
                    child: TextField(controller: address,textAlign: TextAlign.start,style: TextStyle(color: Colors.white),cursorColor: Colors.white,decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Supplier Address',
                        hintStyle: TextStyle(color: Colors.white)
                    ),),
                  ),
                ],
              ),
              const SizedBox(height: 50,),
              GestureDetector(
                onTap: () async {
                  var ref=FirebaseDatabase.instance.ref("suppliers");
                  String key=ref.push().key!;
                  ref.child(key).set(CustomerModel(key, name.text, phone.text, address.text, FirebaseAuth.instance.currentUser!.uid).toMap()).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=> SupplierPage())));
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(child: Text('Save Supplier',style: TextStyle(color: Colors.white),)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
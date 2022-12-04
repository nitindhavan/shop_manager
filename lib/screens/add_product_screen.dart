import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shop_management/models/ProductModel.dart';
import 'package:shop_management/screens/home_screen.dart';
import 'package:shop_management/screens/pricing_screen.dart';
class RegisterProductPage extends StatefulWidget {
  const RegisterProductPage({super.key});

  @override
  State<RegisterProductPage> createState() => _RegisterProductPageState();
}

class _RegisterProductPageState extends State<RegisterProductPage> {

  var name=TextEditingController();
  var price=TextEditingController();

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
                  'Add Product', style: TextStyle(color: Colors.indigo,fontSize: 32,fontWeight: FontWeight.w900),
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
                        hintText: 'Enter Product Name',
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
                    child: TextField(controller: price,textAlign: TextAlign.start,style: TextStyle(color: Colors.white),cursorColor: Colors.white,decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Product Price',
                        hintStyle: TextStyle(color: Colors.white)
                    ),),
                  ),
                ],
              ),
              const SizedBox(height: 50,),
              GestureDetector(
                onTap: (){
                  var ref=FirebaseDatabase.instance.ref("products").child(FirebaseAuth.instance.currentUser!.uid);
                  String key=ref.push().key!;
                  ref.child(key).set(ProductModel(key, name.text, price.text).toMap()).then((value){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PricingPage()));
                  });
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(child: Text('Add Product',style: TextStyle(color: Colors.white),)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
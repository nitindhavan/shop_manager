import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shop_management/models/CustomerModel.dart';
import 'package:shop_management/screens/customer_screen.dart';
class EditCustomerPage extends StatefulWidget {
  const EditCustomerPage({super.key, required this.model});
  final CustomerModel model;


  @override
  State<EditCustomerPage> createState() => _EditCustomerPageState();
}

class _EditCustomerPageState extends State<EditCustomerPage> {

  var name=TextEditingController();
  var phone=TextEditingController();
  var address=TextEditingController();

  @override
  Widget build(BuildContext context) {
    name.text=widget.model.name;
    phone.text=widget.model.phone;
    address.text=widget.model.address;

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
                  'Edit Customer', style: TextStyle(color: Colors.indigo,fontSize: 32,fontWeight: FontWeight.w900),
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
                        hintText: 'Enter Customer Name',
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
                        hintText: 'Enter Customer Phone',
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
                    child: TextField(controller : address,textAlign: TextAlign.start,style: TextStyle(color: Colors.white),cursorColor: Colors.white,decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Customer Address',
                        hintStyle: TextStyle(color: Colors.white)
                    ),),
                  ),
                ],
              ),
              const SizedBox(height: 50,),
              GestureDetector(
                onTap: (){
                  widget.model.phone=phone.text;
                  widget.model.name=name.text;
                  widget.model.address=address.text;

                  FirebaseDatabase.instance.ref('customers').child(widget.model.UID).set(widget.model.toMap()).then((value){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> CustomerPage()));
                  });
                  //TODO pending implementaion here
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(child: Text('Save Customer',style: TextStyle(color: Colors.white),)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
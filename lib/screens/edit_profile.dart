import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shop_management/models/UserModel.dart';
import 'package:shop_management/screens/profile_screen.dart';
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.model});
  final UserModel model;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  var name=TextEditingController();
  var shopName=TextEditingController();

  @override
  Widget build(BuildContext context) {
    name.text=widget.model.name;
    shopName.text=widget.model.shopName;
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
                  'Edit Profile', style: TextStyle(color: Colors.indigo,fontSize: 32,fontWeight: FontWeight.w900),
                ),
              ),
              SizedBox(height: 50,),
              Center(child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(200)),child: ClipRRect(borderRadius: BorderRadius.circular(200),child: Image.asset('shop_icon.png',height: 200,width: 200,)))),
              SizedBox(height: 50,),
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
                        hintText: 'Enter Your Name',
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
                    child: TextField(controller : shopName,textAlign: TextAlign.start,style: TextStyle(color: Colors.white),cursorColor: Colors.white,decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Your Shop Name',
                        hintStyle: TextStyle(color: Colors.white)
                    ),),
                  ),
                ],
              ),
              SizedBox(height: 100,),

              GestureDetector(
                onTap: (){
                  widget.model.name=name.text;
                  widget.model.shopName=shopName.text;
                  FirebaseDatabase.instance.ref("users").child(widget.model.UID).set(widget.model.toMap()).then((value){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage(model: widget.model)));
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
                  child: Center(child: Text('Save',style: TextStyle(color: Colors.white),)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
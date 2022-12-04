import 'package:flutter/material.dart';
import 'package:shop_management/models/UserModel.dart';
import 'package:shop_management/screens/edit_profile.dart';
import 'package:shop_management/screens/home_screen.dart';
class ProfilePage extends StatefulWidget {
  ProfilePage({super.key, required this.model});
  final UserModel model;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

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
                  'Profile', style: TextStyle(color: Colors.indigo,fontSize: 32,fontWeight: FontWeight.w900),
                ),
              ),
              SizedBox(height: 50,),
              Center(child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(200)),child: ClipRRect(borderRadius: BorderRadius.circular(200),child: Image.asset('shop_icon.png',height: 200,width: 200,)))),
              SizedBox(height: 25,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Text('Name : \n\n${widget.model.name}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Text('Shop Name : \n\n${widget.model.shopName}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  )
                ],
              ),
              SizedBox(height: 50,),

              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfilePage(model: widget.model)));
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(child: Text('Edit Profile',style: TextStyle(color: Colors.white),)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
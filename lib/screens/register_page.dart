import 'package:flutter/material.dart';
import 'package:shop_management/screens/home_screen.dart';
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});


  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

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
                  'Register', style: TextStyle(color: Colors.indigo,fontSize: 32,fontWeight: FontWeight.w900),
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
                    child: TextField(textAlign: TextAlign.start,style: TextStyle(color: Colors.white),cursorColor: Colors.white,decoration: InputDecoration(
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
                    child: TextField(textAlign: TextAlign.start,style: TextStyle(color: Colors.white),cursorColor: Colors.white,decoration: InputDecoration(
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(child: Text('Register',style: TextStyle(color: Colors.white),)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
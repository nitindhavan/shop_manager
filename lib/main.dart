import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_management/models/UserModel.dart';
import 'package:shop_management/screens/home_screen.dart';
import 'package:shop_management/screens/login_page.dart';
import 'package:shop_management/screens/register_page.dart';

import 'DefaultFirebaseOptions.dart';

void main() async{
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.indigo, // navigation bar color
    statusBarColor: Colors.indigo, // status bar color
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    navigate();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () async {

              },
              child: Container(
                margin: EdgeInsets.only(top: 200),
                child: Text(
                  'Shop Manager', style: TextStyle(color: Colors.indigo,fontSize: 40,fontWeight: FontWeight.w900),
                ),
              ),
            ),
            SizedBox(height: 24,),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Image.asset('shop_icon.png'),
            ),
          ],
        ),
      ),
    );
  }
  navigate()  {
    var auth=FirebaseAuth.instance;
    if(auth.currentUser==null) {
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => LoginPage()));
    }else{
      FirebaseDatabase.instance.ref("users").child(FirebaseAuth.instance.currentUser!.uid).once().then((value) {
        if(value.snapshot.value==null){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterPage()));
        }else {
          UserModel model = UserModel.fromMap(value.snapshot.value as Map);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage(userModel: model,)));
        }
      });

    }
  }
}

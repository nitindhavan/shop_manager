import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_management/screens/login_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.indigo, // navigation bar color
    statusBarColor: Colors.indigo, // status bar color
  ));
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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: (){
                  Navigator.push(context, new MaterialPageRoute(builder: (context)=> LoginPage()));
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
            )
          ],
        ),
      ),
    );
  }
}

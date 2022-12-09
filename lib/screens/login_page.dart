import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shop_management/screens/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 100),
              child: Text(
                'Shop Manager', style: TextStyle(color: Colors.indigo,fontSize: 40,fontWeight: FontWeight.w900),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Image.asset('shop_icon.png'),
            ),
            GestureDetector(
              onTap: () async {
                signup(context);
              },
              child: Container(
                height: 50,
                width: double.infinity,
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(child: Text('Continue with Google',style: TextStyle(color: Colors.white),)),
              ),
            )
          ],
        ),
      ),
    );
  }
  Future<void> signup(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // Getting users credential
      UserCredential result = await FirebaseAuth.instance.signInWithCredential(authCredential);
      User? user = result.user;

      if (result != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => RegisterPage()));
      }  // if result not null we simply call the MaterialpageRoute,
      // for go to the HomePage screen
    }
  }
}
import 'dart:ui';




import 'package:a/add_medicine.dart';
import 'package:a/dashboard.dart';
import 'package:a/delete_medicine.dart';
import 'package:a/login.dart';
import 'package:a/medicin_search.dart';

import 'package:a/rough.dart';
import 'package:a/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';


import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart'; // Make sure you have this package

void main() async{
  
WidgetsFlutterBinding.ensureInitialized();


 if(kIsWeb){
  
  await Firebase.initializeApp(options: FirebaseOptions(apiKey: "AIzaSyCd62QABlHU0bCyHPdJFVCEKj3uPuR32ZI",
  authDomain: "mbap-2b86e.firebaseapp.com",
  projectId: "mbap-2b86e",
  storageBucket: "mbap-2b86e.appspot.com",
  messagingSenderId: "1023866351522",
  appId: "1:1023866351522:web:633ef89b4412991b908cfb",
  measurementId: "G-LMLBDF3BGV"));
  
  }else{

   await Firebase.initializeApp();
  }
  
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home:MedicinSearch(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Color.fromARGB(255, 110, 102, 188), // Darker purple
                Colors.white, // Light center
              ],
              radius: 2,
              center: Alignment(2.8, -1.0),
              tileMode: TileMode.clamp,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 2.5,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/logo.png")),
                ),
              ),
              Column(
                children: <Widget>[
                  Text(
                    "Health Solution you can Trust",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Enter your detail to proceed further",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 24, 22, 22),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  // Loading animation above the Get Started button
                 
                    LoadingAnimationWidget.horizontalRotatingDots(
                      color: Colors.white,
                      size: 50, // You can adjust the size as needed
                  ),
                    SizedBox(height: 20), // Space between loading animation and button
                  

                  // Get Started button
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                      });

                      // Simulate a delay for loading
                      Future.delayed(Duration(seconds: 3), () {
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => LoginPage()));
                      });
                    },
                    color: Color.fromARGB(255, 110, 102, 188),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Color.fromARGB(255, 110, 102, 188),
                        ),
                        borderRadius: BorderRadius.circular(50)),
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  ),
                  // Sign in button
                  SizedBox(height: 20),
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupPage()));
                    },
                    color: Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Color.fromARGB(255, 133, 125, 213),
                        ),
                        borderRadius: BorderRadius.circular(50)),
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                          color: Color.fromARGB(255, 110, 102, 188),
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

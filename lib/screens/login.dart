import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:groceasy/constants.dart';
import 'package:groceasy/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:groceasy/screens/forgot.dart';
import 'package:groceasy/screens/sign.dart';
import 'package:groceasy/screens/forgot.dart';
import 'package:groceasy/screens/home.dart';
import 'package:groceasy/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  late SharedPreferences prefs;
  FocusNode myfocus = FocusNode();
  final formKey = GlobalKey<FormState>();
  TextEditingController passWordController = TextEditingController();
  final passwordFocusNode = FocusNode();
  TextEditingController emailController = TextEditingController();
  final emailFocusNode = FocusNode();
  String extractUsernameFromEmail(String email) {
    List<String> parts = email.split('@');
    if (parts.length == 2) {
      return parts[0];
    } else {
      throw FormatException('Invalid email format');
    }
  }

  void login() async {
    String password = passWordController.text.trim();
    email = emailController.text.trim();

    if (email == "" || password == "") {
      Fluttertoast.showToast(
          msg: 'Please fill all the fields',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Color(0xFFF3E5F5),
          textColor: Colors.black);
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        if (userCredential.user != null) {
          await prefs.setString("username", email);

          await prefs.setString('logged in', 'login');

          Fluttertoast.showToast(
              msg: 'Logged in successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Color(0xFFF3E5F5),
              textColor: Colors.black);

          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        }
      } on FirebaseAuthException catch (ex) {
        if (ex.code == 'INVALID_LOGIN_CREDENTIALS') {
          log(ex.code);
          Fluttertoast.showToast(
            msg: 'Invalid Login Credentials',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Color(0xFFF3E5F5),
            textColor: Colors.black,
          );
        }
      }
    }
  }

  var isObscured;
  @override
  void initState() {
    super.initState();
    isObscured = true;
    getter();
  }

  Future getter() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passWordController.dispose();
  }

  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Padding(
            padding: EdgeInsets.only(top:30),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('images/logo.png'),
                    height:140
                  ),

                  Container(
                    height: screenSize.height * 0.5,
                    width: screenSize.width * 0.8,
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Image.asset('images/student.png',height: 250,width: 250,),

                        Center(
                          child: Text('Sign In',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.white)),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          'E-Mail',style:TextStyle(color: Colors.white,fontSize: 20)
                        ),
                        ConstrainedBox(
                          constraints:
                              BoxConstraints.tight(const Size(365, 50)),
                          child: TextFormField(
                            style:TextStyle(color:Colors.white),
                            focusNode: emailFocusNode,
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              fillColor: Colors.white,
                              hintText: 'Enter your Email-Id',
                              hintStyle: TextStyle(color:Colors.white70),
                              icon: Icon(Icons.mail,color:Colors.white),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                emailFocusNode.requestFocus();
                                return 'Please enter an email';
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                            'Password',style:TextStyle(color: Colors.white,fontSize: 20)
                        ),
                        ConstrainedBox(
                          constraints:
                              BoxConstraints.tight(const Size(365, 50)),
                          child: TextFormField(
                            style:TextStyle(color:Colors.white),
                            obscureText: isObscured,
                            focusNode: passwordFocusNode,
                            keyboardType: TextInputType.visiblePassword,
                            controller: passWordController,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              hintText: 'Enter Your Password',
                              hintStyle: TextStyle(color:Colors.white70),
                              icon: Icon(Icons.lock,color:Colors.white),
                              suffixIcon: IconButton(
                                padding: EdgeInsetsDirectional.only(end: 12.0),
                                icon: isObscured
                                    ? Icon(Icons.visibility,color:Colors.white,)
                                    : Icon(Icons.visibility_off,color:Colors.white),
                                onPressed: () {
                                  setState(() {
                                    isObscured = !isObscured;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                passwordFocusNode.requestFocus();
                                return 'Please enter some text';
                              }
                              if (value.length < 6) {
                                passwordFocusNode.requestFocus();
                                return 'Password must be atleast 6 characters';
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:20.0),
                          child: TextButton(
                            style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all(Size(330,50)),
                                backgroundColor: MaterialStatePropertyAll<Color>(Color(0xFF00E676,),)),
                            onPressed: (){
                              login();
                            }, child: Text('Log In',style:TextStyle(color:Colors.white,fontSize: 17,fontWeight: FontWeight.bold)),),
                        ),

                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextButton(
                      style: ButtonStyle(
                        fixedSize:
                        MaterialStateProperty.all(Size(330, 50)),
                        backgroundColor: MaterialStatePropertyAll<Color>(
                          Color(0xFF00E676),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignScreen()),
                        );
                      },
                      child: Text('New User',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),

                  TextButton(
                    onPressed: (){

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotScreen()),
                      );
                    },
                    child: Text('Forgot Your Password ?',style: TextStyle(color: Colors.white,fontSize:18,fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:groceasy/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:groceasy/screens/login.dart';
import 'package:groceasy/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignScreen extends StatefulWidget {
  SignScreen({super.key});
  @override
  SignScreenState createState() => SignScreenState();
}

class SignScreenState extends State<SignScreen> {
  late SharedPreferences prefs;
  FocusNode myfocus = FocusNode();
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  final passwordFocusNode = FocusNode();
  TextEditingController emailController = TextEditingController();

  final emailFocusNode = FocusNode();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final addressFocusNode = FocusNode();

  final nameFocusNode = FocusNode();
  var isObscured;
  String extractUsernameFromEmail(String email) {
    List<String> parts = email.split('@');
    if (parts.length == 2) {
      return parts[0];
    } else {
      throw FormatException('Invalid email format');
    }
  }

  void createAccount() async {
    email = emailController.text.trim();
    name = nameController.text.trim();
    String password = passwordController.text.trim();
    address = addressController.text.trim();

    username = extractUsernameFromEmail(email);
    print('Username: $username');

    if (email == "" || password == "" || name == "") {
      Fluttertoast.showToast(
          msg: 'Please fill all the fields',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Color(0xFFF3E5F5),
          textColor: Colors.black);
    } else {
      try {
        await prefs.setString("address", address);

        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        Map<String, dynamic> newUserData = {
          "Email": "$email",
          "Password": "$password",
          "Address": "$address",
          "Name": "$name"
        };

        final doc = await FirebaseFirestore.instance
            .collection("Users")
            .add(newUserData);
        id = doc.id;
        log(id);
        if (userCredential.user != null) {
          Navigator.pop(context);
        }
        log("User created");
      } on FirebaseAuthException catch (ex) {
        if (ex.code == "weak-password") {
          //snackbar
        }
        log(ex.code.toString());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    isObscured = true;
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    addressController.dispose();
  }

  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height: screenSize.height,
            width: screenSize.width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: screenSize.height * 0.85,
                      child: FittedBox(
                        child: Container(
                          height: screenSize.height * 0.80,
                          width: screenSize.width * 0.8,
                          padding: EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                          ),
                          child: Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text('Sign Up',
                                        style: TextStyle(
                                            fontSize: 50,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                      'Name',style:TextStyle(color: Colors.white,fontSize: 18)
                                  ),
                                  ConstrainedBox(
                                    constraints: BoxConstraints.tight(
                                        const Size(365, 50)),
                                    child: TextFormField(
                                      style:TextStyle(color:Colors.white),
                                      focusNode: nameFocusNode,
                                      keyboardType: TextInputType.name,
                                      controller: nameController,
                                      decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                        ),
                                        fillColor: Colors.white,
                                        hintText: 'Enter your Name',
                                        hintStyle: TextStyle(color:Colors.white70),

                                        icon: Icon(Icons.person,color:Colors.white),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          nameFocusNode.requestFocus();
                                          return 'Please enter your name';
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                      'E-Mail',style:TextStyle(color: Colors.white,fontSize: 18)
                                  ),
                                  ConstrainedBox(
                                    constraints: BoxConstraints.tight(
                                        const Size(365, 50)),
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
                                        hintText: 'Enter your College Email-Id',
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
                                      'Password',style:TextStyle(color: Colors.white,fontSize: 18)
                                  ),
                                  ConstrainedBox(
                                    constraints: BoxConstraints.tight(
                                        const Size(365, 50)),
                                    child: TextFormField(
                                      style:TextStyle(color:Colors.white),
                                      obscureText: isObscured,
                                      focusNode: passwordFocusNode,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      controller: passwordController,
                                      decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                        ),
                                        hintText: 'Enter your Password',
                                        hintStyle: TextStyle(color:Colors.white70),

                                        icon: Icon(Icons.lock,color:Colors.white),
                                        suffixIcon: IconButton(
                                          padding: EdgeInsetsDirectional.only(
                                              end: 12.0),
                                          icon: isObscured
                                              ? Icon(Icons.visibility,color:Colors.white)
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
                                  SizedBox(height: 20),
                                  Text(
                                      'Address',style:TextStyle(color: Colors.white,fontSize: 18)
                                  ),
                                  ConstrainedBox(
                                    constraints: BoxConstraints.tight(
                                        const Size(365, 50)),
                                    child: TextFormField(
                                      style:TextStyle(color:Colors.white),
                                      focusNode: addressFocusNode,
                                      keyboardType: TextInputType.streetAddress,
                                      controller: addressController,
                                      decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white),
                                        ),
                                        fillColor: Colors.white,
                                        hintText: 'Enter your Address',
                                        hintStyle: TextStyle(color:Colors.white70),

                                        icon: Icon(Icons.add_location_alt,color:Colors.white),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          addressFocusNode.requestFocus();
                                          return 'Please enter your address';
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: TextButton(
                                      style: ButtonStyle(
                                        fixedSize: MaterialStateProperty.all(
                                            Size(330, 50)),
                                        backgroundColor:
                                            MaterialStatePropertyAll<Color>(
                                          Color(0xFF00E676),
                                        ),
                                      ),
                                      onPressed: () {
                                        createAccount();
                                        Fluttertoast.showToast(
                                            msg: 'Account created',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            backgroundColor: Color(0xFFF3E5F5),
                                            textColor: Colors.black);

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()),
                                        );
                                      },
                                      child: Text('Register',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

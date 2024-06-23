import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';
import 'dart:io';
import 'package:groceasy/constants.dart';
import 'package:groceasy/screens/login.dart';
import 'package:groceasy/widgets/ad_banner_widget.dart';
import 'package:groceasy/widgets/searchbar_widget.dart';


class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  ScrollController controller = ScrollController();
  double offset=0;
  List<Widget>? discount70;
  List<Widget>? discount60;
  List<Widget>? discount50;
  List<Widget>? discount0;


  String extractUsernameFromEmail(String email) {
    List<String> parts = email.split('@');
    if (parts.length == 2) {
      return parts[0];
    } else {
      throw FormatException('Invalid email format');
    }
  }

  // loadUserInfo() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   username = extractUsernameFromEmail(email);
  //   await prefs.setString("usernameM", username);
  //
  //   nameV.value = await FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc(id)
  //       .get()
  //       .then((value) {
  //     return value.get('Name');
  //   });
  //   log(nameV.value);
  //   addres.value=await FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc(id)
  //       .get()
  //       .then((value) {
  //     return value.get('Address');
  //   });
  // }

  void logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("logged in");
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  void initState() {
    super.initState();
      // loadUserInfo();
      controller.addListener(() {
        setState(() {
          // loadUserInfo();
          offset=controller.position.pixels;
        });

    });
  }

  Widget build(BuildContext context) {
    return
    Scaffold(
      appBar: SearchBarWidget(

      isReadOnly:true,
          hasBackButton:false,
      // appBar: AppBar(
      //   backgroundColor: Color(0xFF00E676),
      //   automaticallyImplyLeading: false,
      //   title: Center(
      //       child: Text(
      //     'Home',
      //     style: TextStyle(
      //         color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
      //   )),
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         logout();
      //       },
      //       icon: Icon(Icons.exit_to_app, color: Colors.white),
      //     ),
      //   ],
      ),
      body:SingleChildScrollView(

        scrollDirection: Axis.vertical,
        child:Column(
          children:[

            AdBannerWidget(),
            SizedBox(
              height:20
            ),
            Container(
              color:Colors.white30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                Text('Upto 50% Off ',style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                SizedBox(
                height:250,
                child:
                  ListView(
                  scrollDirection: Axis.horizontal,
                  children:[
                    Image.asset('images/foodgrains/oily.jpg',width:200),
                    Image.asset('images/foodgrains/oil.jpg',width:200),
                    Image.asset('images/foodgrains/images.jpg',width:200),
                    Image.asset('images/non-veg/venk.jpg',width:200),
                    Image.asset('images/non-veg/chick.jpg',width:200),
                    Image.asset('images/foodgrains/download.jpg',width:200),
                    Image.asset('images/foodgrains/front_image.jpg',width:200)
                  ]
                ),

            ),],),),
          SizedBox(
            height:30
          ),
          Container(
            color: Colors.white70,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                Text('Upto 30% Off ',style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
              SizedBox(
              height:250,
              child:ListView(
                scrollDirection: Axis.horizontal,
                children:[
                  Image.asset('images/Bakery/moz.jpg',width:200),
                  Image.asset('images/non-veg/yummy.jpg',width:130),
                  Image.asset('images/Beverages/paper.jpg',width:260),
                  Image.asset('images/Beverages/wag.jpg',width:200),
                  Image.asset('images/non-veg/chick.jpg',width:200),
                  Image.asset('images/Beverages/teat.jpg',width:200),
                  Image.asset('images/non-veg/yum.jpg',width:280),
                ]
              )
            ),],),
          ),
            SizedBox(
                height:30
            ),

            Container(
              color: Colors.white,
              child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                  Text('Upto 20% Off ',style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),SizedBox(
                  height:250,
                  child:ListView(
                      scrollDirection: Axis.horizontal,
                      children:[
                        Image.asset('images/packed/chow.jpg',width:160),
                        Image.asset('images/packed/bana.jpg',width:270),
                        Image.asset('images/packed/hers.jpg',width:270),
                        Image.asset('images/Beverages/wag.jpg',width:200),
                        Image.asset('images/foodgrains/download.jpg',width:200),
                        Image.asset('images/packed/dor.jpg',width:200)
                      ]
                  )
              ),],),
            ),
            SizedBox(
                height:30
            ),

            Container(
              color: Colors.white,
              child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                  Text('Explore ',style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),SizedBox(
                  height:250,
                  child:ListView(
                      scrollDirection: Axis.horizontal,
                      children:[
                        Image.asset('images/packed/bars.jpg',width:220),
                        Image.asset('images/packed/chocob.jpg',width:240),
                        Image.asset('images/packed/nood.jpg',width:215),
                        Image.asset('images/Beverages/bn.jpg',width:240),
                        Image.asset('images/Bakery/milk.jpg',width:230),
                        Image.asset('images/Bakery/pretzel.jpg',width:130)
                      ]
                  )
              ),],),
            )
          ],
        )
      )
    );
  }
}

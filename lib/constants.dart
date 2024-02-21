import 'package:get/get.dart';
import 'package:flutter/material.dart';

String email = "";
String username = "";
RxString nameV = "".obs;
RxInt rollNo = 0.obs;
RxString dept = "".obs;
RxInt year = 0.obs;
RxString sec = "".obs;
RxInt mobileV = 0.obs;
String name="";
String id="";
String address="";
RxString addres="".obs;

const double kAppBarHeight = 80;


const List<String> smallAds = [
  "https://m.media-amazon.com/images/I/11iTpTDy6TL._SS70_.png",
  "https://m.media-amazon.com/images/I/11dGLeeNRcL._SS70_.png",
  "https://m.media-amazon.com/images/I/11kOjZtNhnL._SS70_.png",
];

const List<String> largeAds = [
  "https://thumbs.dreamstime.com/b/grocery-food-store-shopping-basket-promotional-sale-banner-vector-illustration-198422214.jpg",
  "https://4.bp.blogspot.com/-XQS1UAYxhWM/Vsw7cjVzu-I/AAAAAAAAAA8/LZPVtDBfNsQ/s1600/banner2.jpg",
  "https://img.lovepik.com/free-template/20211027/lovepik-blue-halo-milk-sales-template-image_8912542_list.jpg",
  "https://static.vecteezy.com/system/resources/previews/001/072/259/non_2x/summer-sale-banner-with-fruit-vector.jpg",
  "https://thumbs.dreamstime.com/b/tortilla-chips-banner-ads-corn-flakes-splashing-cheese-sauce-d-illustration-tortilla-chips-banner-ads-159510964.jpg"
];

const List<String> adItemNames = ["Recharge", "Rewards", "Pay Bills"];




// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:infinity_box/constant/color.dart';
import 'package:infinity_box/controller/getx_controller.dart';
import 'package:infinity_box/screeen/cart_list.dart';
import 'package:infinity_box/widgets/shimmer_effect.dart';
import 'package:like_button/like_button.dart';
import '../services/product_service.dart';

class ProductDetailsScreen extends StatelessWidget {
  int id;
  ProductDetailsScreen({super.key, required this.id});
  final MyController c = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: maincolor,
        title: Text(
          "Products",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartList()));
              },
              icon: Icon(
                CupertinoIcons.cart_badge_plus,
              ))
        ],
      ),
      body: FutureBuilder(
        future: ProductService().getDetailsProducts(id),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Image.network(snapshot.data['image'], height: 300),
                ),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 30, bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                snapshot.data['category'],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              LikeButton()
                              // Icon(Icons.favorite_outline_outlined,
                              //     color: maincolor, size: 28),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RatingBar.builder(
                                initialRating: 4,
                                maxRating: 1,
                                direction: Axis.horizontal,
                                itemCount: 5,
                                itemSize: 25,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 2),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: maincolor,
                                ),
                                onRatingUpdate: (index) {},
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      c.decrement();
                                    },
                                    child: Container(
                                      child: Icon(Icons.remove),
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 3,
                                            blurRadius: 10,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Obx(
                                      () => Text(
                                        "${c.products.toString()}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF475269)),
                                      ),
                                    ),
                                  ),
                                  //  addProduct(icon: CupertinoIcons.plus),
                                  // IconButton(
                                  //     onPressed: () {}, icon: Icon(Icons.add))
                                  InkWell(
                                    onTap: () {
                                      c.increment();
                                    },
                                    child: Container(
                                      child: Icon(Icons.add),
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 3,
                                            blurRadius: 10,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 30),
                          child: Text(
                            snapshot.data['description'],
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        SizedBox(height: 65),
                        Container(
                          height: 60,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                  offset: Offset(0, 3)),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$ ${snapshot.data['price'].toString()}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: maincolor,
                                ),
                              ),
                              ElevatedButton.icon(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Color.fromRGBO(215, 19, 101, 1),
                                  ),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6))),
                                ),
                                onPressed: () {},
                                icon: Icon(
                                  CupertinoIcons.cart_badge_plus,
                                  color: Colors.white,
                                  size: 22,
                                ),
                                label: Text(
                                  "Add To Cart",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return ShimmerEffect();
        },
      ),
    );
  }
}

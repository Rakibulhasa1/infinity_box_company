// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinity_box/constant/color.dart';
import 'package:infinity_box/screeen/cart_list.dart';
import '../model/product_view_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ProductViewModel productViewModel = Get.put(ProductViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: maincolor,
          title: Obx(
            () =>
                Text("Total Price: " + productViewModel.totalPrice.toString()),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartList()));
              },
              child: Container(
                padding: EdgeInsets.only(right: 18),
                child: Row(
                  children: <Widget>[
                    Badge(
                        badgeColor: Colors.green,
                        badgeContent: Obx(() => Text(
                              productViewModel.count.toString(),
                              style: TextStyle(color: Colors.white),
                            )),
                        child: Icon(Icons.shopping_cart)),
                  ],
                ),
              ),
            )
          ],
        ),
        body: Obx(() => productViewModel.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                margin: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: TextField(
                        decoration:
                            InputDecoration(hintText: 'Search here....'),
                        onChanged: (value) {
                          productViewModel.onTextChanged(value);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: productViewModel.searchList.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: 80,
                                  width: 70,
                                  child: Image.network(productViewModel
                                      .searchList[index].image!),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    child: Text(
                                      productViewModel.searchList[index].title!,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  child: Text(
                                    "Rs." +
                                        productViewModel
                                            .searchList[index].price!
                                            .toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Obx(() => productViewModel.cartList.contains(
                                        productViewModel.searchList[index])
                                    ? ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: maincolor),
                                        onPressed: () {
                                          productViewModel.removeFromCart(
                                              productViewModel
                                                  .searchList[index]);
                                        },
                                        child: Text("Remove from cart"))
                                    : ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: maincolor),
                                        onPressed: () {
                                          productViewModel.addToCart(
                                              productViewModel
                                                  .searchList[index]);
                                        },
                                        child: Text("Add to cart"))),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            );
                          }),
                    ),
                  ],
                ))));
  }
}

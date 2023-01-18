// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinity_box/constant/color.dart';
import 'package:infinity_box/screeen/search_screen.dart';

import '../controller/getx_controller.dart';
import '../model/product_view_model.dart';

class CartList extends StatefulWidget {
  CartList({super.key});
  ProductViewModel productViewModel = Get.put(ProductViewModel());
  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  final MyController c = Get.put(MyController());
  ProductViewModel productViewModel = Get.put(ProductViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: maincolor,
        title: Text("My Cart"),
        actions: [
          InkWell(
            onTap: () {
              productViewModel.clearCart();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchScreen()));
            },
            child: Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.center,
              child: Text("Clear All"),
            ),
          )
        ],
      ),
      body: Obx(() => Stack(
            children: [
              ListView.builder(
                  itemCount: productViewModel.cartList.length,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 50,
                                  width: 50,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      image: DecorationImage(
                                          image: NetworkImage(productViewModel
                                              .cartList[index].image!))),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          productViewModel
                                              .cartList[index].title!,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "Rs." +
                                              productViewModel
                                                  .productList[index].price!
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    productViewModel.removeFromCart(
                                        productViewModel.cartList[index]);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.delete_outline_sharp,
                                      color: maincolor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Divider(),
                          ],
                        ));
                  }),
              Positioned(
                bottom: 100,
                child: Card(
                  color: maincolor,
                  child: Container(
                      padding: EdgeInsets.all(16),
                      child: Obx(() => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "${productViewModel.count} products available",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "Total Price: Rs.${productViewModel.totalPrice}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ))),
                ),
              )
            ],
          )),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: maincolor,
          onPressed: () {},
          label: Text("Checkout")),
    );
  }
}

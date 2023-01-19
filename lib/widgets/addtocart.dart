import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/color.dart';
import '../model/product_view_model.dart';

class AddToCart extends StatelessWidget {
  AddToCart({super.key});

  ProductViewModel productViewModel = Get.put(ProductViewModel());

  @override
  Widget build(BuildContext context) {
    return Obx(() => productViewModel.isLoading.value
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            margin: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Container(
                //   child: TextField(
                //     decoration: InputDecoration(hintText: 'Search here....'),
                //     onChanged: (value) {
                //       productViewModel.onTextChanged(value);
                //     },
                //   ),
                // ),
                // SizedBox(
                //   height: 16,
                // ),
                Expanded(
                  child: ListView.builder(
                      itemCount: productViewModel.searchList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Container(
                            //   height: 80,
                            //   width: 70,
                            //   child: Image.network(productViewModel
                            //       .searchList[index].image!),
                            // ),
                            // GestureDetector(
                            //   onTap: () {},
                            //   child: Container(
                            //     child: Text(
                            //       productViewModel.searchList[index].title!,
                            //       style: TextStyle(
                            //           fontSize: 15,
                            //           color: Colors.black,
                            //           fontWeight: FontWeight.w600),
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 5,
                            // ),
                            // Container(
                            //   child: Text(
                            //     "Rs." +
                            //         productViewModel.searchList[index].price!
                            //             .toString(),
                            //     style: TextStyle(
                            //         fontSize: 16, fontWeight: FontWeight.bold),
                            //   ),
                            // ),
                            Obx(() =>
                                // productViewModel.cartList.contains(
                                //         productViewModel.searchList[index])
                                //     ? ElevatedButton(
                                //         style: ElevatedButton.styleFrom(
                                //             backgroundColor: maincolor),
                                //         onPressed: () {
                                //           productViewModel.removeFromCart(
                                //               productViewModel.searchList[index]);
                                //         },
                                //         child: Text("Remove from cart"))
                                //     :
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: maincolor),
                                    onPressed: () {
                                      productViewModel.addToCart(
                                          productViewModel.searchList[index]);
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
            )));
  }
}

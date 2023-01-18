// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinity_box/constant/color.dart';
import 'package:infinity_box/screeen/cart_list.dart';
import 'package:infinity_box/screeen/product_details_screen.dart';
import 'package:infinity_box/screeen/search_screen.dart';
import 'package:infinity_box/widgets/shimmer_effect.dart';

import '../model/product_view_model.dart';
import '../services/product_service.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({
    super.key,
  });

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  ProductViewModel productViewModel = Get.put(ProductViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 240, 240),
      appBar: AppBar(
        elevation: 5,
        backgroundColor: maincolor,
        title: Text(
          "Infinity Box",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              },
              icon: Icon(
                CupertinoIcons.search,
              )),
          InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CartList()));
            },
            child: Container(
              padding: EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  Icon(Icons.shopping_cart),
                  Obx(() => Text(productViewModel.count.toString()))
                ],
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: FutureBuilder(
          future: ProductService().getProducts(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProductDetailsScreen(
                                  id: snapshot.data[index]['id'],
                                )));
                      },
                      child: Column(
                        children: [
                          SizedBox(height: 15),
                          Image.network(snapshot.data[index]['image'],
                              width: 85),
                          Expanded(child: Container()),
                          Text(
                            snapshot.data[index]['category'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "\$ ${snapshot.data[index]['price'].toString()}",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: maincolor),
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return ShimmerEffect();
            //
            // Center(
            //     child: CircularProgressIndicator(
            //   color: maincolor,
            // ));
          },
        ),
      ),
    );
  }
}

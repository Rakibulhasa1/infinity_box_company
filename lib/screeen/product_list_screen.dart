// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinity_box/constant/color.dart';
import 'package:infinity_box/screeen/product_details_screen.dart';
import 'package:infinity_box/screeen/search_screen.dart';
import 'package:infinity_box/widgets/shimmer_effect.dart';

import '../services/product_service.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({
    super.key,
  });

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
          IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.cart_badge_plus,
                size: 26,
              ))
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
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 5,
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
                              width: 65),
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

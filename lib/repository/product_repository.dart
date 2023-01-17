import 'package:http/http.dart' as http;

import '../model/product_model.dart';

class ProductRepository {
  String BASE_URL = "https://fakestoreapi.com/products";
  static var client = http.Client();

  Future<List<ProductModel>?> fetchProducts() async {
    var response = await client.get(Uri.parse(BASE_URL));
    if (response.statusCode == 200) {
      return productModelFromJson(response.body);
    } else {
      return null;
    }
  }
}

import 'package:get/get.dart';

class MyController extends GetxController {
  var products = 0.obs;
  var addtocart = 0.obs;

  int get totalitem => products.value + addtocart.value;

  increment() {
    products.value++;
  }

  decrement() {
    if (products.value <= 0) {
    } else {
      products.value--;
    }
  }

  addtocard() {}
}

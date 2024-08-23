import 'package:food_cart_app/data/entity/cart_foods.dart';
import 'package:food_cart_app/data/entity/foods.dart';

class CartFoodsResult {
  List<CartFoods> cartFoods;
  int success;

  CartFoodsResult({required this.cartFoods, required this.success});

  factory CartFoodsResult.fromJson(Map<String,dynamic> json) {
    var jsonArray = json["sepet_yemekler"] as List;
    var success = json["success"] as int;

    var cartFoods = jsonArray.map((jsonArrayObject) => CartFoods.fromJson(jsonArrayObject)).toList();

    return CartFoodsResult(cartFoods: cartFoods, success: success);
  }
}

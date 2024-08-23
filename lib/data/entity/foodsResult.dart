import 'package:food_cart_app/data/entity/foods.dart';

class FoodsResult {
  List<Foods> foods;
  int success;

  FoodsResult({required this.foods, required this.success});

  factory FoodsResult.fromJson(Map<String,dynamic> json) {
    var jsonArray = json["yemekler"] as List;
    var success = json["success"] as int;

    var foods = jsonArray.map((jsonArrayObject) => Foods.fromJson(jsonArrayObject)).toList();

    return FoodsResult(foods: foods, success: success);
  }
}
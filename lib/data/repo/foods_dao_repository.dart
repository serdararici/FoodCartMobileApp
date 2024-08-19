import 'package:food_cart_app/data/entity/foods.dart';

class FoodsDaoRepository {

  Future<List<Foods>> getFoods() async {
    var foodList = <Foods>[];
    var f1 = Foods(food_id: 1, food_name: "Ayran", food_image: "ayran", food_price: 15);
    var f2 = Foods(food_id: 2, food_name: "Döner", food_image: "doner", food_price: 200);
    var f3 = Foods(food_id: 3, food_name: "Lahmacun", food_image: "lahmacun", food_price: 85);
    foodList.add(f1);
    foodList.add(f2);
    foodList.add(f3);
    return foodList;
  }
}
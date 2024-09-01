import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:food_cart_app/data/entity/cart_foods.dart';
import 'package:food_cart_app/data/entity/cart_foods_result.dart';
import 'package:food_cart_app/data/entity/foods.dart';
import 'package:food_cart_app/data/entity/foodsResult.dart';

class FoodsDaoRepository {

  List<Foods> parseFoods(String response) {
    return FoodsResult.fromJson(json.decode(response)).foods;
  }

  List<CartFoods> parseFoodsFromCart(String response) {
    if (response.isEmpty || response.trim() == "") {
      // Boş yanıt durumunu ele al
      return [];
    }
    return CartFoodsResult.fromJson(json.decode(response)).cartFoods;
  }

  Future<void> addFoods(String foodName, String foodImage, int foodPrice, int foodQuantity, String userName) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
    var data = {"yemek_adi":foodName ,
      "yemek_resim_adi":foodImage, "yemek_fiyat":foodPrice,
      "yemek_siparis_adet":foodQuantity, "kullanici_adi":userName};
    var result = await Dio().post(url,data: FormData.fromMap(data));
    print("Added to cart: ${result.data.toString()}");
  }

  //arama işleminin benzeri //username ile alıcaz
  Future<List<CartFoods>> getFoodsFromCart(String userName) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var data = {"kullanici_adi": userName };
    var result = await Dio().post(url,data: FormData.fromMap(data));
    if (result.data != null && result.data.toString().isNotEmpty) {
      print("Response data: ${result.data.toString()}");
      return parseFoodsFromCart(result.data.toString());
    } else {
      print("No data received or data is empty.");
      return []; // Boş liste döndür
    }
  }

  Future<List<Foods>> searchFoods(String searchingWord) async {
    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var result = await Dio().get(url);
    List<Foods> allFoods = parseFoods(result.data.toString());

    // Arama kelimesine göre filtreleme
    List<Foods> filteredFoods = allFoods.where((food) {
      return food.food_name.toLowerCase().contains(searchingWord.toLowerCase());
    }).toList();

    return filteredFoods;
  }


  Future<void> deleteFoodsFromCart(int cartFoodId, String userName) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var data = {"sepet_yemek_id":cartFoodId, "kullanici_adi": userName };
    var result = await Dio().post(url,data: FormData.fromMap(data));
    print("Removed from cart: ${result.data.toString()}");

  }

  Future<void> clearCart(List<CartFoods> foodList, String userName) async {
    for (var food in foodList) {
      await deleteFoodsFromCart(food.food_cart_id, userName);
    }
  }



  Future<List<Foods>> getFoods() async {

    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var result = await Dio().get(url);
    return parseFoods(result.data.toString());

    /*var foodList = <Foods>[];
    var f1 = Foods(food_id: 1, food_name: "Ayran", food_image: "ayran", food_price: 15);
    var f2 = Foods(food_id: 2, food_name: "Döner", food_image: "doner", food_price: 200);
    var f3 = Foods(food_id: 3, food_name: "Lahmacun", food_image: "lahmacun", food_price: 85);
    foodList.add(f1);
    foodList.add(f2);
    foodList.add(f3);
    return foodList;*/
  }


}
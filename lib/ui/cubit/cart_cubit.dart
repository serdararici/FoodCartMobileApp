import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_cart_app/data/entity/cart_foods.dart';
import 'package:food_cart_app/data/entity/foods.dart';
import 'package:food_cart_app/data/repo/foods_dao_repository.dart';

class CartCubit extends Cubit<List<CartFoods>>{
  CartCubit():super(<CartFoods>[]);

  var frepo = FoodsDaoRepository();

  Future<void> getFoodsFromCart(String userName) async {
    var list = await frepo.getFoodsFromCart(userName);
    emit(list);
  }

  Future<void> deleteFoodsFromCart(int cartFoodId, String userName) async {
    await frepo.deleteFoodsFromCart(cartFoodId, userName);
    await getFoodsFromCart(userName);
  }

  Future<void> clearCart(String userName) async {
    await frepo.clearCart(state, userName);
    emit([]); // Sepet temizlendi, durumu boş olarak ayarlıyoruz.
  }

  int calculateTotalPrice(List<CartFoods> foodList) {
    int total = 0;
    for (var food in foodList) {
      var price = food.food_price; // food_price'ı int'e çevir
      var quantity = food.food_quantity; // food_quantity'ı int'e çevir
      total += price * quantity; // Toplam fiyatı hesapla
    }
    return total;
  }


}
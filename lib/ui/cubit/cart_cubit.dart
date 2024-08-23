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


}
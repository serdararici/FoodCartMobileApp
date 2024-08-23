import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_cart_app/data/repo/foods_dao_repository.dart';

class FoodDetailsCubit extends Cubit<void>{
  var frepo = FoodsDaoRepository();

  FoodDetailsCubit():super(0);

  Future<void> addFoods(String foodName, String foodImage, int foodPrice, int foodQuantity, String userName) async {
    await frepo.addFoods(foodName, foodImage, foodPrice, foodQuantity, userName);
  }

}
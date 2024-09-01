import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_cart_app/data/entity/foods.dart';
import 'package:food_cart_app/data/repo/foods_dao_repository.dart';

class MainpageCubit extends Cubit<List<Foods>>{
  MainpageCubit():super(<Foods>[]);

  var frepo = FoodsDaoRepository();
  
  Future<void> getFoods() async {
    var list = await frepo.getFoods();
    emit(list);
  }

  Future<void> searchFoods(String searchingWord) async {
    var list = await frepo.searchFoods(searchingWord);
    emit(list);
  }

  Future<void> addFoods(String foodName, String foodImage, int foodPrice, int foodNumbers, String userName) async {
    await frepo.addFoods(foodName, foodImage, foodPrice, foodNumbers, userName);
  }

}
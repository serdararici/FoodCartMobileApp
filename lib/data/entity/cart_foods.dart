class CartFoods {
  int food_cart_id;
  String food_name;
  String food_image;
  int food_price;
  int food_order_number;
  String user_name;

  CartFoods(
      {required this.food_cart_id,
        required this.food_name,
        required this.food_image,
        required this.food_price,
        required this.food_order_number,
        required this.user_name});
}
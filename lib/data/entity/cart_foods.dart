class CartFoods {
  int food_cart_id;
  String food_name;
  String food_image;
  int food_price;
  int food_quantity;
  String user_name;

  CartFoods(
      {required this.food_cart_id,
        required this.food_name,
        required this.food_image,
        required this.food_price,
        required this.food_quantity,
        required this.user_name});

  factory CartFoods.fromJson(Map<String,dynamic> json) {
    return CartFoods(
        food_cart_id: int.parse(json["sepet_yemek_id"]),
        food_name: json["yemek_adi"],
        food_image: json["yemek_resim_adi"],
        food_price: int.parse(json["yemek_fiyat"]),
        food_quantity: int.parse(json["yemek_siparis_adet"]),
        user_name: json["kullanici_adi"]
    );
  }
}
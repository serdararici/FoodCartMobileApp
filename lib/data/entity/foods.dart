
class Foods {
  int food_id;
  String food_name;
  String food_image;
  int food_price;

  Foods({required this.food_id, required this.food_name, required this.food_image, required this.food_price});

  factory Foods.fromJson(Map<String,dynamic> json) {
    return Foods(
        food_id: int.parse(json["yemek_id"]),
        food_name: json["yemek_adi"],
        food_image: json["yemek_resim_adi"],
        food_price: int.parse(json["yemek_fiyat"])
    );
  }

}
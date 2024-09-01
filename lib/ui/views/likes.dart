import 'package:flutter/material.dart';
import 'package:food_cart_app/colors.dart';
import 'package:food_cart_app/data/entity/foods.dart';

class Likes extends StatefulWidget {
  final List<Foods> favoriteFoods;
  final void Function(Foods food) onRemoveFromFavorites;

  const Likes({
    super.key,
    required this.favoriteFoods,
    required this.onRemoveFromFavorites,
  });

  @override
  _LikesState createState() => _LikesState();
}

class _LikesState extends State<Likes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Beğeniler",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Pacifico",
            fontSize: 22,
          ),
        ),
        backgroundColor: mainColor,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: widget.favoriteFoods.isEmpty
          ? const Center(child: Text('Favori yemekleriniz bulunmuyor.'))
          : ListView.builder(
        itemCount: widget.favoriteFoods.length,
        itemBuilder: (context, index) {
          var food = widget.favoriteFoods[index];
          bool isFavorite = true;

          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            child: Card(
              elevation: 4.0,
              child: Row(
                children: [
                  // Resim
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    child: Image.network(
                      "http://kasimadalan.pe.hu/yemekler/resimler/${food.food_image}",
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // İçerik
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Yemek adı
                          Text(
                            food.food_name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          // Fiyat
                          Text(
                            '${food.food_price} ₺',
                            style: TextStyle(
                              color: mainColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Kalp simgesi
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        isFavorite = !isFavorite; // Butona basıldığında favori durumu değişir
                      });
                      widget.onRemoveFromFavorites(food);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

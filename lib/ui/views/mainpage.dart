import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_cart_app/colors.dart';
import 'package:food_cart_app/data/entity/foods.dart';
import 'package:food_cart_app/ui/cubit/mainpage_cubit.dart';
import 'package:food_cart_app/ui/views/cart.dart';
import 'package:food_cart_app/ui/views/likes.dart';
import 'package:food_cart_app/ui/views/food_details.dart';
import 'package:food_cart_app/ui/views/profile.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  List<Foods> favoriteFoods = [];

  @override
  void initState() {
    super.initState();
    context.read<MainpageCubit>().getFoods();
  }

  void _toggleFavorite(Foods food) {
    setState(() {
      if (favoriteFoods.contains(food)) {
        favoriteFoods.remove(food);
      } else {
        favoriteFoods.add(food);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Yemek Sepeti",
          style: TextStyle(color: Colors.white, fontFamily: "Pacifico", fontSize: 22),
        ),
        backgroundColor: mainColor,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Likes(favoriteFoods: favoriteFoods, onRemoveFromFavorites: _toggleFavorite),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<MainpageCubit, List<Foods>>(
              builder: (context, foodList) {
                if (foodList.isNotEmpty) {
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                    ),
                    itemCount: foodList.length,
                    itemBuilder: (context, index) {
                      var food = foodList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FoodDetails(food: food)),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: FoodCard(
                            food: food,
                            isFavorite: favoriteFoods.contains(food),
                            onFavoriteToggle: () => _toggleFavorite(food),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          SizedBox(height: 32.0), // Alt boşluk eklemek için bu SizedBox'u kullanıyoruz
        ],
      ),
      floatingActionButton: SizedBox(
        width: 70.0, // Genişlik
        height: 70.0, // Yükseklik
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Cart()),
            );
          },
          backgroundColor: mainColor,
          child: Icon(Icons.shopping_cart, color: Colors.white, size: 30), // İkonun boyutu
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: Colors.white,
        elevation: 9.8,
        shadowColor: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start, // Butonları sola hizala
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              color: mainColor,
              onPressed: () {
                // Anasayfa işlemi burada olacak
              },
            ),
            SizedBox(width: 64), // Butonlar arasında boşluk bırakma
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Likes(favoriteFoods: favoriteFoods, onRemoveFromFavorites: _toggleFavorite),
                  ),
                );
              },
            ),
            SizedBox(width: 64), // Butonlar arasında boşluk bırakma
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()), // Profil sayfası ekleyin
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FoodCard extends StatelessWidget {
  final Foods food;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const FoodCard({
    super.key,
    required this.food,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.network(
                "http://kasimadalan.pe.hu/yemekler/resimler/${food.food_image}",
                height: 100,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Text(
                      food.food_name,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        '${food.food_price} ₺',
                        style: TextStyle(color: mainColor, fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: CircleBorder(),
                      ),
                      onPressed: () {
                        // Sepete ekleme işlemi burada olacak

                      },
                      child: Icon(Icons.add, color: mainColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: onFavoriteToggle,
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                color: isFavorite ? Colors.red : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

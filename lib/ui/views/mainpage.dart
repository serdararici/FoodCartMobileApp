import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_cart_app/colors.dart';
import 'package:food_cart_app/data/entity/foods.dart';
import 'package:food_cart_app/ui/cubit/mainpage_cubit.dart';
import 'package:food_cart_app/ui/views/cart.dart';
import 'package:food_cart_app/ui/views/likes.dart';
import 'package:food_cart_app/ui/views/product_details.dart';
import 'package:food_cart_app/ui/views/profile.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<MainpageCubit>().getFoods();
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
                MaterialPageRoute(builder: (context) => Likes()),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<MainpageCubit,List<Foods>>(
        //future: getFoods(),
        builder: (context, foodList) {
          if (foodList.isNotEmpty) {
            //var foodList = foodList.data!;
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
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(food: food)));
                  },
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset('assets/images/${food.food_image}.png', height: 100, fit: BoxFit.cover),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                food.food_name,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  '${food.food_price} ₺',
                                  style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 20),
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
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } /*else if (foodList.hasError) {
            return Center(child: Text('Bir hata oluştu.'));
          }*/ else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Cart()),
          );
        },
        backgroundColor: mainColor,
        child: Icon(Icons.shopping_cart, color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
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
              icon: Icon(Icons.favorite,color: Colors.grey,),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Likes()),
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

import 'package:flutter/material.dart';
import 'package:food_cart_app/data/entity/foods.dart';
import 'package:food_cart_app/ui/views/cart.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  Future<List<Foods>> getFoods() async {
    var foodList = <Foods>[];
    var f1 = Foods(food_id: 1, food_name: "Ayran", food_image: "ayran", food_price: 15);
    var f2 = Foods(food_id: 2, food_name: "Döner", food_image: "doner", food_price: 200);
    var f3 = Foods(food_id: 3, food_name: "Lahmacun", food_image: "lahmacun", food_price: 85);
    foodList.add(f1);
    foodList.add(f2);
    foodList.add(f3);
    return foodList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Yemek Sepeti",
          style: TextStyle(color: Colors.white, fontFamily: "Pacifico", fontSize: 22),
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: FutureBuilder<List<Foods>>(
        future: getFoods(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var foodList = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: foodList.length,
              itemBuilder: (context, index) {
                var food = foodList[index];
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/${food.food_image}.png', height: 100, fit: BoxFit.cover),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          food.food_name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '₺${food.food_price}',
                          style: TextStyle(color: Colors.redAccent),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          onPressed: () {
                            // Sepete ekleme işlemi burada olacak
                          },
                          child: Icon(Icons.add, color: Colors.redAccent),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Bir hata oluştu.'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Sepet sayfasına gitme işlemi burada olacak
        },
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.shopping_cart,color: Colors.white,),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0),),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Anasayfa'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Beğeniler'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          ],
          selectedItemColor: Colors.redAccent,
        ),
      ),
    );
  }
}

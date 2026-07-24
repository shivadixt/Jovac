import 'package:flutter/material.dart';

class FoodMenu extends StatelessWidget {
  const FoodMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Food Menu"), backgroundColor: Colors.green),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Card(
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                leading: Image.asset("assets/images/Cheese_Burger.webp", width: 50,),
                //leading: Icon(Icons.person, size: 40, color: Colors.orange),
                title: Text("Cheese Burger", style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
                subtitle: Text("₹149"),
                trailing: Icon(Icons.shopping_cart, color: Colors.green),
              ),
            ),
            Card(
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                leading: Image.asset("assets/images/pizza_1f355.webp", width: 50,),
                //leading: Icon(Icons.person, size: 40, color: Colors.orange),
                title: Text("Veg Pizza", style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
                subtitle: Text("₹199"),
                trailing: Icon(Icons.shopping_cart, color: Colors.green),
              ),
            ),
            Card(
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                leading: Image.asset("assets/images/pasta.webp", width: 50,),
                //leading: Icon(Icons.person, size: 40, color: Colors.orange),
                title: Text("Pasta", style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
                subtitle: Text("₹179"),
                trailing: Icon(Icons.shopping_cart, color: Colors.green),
              ),
            ),
            Card(
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                leading: Image.asset("assets/images/sandwich.webp", width: 50,),
                //leading: Icon(Icons.person, size: 40, color: Colors.orange),
                title: Text("Sandwich", style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
                subtitle: Text("₹99"),
                trailing: Icon(Icons.shopping_cart, color: Colors.green),
              ),
            ),
            Card(
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                leading: Image.asset("assets/images/drink.webp", width: 50,),
                //leading: Icon(Icons.person, size: 40, color: Colors.orange),
                title: Text("Cold Drink", style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
                subtitle: Text("₹49"),
                trailing: Icon(Icons.shopping_cart, color: Colors.green),
              ),
            ),
            Card(
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                leading: Image.asset("assets/images/ice-cream.webp", width: 50,),
                //leading: Icon(Icons.person, size: 40, color: Colors.orange),
                title: Text("Ice Cream", style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
                subtitle: Text("₹69"),
                trailing: Icon(Icons.shopping_cart, color: Colors.green),
              ),
            ),
            Card(
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                leading: Image.asset("assets/images/cake.webp", width: 50,),
                //leading: Icon(Icons.person, size: 40, color: Colors.orange),
                title: Text("Chocolate Cake", style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
                subtitle: Text("₹149"),
                trailing: Icon(Icons.shopping_cart, color: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

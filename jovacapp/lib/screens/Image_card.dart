import 'package:flutter/material.dart';
class ImageCard extends StatelessWidget {
  const ImageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Card"),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Container(
          width: 350,
          height: 570,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: const EdgeInsets.all(15),
              child: ClipRRect(
                borderRadius:BorderRadius.circular(15),
                child: Image.asset(
                  "assets/images/burger.jpg",
                  height: 200,
                  width: 280,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10,),
            Text("Cheese Burger",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 10,),
            Text(
                "Fresh & Delicious Burger\nwith Cheese",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 24,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "4.8 (250 Reviews)",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Text(
              "₹249",
              style: TextStyle(
                fontSize: 42,
                color: Colors.deepOrange,
                fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10,),
              FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  fixedSize: Size(250, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Order Now",
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
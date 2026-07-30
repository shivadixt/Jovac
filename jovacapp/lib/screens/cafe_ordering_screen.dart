import 'package:flutter/material.dart';

class CafeOrderingScreen extends StatefulWidget {
  const CafeOrderingScreen({super.key});

  @override
  State<CafeOrderingScreen> createState() => _CafeOrderingScreen();
}

class _CafeOrderingScreen extends State<CafeOrderingScreen> {
  String selected = "Burger";
  int quantity = 1;

  final Map<String, Map<String, String>> menu = {
    "Burger": {
      "name": "Veg Burger",
      "price": "₹120",
      "rating": "4.5",
      "image": "assets/images/burger-emoji-vector-design.webp",
    },
    "Pizza": {
      "name": "Veg Pizza",
      "price": "₹199",
      "rating": "4.7",
      "image": "assets/images/pizza_1f355.webp",
    },
    "Cake": {
      "name": "Chocolate Cake",
      "price": "₹150",
      "rating": "4.8",
      "image": "assets/images/cake.webp",
    },
    "Coffee": {
      "name": "Cold Coffee",
      "price": "₹99",
      "rating": "4.4",
      "image": "assets/images/drink.webp",
    },
  };

  @override
  Widget build(BuildContext context) {
    void showSpecialDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: const Row(
              children: [
                Text("🎉 ", style: TextStyle(fontSize: 20)),
                Text(
                  "Today's Special",
                  style: TextStyle(color: Colors.deepPurple),
                ),
              ],
            ),
            content: const Text("Veg Burger\n₹99"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // closes the dialog
                },
                child: const Text("Close"),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Smart Cafe"),
        backgroundColor: Colors.green,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          showSpecialDialog();
        },
        child: const Icon(Icons.local_cafe, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Choose Category",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 10),

              // Dropdown
              DropdownButtonFormField<String>(
                value: selected,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: const [
                  DropdownMenuItem(value: "Burger", child: Text("🍔 Burger")),
                  DropdownMenuItem(value: "Pizza", child: Text("🍕 Pizza")),
                  DropdownMenuItem(value: "Cake", child: Text("🎂 Cake")),
                  DropdownMenuItem(value: "Coffee", child: Text("☕ Coffee")),
                ],
                onChanged: (value) {
                  setState(() {
                    selected = value!;
                  });
                },
              ),

              const SizedBox(height: 20),

              // Food Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Image.asset(
                        menu[selected]!["image"]!,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              menu[selected]!["name"]!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(
                              menu[selected]!["price"]!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.green,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                  size: 15,
                                ),
                                const SizedBox(width: 5),
                                Text(menu[selected]!["rating"]!),
                              ],
                            ),
                          ],
                        ),
                      ),

                      PopupMenuButton<String>(
                        onSelected: (value) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(value)));
                        },
                        itemBuilder: (context) => const [
                          PopupMenuItem(
                            value: "Add Cheese",
                            child: Text("Add Cheese"),
                          ),
                          PopupMenuItem(
                            value: "Extra Sauce",
                            child: Text("Extra Sauce"),
                          ),
                          PopupMenuItem(
                            value: "View Nutrition",
                            child: Text("View Nutrition"),
                          ),
                          PopupMenuItem(
                            value: "Share Item",
                            child: Text("Share Item"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                "Quantity",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 10),

              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (quantity > 1) quantity--; // don't go below 1
                      });
                    },
                    icon: const Icon(Icons.remove_circle_outline),
                    color: Colors.deepPurple,
                  ),
                  Text(
                    "$quantity",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                    icon: const Icon(Icons.add_circle_outline),
                    color: Colors.deepPurple,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity, // makes button stretch full width
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Order Placed: ${menu[selected]!["name"]} x$quantity",
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart),
                  label: const Text("Place Order"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "${menu[selected]!["name"]} saved for later",
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.bookmark_border),
                  label: const Text("Save for Later"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.deepPurple,
                    side: const BorderSide(color: Colors.deepPurple),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              TextButton.icon(
                onPressed: () {
                  setState(() {
                    selected = "Burger"; // reset to default
                    quantity = 1; // reset quantity too
                  });
                },
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                label: const Text(
                  "Clear Selection",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

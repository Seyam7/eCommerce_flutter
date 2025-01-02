import 'package:e_commerce_flutter/views/home/sections/category_section.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){},
            icon: Icon(Icons.menu),
        ),
        title: Text('Home'),
        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.shopping_bag_rounded
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          //category
          CategorySection(),
        ],
      ),
    );
  }
}

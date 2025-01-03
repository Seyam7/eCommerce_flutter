import 'package:flutter/material.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map> categories = [
      {
        'name' : 'Fashion',
        'icon' : Icons.man,
      },
      {
        'name' : 'Electronics',
        'icon' : Icons.computer,
      },
      {
        'name' : 'Applications',
        'icon' : Icons.app_blocking,
      },
      {
        'name' : 'Fashion',
        'icon' : Icons.man,
      },
      {
        'name' : 'Electronics',
        'icon' : Icons.computer,
      },
      {
        'name' : 'Applications',
        'icon' : Icons.app_blocking,
      },
      {
        'name' : 'Fashion',
        'icon' : Icons.man,
      },
      {
        'name' : 'Electronics',
        'icon' : Icons.computer,
      },
      {
        'name' : 'Applications',
        'icon' : Icons.app_blocking,
      },
    ];
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                'View More',
                style: TextStyle(
                  color: Colors.black.withOpacity(.5),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 80,
            child: ListView.separated(
              itemBuilder: (_, index) {
                return Column(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.teal.withOpacity(.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        categories[index]['icon'],
                        color: Colors.green,
                        size: 30,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      categories[index]['name'],
                      style: TextStyle(fontSize: 10,),
                    ),
                  ],
                );
              },
              itemCount: categories.length,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (_, index) {
                return SizedBox(
                  width: 10,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

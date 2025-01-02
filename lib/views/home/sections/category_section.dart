import 'package:flutter/material.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
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
            height: 150,
            child: ListView.separated(
              itemBuilder: (_,index){
                return Column(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.teal.withOpacity(.2),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                );
              },
              itemCount: 7,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (_,index){
                return SizedBox(width: 10,);
              },
            ),
          ),
        ],
      ),
    );
  }
}

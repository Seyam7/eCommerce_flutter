import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map> categories = [
      // {
      //   'name' : 'Fashion',
      //   'icon' : Icons.man,
      // },
      // {
      //   'name' : 'Electronics',
      //   'icon' : Icons.computer,
      // },
      // {
      //   'name' : 'Applications',
      //   'icon' : Icons.app_blocking,
      // },
      // {
      //   'name' : 'Fashion',
      //   'icon' : Icons.man,
      // },
      // {
      //   'name' : 'Electronics',
      //   'icon' : Icons.computer,
      // },
      // {
      //   'name' : 'Applications',
      //   'icon' : Icons.app_blocking,
      // },
      // {
      //   'name' : 'Fashion',
      //   'icon' : Icons.man,
      // },
      // {
      //   'name' : 'Electronics',
      //   'icon' : Icons.computer,
      // },
      // {
      //   'name' : 'Applications',
      //   'icon' : Icons.app_blocking,
      // },
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
          StreamBuilder(
              stream: FirebaseFirestore.instance.collection('categories').snapshots(),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if(snapshot.hasError){
                  print('Error is ${snapshot.error.toString()}');
                }
                return SizedBox(
                  height: 80,
                  child: ListView.separated(
                    itemBuilder: (_, index) {
                      final category = snapshot.data!.docs[index];
                      return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.teal.withOpacity(.2),
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(category['icon']),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            category['name'],
                            style: TextStyle(fontSize: 10,),
                          ),
                        ],
                      );
                    },
                    itemCount: snapshot.data!.docs.length,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (_, index) {
                      return SizedBox(
                        width: 10,
                      );
                    },
                  ),
                );
              },
          ),
        ],
      ),
    );
  }
}

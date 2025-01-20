import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_flutter/views/product_details/product_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListView extends StatelessWidget {
  final Map<String,dynamic> category;
  const ProductListView({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final _fireStore = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text(category['name']),
      ),
      body: StreamBuilder(
        stream: _fireStore.collection('products').where('category_slug', isEqualTo: category['slug']).snapshots(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.hasData && snapshot.data!.docs.isEmpty){
            return Text('No products');
          }
          return GridView.builder(
            padding: EdgeInsets.all(15),
            //primary: false,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              final product = snapshot.data!.docs[index];

              return InkWell(
                onTap: (){
                  Get.to(()=>ProductDetails(
                    product: product.data(),
                    productID: product.id,
                  ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(3),
                        image: DecorationImage(
                          image: NetworkImage(
                            product['thumbnail'],
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      product['title'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Text(
                          '৳${product['discount_price'] ?? product['original_price']}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 10,),
                        if(product['discount_price']!=null)...[  //spread operator
                          Text(
                            '৳${product['original_price']}',
                            style: TextStyle(
                              color: Colors.black.withOpacity(.5),
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

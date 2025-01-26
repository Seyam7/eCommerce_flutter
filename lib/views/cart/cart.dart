import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_flutter/views/checkout/checkout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fireStore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
        scrolledUnderElevation: 0,
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: fireStore.collection('carts').where('user', isEqualTo: user!.email).snapshots(),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if(snapshot.hasData && snapshot.data!.docs.isEmpty){
              return Center(
                child: Text('No products added'),
              );
            }
            var totalAmount = snapshot.data!.docs.fold(0.0, (sum, doc){
              final product = doc.data();
              final price = double.parse(product['price'].toString());//convert price into double from string
              return sum + (price * product['quantity']);
            });
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    itemBuilder: (context, index) {
                      final product = snapshot.data!.docs[index];
                      return Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.1),
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image:  NetworkImage(product['image'],),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    product['title'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text('৳ ${product['price']}'),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: ()async{
                                          if(product['quantity']==1){
                                            print('delete');
                                            await fireStore.collection('carts').doc(product.id).delete();
                                          }else{
                                            await fireStore.collection('carts').doc(product.id).update({
                                              'quantity' : FieldValue.increment(-1),
                                            });
                                          }
                                        },
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.remove,
                                              color: Colors.white,
                                              size: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Text(
                                        product['quantity'].toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      InkWell(
                                        onTap: (){
                                          fireStore.collection('carts').doc(product.id).update({
                                            'quantity' : FieldValue.increment(1),
                                          });
                                        },
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: snapshot.data!.docs.length,
                  ),
                ),
                Container(
                  height: 60,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            'Total: ৳ ${totalAmount}',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: (){
                            print('checkout buton presser');
                            Get.to(()=>CheckoutPage());

                          },
                          child: Text('Checkout'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
      ),
    );
  }
}

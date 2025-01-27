import 'package:bkash/bkash.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_flutter/views/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutPage extends StatefulWidget {
  final double totalAmount;
  const CheckoutPage({
    super.key,
    required this.totalAmount,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final List<Map> gateways = [
    {
      'name': 'bKash',
      'logo':
          'https://logos-download.com/wp-content/uploads/2022/01/BKash_Logo_icon.png',
    },
    {
      'name': 'Cash On Delivery',
      'logo': 'https://cdn-icons-png.flaticon.com/512/9198/9198191.png',
    },
  ];

  int? selected;
  final user = FirebaseAuth.instance.currentUser;
  final fireStore = FirebaseFirestore.instance;

  continueToOrder() {
    if (selected == 0) {
      bkashPayment();
    } else {
      placeOrder('COD');
    }
  }

  bkashPayment() async {
    final bkash = Bkash(logResponse: true);

    try {
      final response = await bkash.pay(
        context: context,
        amount: widget.totalAmount,
        merchantInvoiceNumber: DateTime.now().microsecondsSinceEpoch.toString(),
      );
      print('payment success');

      placeOrder('bkash', response.trxId);
    } on BkashFailure catch (e) {
      print(e.message);
    }
  }

  placeOrder(String paymentType, [String? trxID]) async {
    final cart = await fireStore
        .collection('carts')
        .where('user', isEqualTo: user!.email)
        .get();
    await fireStore.collection('orders').add({
      'user': user!.email,
      'items': cart.docs.map((product) => product.data()).toList(),
      'total_amount': widget.totalAmount,
      'time': FieldValue.serverTimestamp(),
      'status': 'pending',
      'payment_type': paymentType,
      'payment_status': paymentType == 'COD'
          ? 'pending'
          : trxID != null
              ? 'success'
              : 'pending',
      'trx_id': trxID
    });

    for(var doc in cart.docs){
      await doc.reference.delete();
    }

    Get.snackbar('Success', 'Your order has been placed');
    Get.offAll(()=>HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
        scrolledUnderElevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (_, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selected = index;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: selected == index
                              ? Colors.red
                              : Colors.black.withValues(),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ListTile(
                        title: Text(gateways[index]['name']),
                        leading: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(gateways[index]['logo']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, index) {
                  return SizedBox(height: 10);
                },
                itemCount: gateways.length,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                selected == null ? null : continueToOrder();
              },
              child: Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }
}

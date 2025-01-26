import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final List<Map> gateways = [
    {
      'name' : 'bKash',
      'logo' : 'https://logos-download.com/wp-content/uploads/2022/01/BKash_Logo_icon.png',
    },
    {
      'name' : 'Cash On Delivery',
      'logo' : 'https://cdn-icons-png.flaticon.com/512/9198/9198191.png',
    },
  ];

  int? selected;

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
                  itemBuilder: (_,index){
                    return InkWell(
                      onTap: (){
                        setState(() {
                          selected = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: selected == index? Colors.red : Colors.black.withValues(),
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
                  separatorBuilder: (_,index){
                    return SizedBox(height: 10);
                  },
                  itemCount: gateways.length,
              ),
            ),
            ElevatedButton(
                onPressed: (){
                  
                },
                child: Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }
}

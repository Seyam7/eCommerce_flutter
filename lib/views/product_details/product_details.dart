import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetails extends StatelessWidget {
  final Map<String, dynamic> product;
  const ProductDetails({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductsliderSection(product: product,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['title'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 3,),
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
                  SizedBox(height: 5,),
                  Divider(
                    color: Colors.black.withOpacity(.1),
                  ),
                  Text('Description',style: TextStyle(fontWeight: FontWeight.w600),),
                  Text(
                    product['description'],
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: (){

                },
                child: Text('Add to cart'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductsliderSection extends StatefulWidget {
  final Map<String, dynamic> product;
  const ProductsliderSection({
    super.key,
    required this.product,
  });

  @override
  State<ProductsliderSection> createState() => _ProductsliderSectionState();
}

class _ProductsliderSectionState extends State<ProductsliderSection> {
  List<String> sliders = [
    'https://alifworld.com.bd/public/uploads/all/ERYpgXHUsWnwrOkSN4etgeG1u9eOvEtMz3KsKZdq.jpg',
    'https://alifworld.com.bd/public/uploads/all/DbxXs7rvkYPzOoZgxPc8xQ8NuRmQG48HFG41Am7A.jpg',
    'https://alifworld.com.bd/public/uploads/all/KnKxl3UmC1YmwlrSzRd1UUXYL2AZ8zyWteIYtOE7.jpg',
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {

    final gallery = widget.product['gallery'];
    return Stack(
      children: [
        CarouselSlider.builder(
          itemCount: gallery.length,
          itemBuilder: (context, index, pageIndex) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(gallery[index]),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 300,
            autoPlay: false,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              print(index);
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
        Positioned(
          bottom: 10,
          left: 180,
          child: DotsIndicator(

            dotsCount: gallery.length,
            position: currentIndex,
            decorator: DotsDecorator(
              color: Colors.black87,
              activeColor: Colors.redAccent,
            ),
          ),
        ),
      ],
    );
  }
}

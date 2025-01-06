import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

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
            ProductsliderSection(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tools',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 3,),
                  Row(
                    children: [
                      Text(
                        '\$35',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text(
                        '\$40',
                        style: TextStyle(
                          color: Colors.black.withOpacity(.5),
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Divider(
                    color: Colors.black.withOpacity(.1),
                  ),
                  Text('Description',style: TextStyle(fontWeight: FontWeight.w600),),
                  Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
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
  const ProductsliderSection({super.key});

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
    return Stack(
      children: [
        CarouselSlider.builder(
          itemCount: sliders.length,
          itemBuilder: (context, index, pageIndex) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(sliders[index]),
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
            dotsCount: sliders.length,
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

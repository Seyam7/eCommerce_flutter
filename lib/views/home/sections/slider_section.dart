import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SliderSection extends StatelessWidget {
  const SliderSection({super.key});

  get options => null;

  @override
  Widget build(BuildContext context) {
    List<String> sliders = [
      'https://www.essentialplugin.com/wp-content/uploads/2021/08/Top-Slider-Hero-Banner-Plugins-for-WordPress-in-2021-1.png',
      'https://img.freepik.com/premium-vector/modern-sale-banner-website-slider-template-design_54925-45.jpg',
      'https://img.freepik.com/free-vector/online-shopping-banner-template_23-2148787138.jpg',
    ];
    return CarouselSlider.builder(
        itemCount: sliders.length,
        itemBuilder: (context, itemIndex, pageViewIndex){
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(sliders[itemIndex]),fit: BoxFit.cover),
            ),
          );
        },
        options: CarouselOptions(
          height: 120,
          aspectRatio: 16/9,
          viewportFraction: 1,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: 0.3,
          scrollDirection: Axis.horizontal,
        ),
    );
  }
}

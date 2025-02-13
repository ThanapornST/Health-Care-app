//รูปเลื่อนๆ
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class SwiperImages extends StatefulWidget {
  const SwiperImages(this.startinformation, {super.key});

  final void Function() startinformation;

  @override
  State<SwiperImages> createState() => _SwiperImagesState();
}

class _SwiperImagesState extends State<SwiperImages> {
  final List<String> images = [
    "https://i.pinimg.com/736x/ec/9d/24/ec9d24e8dada1fea18a2655674c1ff2f.jpg",
    "https://i.pinimg.com/736x/40/a7/b0/40a7b09d1dd588b6dcdb3a415cf30818.jpg",
    "https://i.pinimg.com/736x/72/db/77/72db77f9098fd5ceff37871d45cdd33d.jpg",
    "https://i.pinimg.com/736x/85/a4/d8/85a4d81cf3e367e67c3a7fce40fb5d2f.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Image.network(
                images[index],
                fit: BoxFit.cover,
              );
            },
            indicatorLayout: PageIndicatorLayout.COLOR,
            autoplay: true,
            itemCount: images.length,
            pagination: const SwiperPagination(),
            control: const SwiperControl(),
          ),
          Positioned(
            bottom: 30.0,
            left: 20.0,
            right: 20.0,
            child: ElevatedButton(
              onPressed: () {
                widget.startinformation();
              },
              child: const Text("LET'S GO!"),
            ),
          ),
        ],
      ),
    );
  }
}

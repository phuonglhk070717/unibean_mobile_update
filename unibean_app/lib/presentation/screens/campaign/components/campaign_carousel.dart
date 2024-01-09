import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:unibean_app/presentation/config/constants.dart';

class CampaignCarousel extends StatefulWidget {
  const CampaignCarousel({super.key});

  @override
  State<CampaignCarousel> createState() => _CampaignCarouselState();
}

class _CampaignCarouselState extends State<CampaignCarousel> {
  int activeIndex = 0;
  final assetImg = [
    'assets/images/campaign-banner-img.png',
    'assets/images/campaign-banner-img.png',
    'assets/images/campaign-banner-img.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: CarouselSlider.builder(
            itemCount: assetImg.length,
            options: CarouselOptions(
              height: 130,
              autoPlay: true,
              // clipBehavior: Clip.none,
              // reverse: true,
              autoPlayInterval: Duration(seconds: 2),
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              onPageChanged: (index, reason) {
                setState(() {
                  activeIndex = index;
                });
              },
            ),
            itemBuilder: (context, index, realIndex) {
              final assetImage = assetImg[index];

              return buildImage(assetImage, index);
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        buildIndicator(),
      ],
    );
  }

  Widget buildImage(String assetImage, int index) => Container(
        width: 300,
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage(assetImage))),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: assetImg.length,
        effect: SlideEffect(
            activeDotColor: kPrimaryColor,
            dotWidth: 20,
            dotHeight: 5,
            dotColor: Color.fromARGB(255, 216, 216, 216)),
      );
}
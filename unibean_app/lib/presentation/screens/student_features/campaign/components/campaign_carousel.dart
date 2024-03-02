import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:unibean_app/data/models.dart';
import 'package:unibean_app/presentation/config/constants.dart';

class CampaignCarousel extends StatefulWidget {
  final List<CampaignModel> campaigns;
  const CampaignCarousel({super.key, required this.campaigns});

  @override
  State<CampaignCarousel> createState() => _CampaignCarouselState();
}

class _CampaignCarouselState extends State<CampaignCarousel> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                height: 220,
                autoPlayInterval: Duration(seconds: 20),
                onPageChanged: (index, reason) {
                  setState(() {
                    activeIndex = index;
                  });
                },
              ),
              items: widget.campaigns.map((campaign) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: 300,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0x0c000000),
                                offset: Offset(0, 5),
                                blurRadius: 5)
                          ]
                          ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)
                            ),
                            child: Container(
                              width: 300,
                              height: 160,
                              child: Image.network(
                                campaign.image,
                                fit: BoxFit.fill,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/campaign-default.png',
                                  );
                                },
                              ),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 180,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(
                                        campaign.campaignName,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                        style: GoogleFonts.nunito(
                                            textStyle: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900,
                                        )),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(
                                        campaign.description,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.nunito(
                                            textStyle: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Container(
                                    width: 80,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        color: kPrimaryColor,
                                        borderRadius:
                                            BorderRadius.circular(5)),
                                    child: Center(
                                      child: Text(
                                        'Chi tiết',
                                        style: GoogleFonts.nunito(
                                            textStyle: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white)),
                                      ),
                                    )),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              }).toList()),
        ),
        const SizedBox(
          height: 10,
        ),
        buildIndicator(),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget buildImage(String assetImage, int index) => Container(
        child: Stack(
          children: [
            Positioned(
                child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      fit: BoxFit.fill, image: AssetImage(assetImage))),
            ))
          ],
        ),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: widget.campaigns.length,
        effect: SlideEffect(
            activeDotColor: kPrimaryColor,
            dotWidth: 20,
            dotHeight: 5,
            dotColor: Color.fromARGB(255, 216, 216, 216)),
      );
}

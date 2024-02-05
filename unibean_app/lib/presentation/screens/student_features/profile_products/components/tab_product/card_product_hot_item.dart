import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unibean_app/presentation/config/constants.dart';

class CardProductHotItem extends StatelessWidget {
  const CardProductHotItem(
      {super.key,
      required this.fem,
      required this.hem,
      required this.ffem,
      required this.nameVoucher,
      required this.rate,
      required this.price,
      required this.assetName});

  final double fem;
  final double hem;
  final double ffem;
  final String nameVoucher;
  final String rate;
  final double price;
  final String assetName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180 * fem,
      height: 260 * hem,
      margin: EdgeInsets.only(left: 5 * fem),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15 * fem),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Color(0x0c000000),
                offset: Offset(0 * fem, 10 * fem),
                blurRadius: 5 * fem)
          ]),
      child: Column(
        children: [
          Container(
            width: 165 * fem,
            height: 170 * hem,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15 * fem),
                image: DecorationImage(
                    image: AssetImage(assetName), fit: BoxFit.fill)),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: 12 * fem, right: 12 * fem, top: 10 * hem),
            child: Text(
              nameVoucher,
              style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                fontSize: 13 * ffem,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5 * hem),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 5 * fem),
                      child: Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 2 * fem),
                      child: Text(
                        rate,
                        style: GoogleFonts.nunito(
                            fontSize: 18 * ffem,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 2 * fem),
                      child: Text(
                        price.toString(),
                        style: GoogleFonts.nunito(
                            fontSize: 18 * ffem,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 5 * fem),
                      child: SvgPicture.asset(
                        'assets/icons/green-bean-icon.svg',
                        width: 30 * fem,
                        height: 30 * fem,
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unibean_app/data/models/student_model.dart';
import 'package:unibean_app/presentation/config/constants.dart';
import 'package:unibean_app/presentation/screens/student_features/profile/components/item_icon_card_profile.dart';
import 'package:unibean_app/presentation/screens/student_features/profile/components/name_profile.dart';
import 'package:unibean_app/presentation/screens/student_features/profile/components/student_code_profile.dart';
import 'package:unibean_app/presentation/screens/student_features/profile/components/unitiversity_name_profile.dart';

import '../../../screens.dart';

class InformationCardProfile extends StatelessWidget {
  const InformationCardProfile({
    super.key,
    required this.hem,
    required this.fem,
    required this.ffem,
    required this.studentModel,
  });

  final double hem;
  final double fem;
  final double ffem;
  final StudentModel studentModel;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 65 * hem,
      left: 25 * fem,
      child: Container(
        width: 324 * fem,
        height: 200 * hem,
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 10 * hem,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 25 * fem,
                ),

                //avatar
                ClipRRect(
                  borderRadius: BorderRadius.circular(100 * fem),
                  child: Container(
                    width: 80 * hem,
                    height: 80 * fem,
                    child: Image(
                        image: NetworkImage(
                      '${studentModel.avatar}',
                    ),
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset('assets/images/ava_signup.png',
                      width: 100*fem,
                      height: 100*hem,);
                    },),
                  ),
                ),

                SizedBox(
                  width: 20 * fem,
                ),

                SizedBox(
                  // color: Colors.red,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Name
                      NameProfile(
                        fem: fem,
                        ffem: ffem,
                        hem: hem,
                        name: studentModel.fullName,
                      ),
                      //email
                      SizedBox(
                        width: 150*fem,
                        child: Text(
                          '${studentModel.email}',
                          maxLines: 1,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 12 * ffem,
                                  fontWeight: FontWeight.normal,
                                  color: kLowTextColor)),
                        ),
                      ),
                      //student code
                      StudentCodeProfile(
                        hem: hem,
                        fem: fem,
                        ffem: ffem,
                        studentCode: studentModel.code,
                      ),
                      //university name
                      UniversityProfile(
                        fem: fem,
                        hem: hem,
                        ffem: ffem,
                        university: studentModel.universityName,
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10 * fem,
            ),
            SizedBox(
              width: 280 * fem,
              child: Divider(
                thickness: 1 * fem,
                color: const Color.fromARGB(255, 225, 223, 223),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 10 * hem,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ItemIconCardProfile(
                      fem: fem,
                      hem: hem,
                      ffem: ffem,
                      title: '${studentModel.following.toString()} theo dõi',
                      svgAssetName: 'assets/icons/following-icon.svg'),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, QRScreen.routeName,
                              arguments: studentModel.id);
                        },
                        child: Container(
                          width: 40 * fem,
                          height: 40 * hem,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[100],
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/icons/qr-unbean-icon.svg',
                              colorFilter: ColorFilter.mode(
                                  kPrimaryColor, BlendMode.srcIn),
                              height: 18 * fem,
                              width: 18 * fem,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Mã QR',
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                fontSize: 11 * fem,
                                fontWeight: FontWeight.w600,
                                height: 1.3625 * ffem / fem,
                                color: kLowTextColor)),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

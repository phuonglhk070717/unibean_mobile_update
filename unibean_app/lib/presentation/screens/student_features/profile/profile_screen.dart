import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unibean_app/presentation/screens/student_features/profile/components/body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 160 * hem,
          title: Padding(
            padding:  EdgeInsets.only(left: 20*fem),
            child: Text(
              'UNI Student Bean',
              style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                      fontSize: 30 * ffem,
                      fontWeight: FontWeight.w900,
                      height: 1.3625 * ffem / fem,
                      color: Colors.white)),
            ),
          ),
          actions: [
            // SvgPicture.asset('assets/icons/notification-icon.svg')
            Padding(
              padding:  EdgeInsets.only(right: 20*fem),
              child: IconButton(
                icon:  Icon(Icons.notifications, color: Colors.white,
                size: 35*fem,),
                onPressed: () {},
              ),
            ),
          ],
        ),
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: Body(),
      ),
    );
  }
}
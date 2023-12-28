import 'package:flutter/material.dart';
import 'package:unibean_app/presentation/screens/signup/components/body_3.dart';
import 'package:unibean_app/presentation/screens/signup/screens/signup_1_screen.dart';
import 'package:unibean_app/presentation/widgets/app_bar_signup.dart';

class SignUp3Screen extends StatefulWidget {
  static const String routeName = '/signup_3';
  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const SignUp3Screen(),
        settings: const RouteSettings(name: routeName));
  }

  const SignUp3Screen({super.key});

  @override
  State<SignUp3Screen> createState() => _SignUp3ScreenState();
}

class _SignUp3ScreenState extends State<SignUp3Screen> {
  late String title;

  @override
  void initState() {
    if (SignUp1Screen.defaultStep == 7) {
      title = 'Bước 4/7';
    } else {
      title = 'Bước 3/6';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBarSignUp(hem: hem, ffem: ffem, fem: fem, text: title),
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        body: Body3(),
      ),
    );
  }
}

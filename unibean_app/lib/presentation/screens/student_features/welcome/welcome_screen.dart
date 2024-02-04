import 'package:flutter/material.dart';
import 'package:unibean_app/presentation/screens/student_features/welcome/components/body.dart';

class WelcomeScreen extends StatelessWidget {
  static const String routeName = '/welcome';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const WelcomeScreen(),
        settings: const RouteSettings(name: routeName));
  }

  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: const Body(),
    );
  }
}

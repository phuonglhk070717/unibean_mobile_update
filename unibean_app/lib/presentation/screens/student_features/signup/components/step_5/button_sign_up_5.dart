import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unibean_app/presentation/config/constants.dart';
import 'package:unibean_app/presentation/cubits/validation/validation_cubit.dart';
import 'package:unibean_app/presentation/screens/student_features/signup/components/step_5/form_body_5.dart';

class ButtonSignUp5 extends StatelessWidget {
  const ButtonSignUp5({
    super.key,
    required this.widget,
    required this.onPressed,
  });

  final FormBody5 widget;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      // onPressed: () {
      //   Navigator.pushNamed(context, SignUp5Screen.routeName,
      //       arguments: SignUp1Screen.defaultRegister);
      // },
      onPressed: onPressed,
      child: Container(
        width: 300 * widget.fem,
        height: 45 * widget.hem,
        decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(23 * widget.fem)),
        child: BlocBuilder<ValidationCubit, ValidationState>(
          builder: (context, state) {
            if (state is ValidationInProcess) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            return Center(
              child: Text(
                'Tiếp tục',
                style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                        fontSize: 17 * widget.ffem,
                        fontWeight: FontWeight.w600,
                        height: 1.3625 * widget.ffem / widget.fem,
                        color: Colors.white)),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:unibean_app/presentation/config/constants.dart';

class BirthdayForm extends StatefulWidget {
  const BirthdayForm(
      {super.key,
      required this.hem,
      required this.fem,
      required this.ffem,
      required this.controller});

  final double hem;
  final double fem;
  final double ffem;
  final TextEditingController controller;

  @override
  State<BirthdayForm> createState() => _BirthdayFormState();
}

class _BirthdayFormState extends State<BirthdayForm> {
  DateTime? date = DateTime.now();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42 * widget.hem,
      width: 272 * widget.fem,
      child: TextFormField(
        style: GoogleFonts.nunito(
            textStyle: TextStyle(
                color: Colors.black,
                fontSize: 17 * widget.ffem,
                fontWeight: FontWeight.w700)),
        keyboardType: TextInputType.number,
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: 'NGÀY SINH *',
          hintText: '01/01/2000',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: GoogleFonts.nunito(
            textStyle: TextStyle(
                color: kPrimaryColor,
                fontSize: 15 * widget.ffem,
                fontWeight: FontWeight.w900),
          ),
          hintStyle: GoogleFonts.nunito(
              textStyle: TextStyle(
                  color: kLowTextColor,
                  fontSize: 17 * widget.ffem,
                  fontWeight: FontWeight.w700)),
          contentPadding: EdgeInsets.symmetric(
              horizontal: 26 * widget.fem, vertical: 10 * widget.hem),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28 * widget.fem),
              borderSide: BorderSide(
                  width: 2, color: const Color.fromARGB(255, 220, 220, 220)),
              gapPadding: 10),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28 * widget.fem),
              borderSide: BorderSide(
                  width: 2, color: const Color.fromARGB(255, 220, 220, 220)),
              gapPadding: 10),
        ),
        onTap: () async {
          date = DateTime(1900);
          date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now());
          String formateDate = DateFormat('yyy-MM-dd').format(date!);
          widget.controller.text = formateDate;
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unibean_app/presentation/config/constants.dart';

import '../../../../../../data/models.dart';
import '../../../../../blocs/blocs.dart';

class DropDownCampus extends StatefulWidget {
  final double hem;
  final double fem;
  final double ffem;
  final String labelText;
  final String hintText;
  const DropDownCampus({
    super.key,
    required this.hem,
    required this.fem,
    required this.ffem,
    required this.labelText,
    required this.hintText,
  });

  @override
  State<DropDownCampus> createState() => _DropDownCampusState();
}

class _DropDownCampusState extends State<DropDownCampus> {
  List<CampusModel> campuses = List.empty();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43 * widget.hem,
      width: 272 * widget.fem,
      child: BlocConsumer<CampusBloc, CampusState>(
        listener: (context, state) {
          if (state is CampusLoaded) {
            campuses = state.campuses.toList();
          }
        },
        builder: (context, state) {
          if (state is CampusInProcess) {
            return Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            );
          } else if (state is CampusLoaded) {
            campuses = state.campuses.toList();
            return _dropDownUniversityLoaded();
          }
          return _dropDownUniversityLoaded();
        },
      ),
    );
  }

  DropdownButtonFormField<String> _dropDownUniversityLoaded() {
    return DropdownButtonFormField(
      style: GoogleFonts.nunito(
          textStyle: TextStyle(
              color: Colors.black,
              fontSize: 17 * widget.ffem,
              fontWeight: FontWeight.w700)),
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
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
      // value: campuses[0].id,
      onChanged: (newValue) {
        setState(() {
          // wid
        });
      },
      items: campuses.map((u) {
        return DropdownMenuItem(
          child: Text(u.campusName.toString()),
          value: u.id,
        );
      }).toList(),
    );
  }
}

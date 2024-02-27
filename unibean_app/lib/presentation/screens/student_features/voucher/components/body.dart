import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:unibean_app/presentation/blocs/blocs.dart';
// import 'package:unibean_app/presentation/screens/student_features/campaign/components/brand_card.dart';
import 'package:unibean_app/presentation/screens/student_features/voucher/components/voucher_card.dart';
import 'package:unibean_app/presentation/screens/student_features/voucher/components/voucher_list_card.dart';
import 'package:unibean_app/presentation/screens/student_features/voucher/search_bar_custom.dart';

import '../../../../config/constants.dart';
import 'package:unibean_app/data/models.dart';

import '../../../../widgets/card_for_unknow.dart';
import '../../../../widgets/brand_card.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;

    final roleState = context.read<RoleAppBloc>().state;

    var roleWidget = (switch (roleState) {
      RoleAppUnknown() =>
        Center(child: CardForUnknow(fem: fem, hem: hem, ffem: ffem)),
      RoleAppStudentUnverified() =>
        Center(child: CardForUnknow(fem: fem, hem: hem, ffem: ffem)),
      RoleAppStudentVerified(
        // ignore: unused_local_variable
        authenModel: final authenModel,
        studentModel: final studentModel
      ) =>
        _buildVerified(fem, hem, ffem, studentModel),
      RoleAppStore() => Container(),
      RoleAppLoading() => Container(
          child: Center(
              child: Lottie.asset('assets/animations/loading-screen.json',
                  width: 50 * fem, height: 50 * hem)),
        )
    });

    return roleWidget;
  }

  Widget _buildVerified(
      double fem, double hem, double ffem, StudentModel student) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //header
                Container(
                  color: kbgWhiteColor,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20 * hem),
                        child: Center(
                          child: Text(
                            'Xin chào, ${student.fullName}!',
                            style: GoogleFonts.nunito(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 21 * ffem,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Tham gia các hoạt động để tích lũy ưu đãi',
                          style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12 * ffem,
                                  fontWeight: FontWeight.normal)),
                        ),
                      ),
                      SizedBox(
                        height: 20 * hem,
                      ),
                      SearchBarCustom(),
                      SizedBox(
                        height: 15 * hem,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10 * hem,
                ),

                //Thương hiệu
                Container(
                  color: kbgWhiteColor,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10 * fem),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 10 * hem),
                              child: Text(
                                'Các thương hiệu',
                                style: GoogleFonts.nunito(
                                    textStyle: TextStyle(
                                  fontSize: 20 * ffem,
                                  color: kDarkPrimaryColor,
                                  fontWeight: FontWeight.w800,
                                )),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 5 * hem, right: 10 * fem),
                                child: Text(
                                  'Xem thêm',
                                  style: GoogleFonts.nunito(
                                      textStyle: TextStyle(
                                    fontSize: 12 * ffem,
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                  )),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15 * hem,
                      ),
                      BlocBuilder<BrandBloc, BrandState>(
                          builder: (context, state) {
                        if (state is BrandsLoaded) {
                          return SizedBox(
                              height: 120 * hem,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.brands.length,
                                itemBuilder: (context, index) {
                                  return BrandCard(
                                      fem: fem,
                                      hem: hem,
                                      ffem: ffem,
                                      brandModel: state.brands[index]);
                                },
                              ));
                        }
                        return Container(
                            child: Center(
                                child: Lottie.asset(
                                    'assets/animations/loading-screen.json',
                                    width: 50 * fem,
                                    height: 50 * hem)));
                      }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10 * hem,
                ),

                //GỢi ý cho bạn
                Container(
                  color: kbgWhiteColor,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10 * fem),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Gợi ý cho bạn',
                              style: GoogleFonts.nunito(
                                  textStyle: TextStyle(
                                fontSize: 18 * ffem,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              )),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 5 * hem, right: 10 * fem),
                                child: Text(
                                  'Xem thêm',
                                  style: GoogleFonts.nunito(
                                      textStyle: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 12 * ffem,
                                    fontWeight: FontWeight.bold,
                                  )),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10 * fem,
                      ),
                      BlocBuilder<VoucherBloc, VoucherState>(
                        builder: (context, state) {
                          if (state is VouchersLoaded) {
                            return SizedBox(
                                height: 260 * hem,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.vouchers.length,
                                  itemBuilder: (context, index) {
                                    return VoucherCard(
                                      fem: fem,
                                      hem: hem,
                                      ffem: ffem,
                                      voucherModel: state.vouchers[index],
                                    );
                                  },
                                ));
                          }
                          return Center(
                              child: Lottie.asset(
                                  'assets/animations/loading-screen.json',
                                  width: 50 * fem,
                                  height: 50 * hem));
                        },
                      ),
                      SizedBox(
                        height: 15 * hem,
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 10 * hem,
                ),

                //Ưu đãi tốt
                Container(
                  color: kbgWhiteColor,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10 * fem),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ưu đãi tốt',
                              style: GoogleFonts.nunito(
                                  textStyle: TextStyle(
                                fontSize: 18 * ffem,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              )),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 5 * hem, right: 10 * fem),
                                child: Text(
                                  'Xem thêm',
                                  style: GoogleFonts.nunito(
                                      textStyle: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 12 * ffem,
                                    fontWeight: FontWeight.bold,
                                  )),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      BlocBuilder<VoucherBloc, VoucherState>(
                        builder: (context, state) {
                          if (state is VouchersLoaded) {
                            return Column(
                              children: [
                                ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.vouchers.length,
                                  itemBuilder: (context, index) {
                                    return VoucherListCard(
                                      fem: fem,
                                      hem: hem,
                                      ffem: ffem,
                                      voucherModel: state.vouchers[index],
                                      onPressed: (){
                                        
                                      },
                                    );
                                  },
                                ),
                              ],
                            );
                          }
                          return Center(
                              child: Lottie.asset(
                                  'assets/animations/loading-screen.json',
                                  width: 50 * fem,
                                  height: 50 * hem));
                        },
                      )
                    ],
                  ),
                ),
              ],
            )
          ]),
        )
      ],
    );
  }
}

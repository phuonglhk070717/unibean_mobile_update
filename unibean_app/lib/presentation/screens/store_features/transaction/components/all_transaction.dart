import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../../../blocs/blocs.dart';
import '../../../../config/constants.dart';
import '../../../../widgets/shimmer_widget.dart';
import 'transaction_card.dart';

class AllTransaction extends StatefulWidget {
  const AllTransaction({
    super.key,
    required this.hem,
    required this.fem,
    required this.ffem,
    required this.storeId,
  });

  final double hem;
  final double fem;
  final double ffem;
  final String storeId;

  @override
  State<AllTransaction> createState() => _AllTransactionState();
}

class _AllTransactionState extends State<AllTransaction> {
  ScrollController scrollTransactionController = ScrollController();

  @override
  void initState() {
    scrollTransactionController.addListener(() {
      context
          .read<StoreBloc>()
          .add(LoadMoreTransactionStore(scrollTransactionController));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollTransactionController,
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            Column(
              children: [
                SizedBox(
                  height: 25 * widget.hem,
                ),
                BlocBuilder<StoreBloc, StoreState>(
                  builder: (context, state) {
                    if (state is StoreTransactionLoading) {
                      return buildTransactionShimmer(5, widget.fem, widget.hem);
                    } else if (state is StoreTransactionsLoaded) {
                      var transactions = state.transactions;
                      if (transactions == null) {
                        return Center(
                            child: Lottie.asset(
                                'assets/animations/loading-screen.json'));
                      } else {
                        if (transactions.isEmpty) {
                          return Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(
                                left: 15 * widget.fem, right: 15 * widget.fem),
                            height: 220 * widget.hem,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/transaction-icon.svg',
                                  width: 60 * widget.fem,
                                  colorFilter: ColorFilter.mode(
                                      kLowTextColor, BlendMode.srcIn),
                                ),
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Text(
                                      'Không có lịch sử giao dịch',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      )),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10 * widget.fem,
                                ),
                              ],
                            ),
                          );
                        }
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.hasReachedMax
                              ? state.transactions!.length
                              : state.transactions!.length + 1,
                          itemBuilder: (context, index) {
                            if (index >= state.transactions!.length) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: kPrimaryColor,
                                ),
                              );
                            } else {
                              return TransactionCard(
                                fem: widget.fem,
                                hem: widget.hem,
                                ffem: widget.ffem,
                                transaction: state.transactions![index],
                              );
                            }
                          },
                        );
                      }
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ]),
        )
      ],
    );
  }
}

Widget buildTransactionShimmer(count, double fem, double hem) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: count,
        itemBuilder: (context, index) {
          return Container(
            margin:
                EdgeInsets.only(top: 15 * hem, left: 10 * fem, right: 10 * fem),
            padding: EdgeInsets.only(left: 10 * fem),
            constraints:
                BoxConstraints(maxHeight: 100 * hem, minWidth: 340 * fem),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15 * fem),
                color: Colors.white,
                border: Border.all(color: klighGreyColor),
                boxShadow: [
                  BoxShadow(
                      color: Color(0x0c000000),
                      offset: Offset(0 * fem, 0 * fem),
                      blurRadius: 5 * fem)
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ShimmerWidget.rectangular(
                      height: 15 * hem,
                      width: 300 * fem,
                    ),
                    ShimmerWidget.rectangular(
                      height: 15 * hem,
                      width: 300 * fem,
                    ),
                    ShimmerWidget.rectangular(
                      height: 15 * hem,
                      width: 300 * fem,
                    ),
                  ],
                ),
                SizedBox(
                  width: 10 * fem,
                ),
              ],
            ),
          );
        },
      ),
    ],
  );
}
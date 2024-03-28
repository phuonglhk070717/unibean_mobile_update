import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unibean_app/data/datasource/authen_local_datasource.dart';
import 'package:unibean_app/presentation/blocs/blocs.dart';
import 'package:unibean_app/presentation/config/constants.dart';
import 'package:unibean_app/presentation/screens/screens.dart';

import '../../../../data/models.dart';
import '../../../../domain/repositories.dart';
import 'components/form_transact.dart';
import 'components/information_card_profile.dart';

class TransactScreen extends StatefulWidget {
  static const String routeName = '/transact-screen';

  static Route route({required StudentModel studentModel}) {
    return MaterialPageRoute(
        builder: (_) => BlocProvider(
              create: (context) =>
                  StoreBloc(storeRepository: context.read<StoreRepository>()),
              child: TransactScreen(
                studentModel: studentModel,
              ),
            ),
        settings: const RouteSettings(arguments: routeName));
  }

  const TransactScreen({super.key, required this.studentModel});

  final StudentModel studentModel;

  @override
  State<TransactScreen> createState() => _TransactScreenState();
}

class _TransactScreenState extends State<TransactScreen> {
  TextEditingController beanController = TextEditingController();
  TextEditingController desController = TextEditingController();
  bool changed = false;

  @override
  void initState() {
    beanController.addListener(() {
      if (beanController.text != '') {
        setState(() {
          changed = true;
        });
      } else if (beanController.text == '') {
        setState(() {
          changed = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;
    return BlocListener<StoreBloc, StoreState>(
      listener: (context, state) {
        if (state is CreateBonusFailed) {
          print(state.error);
        } else if (state is CreateBonusLoading) {
          showDialog<String>(
              context: context,
              builder: (BuildContext context) {
                Future.delayed(Duration(seconds: 2), () {
                  Navigator.of(context).pop();
                });
                return AlertDialog(
                    content: Container(
                        width: 250,
                        height: 250,
                        child: Center(
                            child: CircularProgressIndicator(
                                color: kPrimaryColor))));
              });
        }else if (state is CreateBonusSucess) {
          Navigator.pushNamedAndRemoveUntil(context,
              SuccessTransactScreen.routeName, (Route<dynamic> route) => false,
              arguments: state.transactModel);
        }
      },
      child: SafeArea(
          child: Scaffold(
              backgroundColor: klighGreyColor,
              appBar: AppBar(
                elevation: 0,
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage('assets/images/background_splash.png'),
                          fit: BoxFit.cover)),
                ),
                leading: InkWell(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/landing-screen-store',
                        (Route<dynamic> route) => false);
                  },
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                    size: 25 * fem,
                  ),
                ),
                toolbarHeight: 50 * hem,
                centerTitle: true,
                title: Text(
                  'Tặng đậu xanh',
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          fontSize: 18 * ffem,
                          fontWeight: FontWeight.w900,
                          height: 1.3625 * ffem / fem,
                          color: Colors.white)),
                ),
                actions: [
                  // SvgPicture.asset('assets/icons/notification-icon.svg')
                  Padding(
                    padding: EdgeInsets.only(right: 20 * fem),
                    child: IconButton(
                      icon: Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 25 * fem,
                      ),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/landing-screen-store',
                            (Route<dynamic> route) => false);
                      },
                    ),
                  ),
                ],
              ),
              body: CustomScrollView(
                slivers: [
                  SliverList(
                      delegate: SliverChildListDelegate([
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        InformationCardProfile(
                            hem: hem,
                            fem: fem,
                            ffem: ffem,
                            studentModel: widget.studentModel),
                        SizedBox(
                          height: 20,
                        ),
                        FormTransact(
                          fem: fem,
                          hem: hem,
                          ffem: ffem,
                          beanController: beanController,
                          desController: desController,
                        )
                      ],
                    )
                  ]))
                ],
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: buildButtonTransact(
                  context,
                  fem,
                  hem,
                  ffem,
                  changed,
                  widget.studentModel.id,
                  beanController.text,
                  desController.text,
                  true))),
    );
  }
}

Widget buildButtonTransact(
    BuildContext context,
    double fem,
    double hem,
    double ffem,
    bool changed,
    String studentId,
    String amountString,
    String description,
    bool state) {
  if (changed) {
    return InkWell(
      onTap: () async {
        final storeId = await AuthenLocalDataSource.getStoreId();
        if (description == '') {
          description = 'Chúc bạn một ngày vui vẻ';
        }
        double amount = double.parse(amountString);
        context.read<StoreBloc>().add(CreateBonus(
            storeId: storeId!,
            studentId: studentId,
            amount: amount,
            description: description,
            state: state));
      },
      child: Container(
        width: 220 * fem,
        height: 40 * hem,
        decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(10 * fem)),
        child: Center(
          child: Text(
            'Chuyển ngay',
            style: GoogleFonts.openSans(
                textStyle: TextStyle(
                    fontSize: 15 * ffem,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
        ),
      ),
    );
  } else {
    return Container(
      width: 220 * fem,
      height: 40 * hem,
      decoration: BoxDecoration(
          color: kLowTextColor, borderRadius: BorderRadius.circular(10 * fem)),
      child: Center(
        child: Text(
          'Chuyển ngay',
          style: GoogleFonts.openSans(
              textStyle: TextStyle(
                  fontSize: 15 * ffem,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ),
      ),
    );
  }
}

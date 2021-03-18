import 'package:conversor_moeda_jpvp/homeScreen.dart';
import 'package:conversor_moeda_jpvp/get/LoadClosures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share/share.dart';
import 'controller/ConvertController.dart';
import 'controller/TextFormFieldValidator.dart';
import 'controller/VisibilityController.dart';

double usd, usdt, eur, gbp, cad, aud, ars, jpy, cny, chf, ils, brl; // ["high"]
double brlPct,
    usdPct,
    usdtPct,
    eurPct,
    gbpPct,
    cadPct,
    audPct,
    arsPct,
    jpyPct,
    cnyPct,
    chfPct,
    ilsPct; // ["pctChange"]
double brlResult,
    usdResult,
    usdtResult,
    eurResult,
    gbpResult,
    cadResult,
    audResult,
    arsResult,
    jpyResult,
    cnyResult,
    chfResult,
    ilsResult; // resultado do cálculo
String brlFlag,
    usdFlag,
    usdtFlag,
    eurFlag,
    gbpFlag,
    cadFlag,
    audFlag,
    arsFlag,
    jpyFlag,
    cnyFlag,
    chfFlag,
    ilsFlag; // resultado do cálculo
String currencyFlag = 'BRL'; //bandeira selecionada.
double currency = brl; //Valor da moeda no json.
double inputNumber;

// FIM VARIÁVEIS //

class CurrencyList extends StatefulWidget {
  CurrencyList({Key key}) : super(key: key);

  @override
  _CurrencyListState createState() => _CurrencyListState();
}

class _CurrencyListState extends State<CurrencyList> {
  ConvertCurrency convertCurrency =
      ConvertCurrency(); //Controlador de Conversão
  ShowContainer showContainer =
      ShowContainer(); //Controlador de visibilidade dos Container
  TextValidator textValidator =
      TextValidator(); //Controlador validador do TextFormField
  final keyForm = GlobalKey<FormState>();

  List<Map> flagsJson = [
    {'id': 'BRL', 'image': 'assets/flags/png/br.png', 'name': 'BRL R\$:'},
    {'id': 'USD', 'image': 'assets/flags/png/us.png', 'name': 'USD \$:'},
    {'id': 'USDT', 'image': 'assets/flags/png/us.png', 'name': 'USDT \$:'},
    {'id': 'EUR', 'image': 'assets/flags/png/eu.png', 'name': 'EUR €:'},
    {'id': 'GBP', 'image': 'assets/flags/png/sh.png', 'name': 'GBP £:'},
    {'id': 'CAD', 'image': 'assets/flags/png/ca.png', 'name': 'CAD C\$:'},
    {'id': 'AUD', 'image': 'assets/flags/png/au.png', 'name': 'AUD A\$:'},
    {'id': 'ARS', 'image': 'assets/flags/png/ar.png', 'name': 'ARS \$:'},
    {'id': 'JPY', 'image': 'assets/flags/png/jp.png', 'name': 'JPY ¥:'},
    {'id': 'CNY', 'image': 'assets/flags/png/cn.png', 'name': 'CNY ¥:'},
    {'id': 'CHF', 'image': 'assets/flags/png/ch.png', 'name': 'CHF Fr:'},
    {'id': 'ILS', 'image': 'assets/flags/png/il.png', 'name': 'ILS ₪:'}
  ];
  String dropdownValue = 'BRL'; //Valor inicial do DropDown

  Object get flagItem => null;

  //Controller com casas decimais

  TextEditingController inputValue = TextEditingController();

  InterstitialAd _bannerInterstitial;

  @override
  void initState() {
    super.initState();
    _bannerInterstitial = InterstitialAd(
      adUnitId: 'ca-app-pub-9464403316889483/2755938893',
      request: AdRequest(),
      listener: AdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) => print('Ad Interstitial loaded.'),
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Ad Interstitial failed to load: $error');
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) => print('Ad Interstitial opened.'),
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) => print('Ad Interstitial closed.'),
        // Called when an ad is in the process of leaving the application.
        onApplicationExit: (Ad ad) => print('Left application.'),
      ),
    );

    _bannerInterstitial?.load();
  }

  @override
  void dispose() {
    super.dispose();
    _bannerInterstitial?.dispose();
    _bannerInterstitial = null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 32, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, //Online de Moedas
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Conversor",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w700),
                    ),
                    Container(
                      child: Row(
                        //REVER
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.share_outlined),
                            color: Colors.white,
                            iconSize: 25,
                            onPressed: () {
                              final RenderBox box = context.findRenderObject();
                              Share.share(linkApp,
                                  subject: subText,
                                  sharePositionOrigin:
                                      box.localToGlobal(Offset.zero) &
                                          box.size);
                            },
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          //CircleAvatar(
                          //  radius: 25,
                          //  backgroundColor: Colors.white,
                          //  child: ClipOval(
                          //    child: Image.asset(
                          //      "assets/photo.jpeg",
                          //      fit: BoxFit.contain,
                          //    ),
                          //  ),
                          //)
                        ],
                      ),
                    )
                  ],
                ),
                Text(
                  "de Moedas",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.grey),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  margin: EdgeInsets.symmetric(),
                  height: 300,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 60.0,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(243, 245, 248, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18))),
                              // ignore: deprecated_member_use
                              child: FlatButton(
                                child: Text(
                                  "\$",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 30),
                                ),
                                color: Color.fromRGBO(243, 245, 248, 1),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: Row(children: [
                                        Column(
                                          children: [
                                            Image.asset(
                                              'assets/flags/png/us.png',
                                              height: 60,
                                              width: 42,
                                              fit: BoxFit.contain,
                                            )
                                          ],
                                        ),
                                        Text('  USD - Dólar Comercial'),
                                      ]),
                                      content: LoadClosureUSD(),
                                      actions: [
                                        // Container(
                                        //   alignment: Alignment.centerLeft,
                                        //   child: ClipPath(
                                        //     child: Image.asset(
                                        //       'assets/flags/png/us.png',
                                        //       height: 60,
                                        //       width: 42,
                                        //     ),
                                        //   ),
                                        //   //Altura do bloco retangular branco
                                        //   padding: EdgeInsets.all(0),
                                        // ),
                                        // ignore: deprecated_member_use
                                        FlatButton(
                                          textColor: Colors.black,
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Fechar'),
                                        ),
                                      ],
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(18))),
                                      contentPadding: EdgeInsets.all(12.0),
                                      insetPadding:
                                          EdgeInsets.symmetric(vertical: 100),
                                    ),
                                  );
                                },
                              ),
                              padding: EdgeInsets.all(5),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "USD",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 60.0,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(243, 245, 248, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18))),
                              // ignore: deprecated_member_use
                              child: FlatButton(
                                child: Text(
                                  "\$",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 30),
                                ),
                                color: Color.fromRGBO(243, 245, 248, 1),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: Row(children: [
                                        Column(
                                          children: [
                                            Image.asset(
                                              'assets/flags/png/us.png',
                                              height: 60,
                                              width: 42,
                                              fit: BoxFit.contain,
                                            )
                                          ],
                                        ),
                                        Text('  USDT - Dólar Turismo'),
                                      ]),
                                      content: LoadClosureUSDT(),
                                      actions: [
                                        // ignore: deprecated_member_use
                                        FlatButton(
                                          textColor: Colors.black,
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Fechar'),
                                        ),
                                      ],
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(18))),
                                      contentPadding: EdgeInsets.all(12.0),
                                      insetPadding:
                                          EdgeInsets.symmetric(vertical: 100),
                                    ),
                                  );
                                },
                              ),
                              padding: EdgeInsets.all(5),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "USDT",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 60.0,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(243, 245, 248, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18))),
                              // ignore: deprecated_member_use
                              child: FlatButton(
                                child: Text(
                                  "€",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 30),
                                ),
                                color: Color.fromRGBO(243, 245, 248, 1),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: Row(children: [
                                        Column(
                                          children: [
                                            Image.asset(
                                              'assets/flags/png/eu.png',
                                              height: 60,
                                              width: 42,
                                              fit: BoxFit.contain,
                                            )
                                          ],
                                        ),
                                        Text('  EUR - Euro'),
                                      ]),
                                      content: LoadClosureEUR(),
                                      actions: [
                                        // ignore: deprecated_member_use
                                        FlatButton(
                                          textColor: Colors.black,
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Fechar'),
                                        ),
                                      ],
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(18))),
                                      contentPadding: EdgeInsets.all(12.0),
                                      insetPadding:
                                          EdgeInsets.symmetric(vertical: 100),
                                    ),
                                  );
                                },
                              ),
                              padding: EdgeInsets.all(5),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "EUR",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 60.0,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(243, 245, 248, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18))),
                              // ignore: deprecated_member_use
                              child: FlatButton(
                                child: Text(
                                  "£",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 30),
                                ),
                                color: Color.fromRGBO(243, 245, 248, 1),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: Row(children: [
                                        Column(
                                          children: [
                                            Image.asset(
                                              'assets/flags/png/sh.png',
                                              height: 60,
                                              width: 42,
                                              fit: BoxFit.contain,
                                            )
                                          ],
                                        ),
                                        Text('  GBP - Libra Esterlina'),
                                      ]),
                                      content: LoadClosureGBP(),
                                      actions: [
                                        // ignore: deprecated_member_use
                                        FlatButton(
                                          textColor: Colors.black,
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Fechar'),
                                        ),
                                      ],
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(18))),
                                      contentPadding: EdgeInsets.all(12.0),
                                      insetPadding:
                                          EdgeInsets.symmetric(vertical: 100),
                                    ),
                                  );
                                },
                              ),
                              padding: EdgeInsets.all(5),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "GBP",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 70.0,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(243, 245, 248, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18))),
                              // ignore: deprecated_member_use
                              child: FlatButton(
                                child: Text(
                                  "C\$",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 22),
                                ),
                                color: Color.fromRGBO(243, 245, 248, 1),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: Row(children: [
                                        Column(
                                          children: [
                                            Image.asset(
                                              'assets/flags/png/ca.png',
                                              height: 60,
                                              width: 42,
                                              fit: BoxFit.contain,
                                            )
                                          ],
                                        ),
                                        Text('  CAD - Dólar Canadense'),
                                      ]),
                                      content: LoadClosureCAD(),
                                      actions: [
                                        // ignore: deprecated_member_use
                                        FlatButton(
                                          textColor: Colors.black,
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Fechar'),
                                        ),
                                      ],
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(18))),
                                      contentPadding: EdgeInsets.all(12.0),
                                      insetPadding:
                                          EdgeInsets.symmetric(vertical: 100),
                                    ),
                                  );
                                },
                              ),
                              padding: EdgeInsets.all(5),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "CAD",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 70.0,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(243, 245, 248, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18))),
                              // ignore: deprecated_member_use
                              child: FlatButton(
                                child: Text(
                                  "A\$",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 22),
                                ),
                                color: Color.fromRGBO(243, 245, 248, 1),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: Row(children: [
                                        Column(
                                          children: [
                                            Image.asset(
                                              'assets/flags/png/au.png',
                                              height: 60,
                                              width: 42,
                                              fit: BoxFit.contain,
                                            )
                                          ],
                                        ),
                                        Text('  AUD - Dólar Australiano'),
                                      ]),
                                      content: LoadClosureAUD(),
                                      actions: [
                                        // ignore: deprecated_member_use
                                        FlatButton(
                                          textColor: Colors.black,
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Fechar'),
                                        ),
                                      ],
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(18))),
                                      contentPadding: EdgeInsets.all(12.0),
                                      insetPadding:
                                          EdgeInsets.symmetric(vertical: 100),
                                    ),
                                  );
                                },
                              ),
                              padding: EdgeInsets.all(5),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "AUD",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 60.0,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(243, 245, 248, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18))),
                              // ignore: deprecated_member_use
                              child: FlatButton(
                                child: Text(
                                  "\$",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 30),
                                ),
                                color: Color.fromRGBO(243, 245, 248, 1),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: Row(children: [
                                        Column(
                                          children: [
                                            Image.asset(
                                              'assets/flags/png/ar.png',
                                              height: 60,
                                              width: 42,
                                              fit: BoxFit.contain,
                                            )
                                          ],
                                        ),
                                        Text('  ARS - Peso Argentino'),
                                      ]),
                                      content: LoadClosureARS(),
                                      actions: [
                                        // ignore: deprecated_member_use
                                        FlatButton(
                                          textColor: Colors.black,
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Fechar'),
                                        ),
                                      ],
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(18))),
                                      contentPadding: EdgeInsets.all(12.0),
                                      insetPadding:
                                          EdgeInsets.symmetric(vertical: 100),
                                    ),
                                  );
                                },
                              ),
                              padding: EdgeInsets.all(5),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "ARS",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 60.0,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(243, 245, 248, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18))),
                              // ignore: deprecated_member_use
                              child: FlatButton(
                                child: Text(
                                  "¥",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 30),
                                ),
                                color: Color.fromRGBO(243, 245, 248, 1),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: Row(children: [
                                        Column(
                                          children: [
                                            Image.asset(
                                              'assets/flags/png/jp.png',
                                              height: 60,
                                              width: 42,
                                              fit: BoxFit.contain,
                                            )
                                          ],
                                        ),
                                        Text('  JPY - Iene Japonês'),
                                      ]),
                                      content: LoadClosureJPY(),
                                      actions: [
                                        // ignore: deprecated_member_use
                                        FlatButton(
                                          textColor: Colors.black,
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Fechar'),
                                        ),
                                      ],
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(18))),
                                      contentPadding: EdgeInsets.all(12.0),
                                      insetPadding:
                                          EdgeInsets.symmetric(vertical: 100),
                                    ),
                                  );
                                },
                              ),
                              padding: EdgeInsets.all(5),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "JPY",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 60.0,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(243, 245, 248, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18))),
                              // ignore: deprecated_member_use
                              child: FlatButton(
                                child: Text(
                                  "¥",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 30),
                                ),
                                color: Color.fromRGBO(243, 245, 248, 1),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: Row(children: [
                                        Column(
                                          children: [
                                            Image.asset(
                                              'assets/flags/png/cn.png',
                                              height: 60,
                                              width: 42,
                                              fit: BoxFit.contain,
                                            )
                                          ],
                                        ),
                                        Text('  CNY - Yuan Chinês'),
                                      ]),
                                      content: LoadClosureCNY(),
                                      actions: [
                                        // ignore: deprecated_member_use
                                        FlatButton(
                                          textColor: Colors.black,
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Fechar'),
                                        ),
                                      ],
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(18))),
                                      contentPadding: EdgeInsets.all(12.0),
                                      insetPadding:
                                          EdgeInsets.symmetric(vertical: 100),
                                    ),
                                  );
                                },
                              ),
                              padding: EdgeInsets.all(5),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "CNY",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 70.0,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(243, 245, 248, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18))),
                              // ignore: deprecated_member_use
                              child: FlatButton(
                                child: Text(
                                  "Fr",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 22),
                                ),
                                color: Color.fromRGBO(243, 245, 248, 1),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: Row(children: [
                                        Column(
                                          children: [
                                            Image.asset(
                                              'assets/flags/png/ch.png',
                                              height: 60,
                                              width: 42,
                                              fit: BoxFit.contain,
                                            )
                                          ],
                                        ),
                                        Text('  CHF - Franco Suíço'),
                                      ]),
                                      content: LoadClosureCHF(),
                                      actions: [
                                        // ignore: deprecated_member_use
                                        FlatButton(
                                          textColor: Colors.black,
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Fechar'),
                                        ),
                                      ],
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(18))),
                                      contentPadding: EdgeInsets.all(12.0),
                                      insetPadding:
                                          EdgeInsets.symmetric(vertical: 100),
                                    ),
                                  );
                                },
                              ),
                              padding: EdgeInsets.all(5),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "CHF",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 60.0,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(243, 245, 248, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18))),
                              // ignore: deprecated_member_use
                              child: FlatButton(
                                child: Text(
                                  "₪",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 30),
                                ),
                                color: Color.fromRGBO(243, 245, 248, 1),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: Row(children: [
                                        Column(
                                          children: [
                                            Image.asset(
                                              'assets/flags/png/il.png',
                                              height: 60,
                                              width: 42,
                                              fit: BoxFit.contain,
                                            )
                                          ],
                                        ),
                                        Text('  ILS - Novo Shekel Israelense'),
                                      ]),
                                      content: LoadClosureILS(),
                                      actions: [
                                        // ignore: deprecated_member_use
                                        FlatButton(
                                          textColor: Colors.black,
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Fechar'),
                                        ),
                                      ],
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(18))),
                                      contentPadding: EdgeInsets.all(12.0),
                                      insetPadding:
                                          EdgeInsets.symmetric(vertical: 100),
                                    ),
                                  );
                                },
                              ),
                              padding: EdgeInsets.all(5),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "ILS",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 24,
          ),
          //Folha arrastável (Card Branco)
          DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(243, 245, 248, 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Moedas",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 24,
                                  color: Colors.grey[900]),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 32),
                      ),
                      SizedBox(
                        height: 24,
                      ),

                      Container(
                        child: Text(
                          "SELECIONE A MOEDA",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[500]),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 32),
                      ),

                      SizedBox(
                        height: 16, //Espaço filtros dos cards de moedas
                      ),

                      Container(
                        //BRL - Real
                        margin: EdgeInsets.symmetric(horizontal: 32),
                        //height: 150, Altura do bloco
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Row(
                          children: <Widget>[
                            //AQUI VAI O MENU DROP
                            DropdownButton<String>(
                              value: dropdownValue,
                              icon: Icon(Icons.arrow_drop_down),
                              //iconSize: 30,

                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey[900]),
                              underline: Container(
                                height: 2,
                                color: Colors.white,
                              ),
                              onChanged: (String newValue) {
                                setState(
                                  () {
                                    dropdownValue = newValue;
                                    currencyFlag =
                                        dropdownValue; //vÁRIAVEL QUE RECEBE O ID DA MOEDA

                                    if (currencyFlag == 'BRL') {
                                      currency = brl;
                                      showContainer.showBRLfunc();
                                    }
                                    if (currencyFlag == 'USD') {
                                      currency = usd;
                                      showContainer.showUSDfunc();
                                    } else {}
                                    if (currencyFlag == 'USDT') {
                                      currency = usdt;
                                      showContainer.showUSDTfunc();
                                    } else {}
                                    if (currencyFlag == 'EUR') {
                                      currency = eur;
                                      showContainer.showEURfunc();
                                    } else {}
                                    if (currencyFlag == 'GBP') {
                                      currency = gbp;
                                      showContainer.showGBPfunc();
                                    } else {}
                                    if (currencyFlag == 'CAD') {
                                      currency = cad;
                                      showContainer.showCADfunc();
                                    } else {}
                                    if (currencyFlag == 'AUD') {
                                      currency = aud;
                                      showContainer.showAUDfunc();
                                    } else {}
                                    if (currencyFlag == 'ARS') {
                                      currency = ars;
                                      showContainer.showARSfunc();
                                    } else {}
                                    if (currencyFlag == 'JPY') {
                                      currency = jpy;
                                      showContainer.showJPYfunc();
                                    } else {}
                                    if (currencyFlag == 'CNY') {
                                      currency = cny;
                                      showContainer.showCNYfunc();
                                    } else {}
                                    if (currencyFlag == 'CHF') {
                                      currency = chf;
                                      showContainer.showCHFfunc();
                                    } else {}
                                    if (currencyFlag == 'ILS') {
                                      currency = ils;
                                      showContainer.showILSfunc();
                                    } else {}
                                  },
                                );
                              },
                              items: flagsJson.map(
                                (flagItem) {
                                  return DropdownMenuItem(
                                    value: flagItem['id'].toString(),
                                    child: Row(
                                      children: [
                                        Image.asset(flagItem['image'],
                                            width: 25),
                                        Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: Text(flagItem['name']),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                            Expanded(
                              child: TextFormField(
                                  key: keyForm,
                                  controller: inputValue,
                                  cursorColor: Colors.black,
                                  style: TextStyle(fontSize: 16.0),
                                  keyboardType: TextInputType.number,
                                  autofocus: false,
                                  onChanged: textValidator.setTextValue,
                                  decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        left: 15,
                                        bottom: 11,
                                        top: 11,
                                        right: 15),
                                    hintText: "Digite um valor",
                                    hintStyle: TextStyle(fontSize: 16),
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'(^-?\d*\.?\d{0,2})'))
                                  ]),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12, //Espaço filtros dos cards de moedas
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 32),
                        width: double.infinity,
                        //height: 150, Altura do bloco
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: ButtonTheme(
                                padding: EdgeInsets.all(30.0),
                                // ignore: deprecated_member_use
                                child: Observer(
                                  builder: (_) {
                                    // ignore: deprecated_member_use
                                    return RaisedButton(
                                      child: Text("Converter"),
                                      onPressed: textValidator.isTextdValid
                                          ? () {
                                              inputNumber =
                                                  double.parse(inputValue.text);
                                              convertCurrency.calculateBRL();
                                              convertCurrency.calculateUSD();
                                              convertCurrency.calculateUSDT();
                                              convertCurrency.calculateEUR();
                                              convertCurrency.calculateGBP();
                                              convertCurrency.calculateCAD();
                                              convertCurrency.calculateAUD();
                                              convertCurrency.calculateARS();
                                              convertCurrency.calculateJPY();
                                              convertCurrency.calculateCNY();
                                              convertCurrency.calculateCHF();
                                              convertCurrency.calculateILS();

                                              _bannerInterstitial.show();
                                            }
                                          : null,
                                      color: Colors.grey[900],
                                      textColor: Colors.white,
                                      disabledColor: Colors.white,
                                      padding: EdgeInsets.all(8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 12, //Espaço filtros dos cards de moedas
                      ),
                      //Container Listview for expenses and incomes
                      Container(
                        child: Text(
                          "MOEDAS A CONVERTER",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[500]),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 32),
                      ),
                      SizedBox(
                        height: 12, //Espaço filtros dos cards de moedas
                      ),

                      //BRL - REAL
                      Observer(builder: (_) {
                        return Visibility(
                          visible: showContainer.showBRL,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 32),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: ClipPath(
                                    child: Image.asset(
                                      'assets/flags/png/br.png',
                                      height: 60,
                                      width: 42,
                                    ),
                                  ),
                                  //Altura do bloco retangular branco
                                  padding: EdgeInsets.all(0),
                                ),
                                SizedBox(
                                  width: 16, //Espaço icone do texto
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "BRL",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[900]),
                                      ),
                                      Text(
                                        "Real",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[500]),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Observer(builder: (_) {
                                      return Text(
                                        "R\$: ${convertCurrency.brlResult}", //Campo de digitar a moeda
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[900]),
                                      );
                                    }),
                                    // brlPct >= 0
                                    //     ? Text(
                                    //         "▲+$brlPct %",
                                    //         style: TextStyle(
                                    //             fontSize: 15,
                                    //             fontWeight: FontWeight.w700,
                                    //             color: Colors.lightGreen),
                                    //       )
                                    //     : Text(
                                    //         "$brlPct %",
                                    //         style: TextStyle(
                                    //             fontSize: 15,
                                    //             fontWeight: FontWeight.w700,
                                    //             color: Colors.red[600]),
                                    //       ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),

                      SizedBox(
                        height: 12, //Espaço filtros dos cards de moedas
                      ),

                      //USD - DÓLAR COMERCIAL
                      Observer(builder: (_) {
                        return Visibility(
                          visible: showContainer.showUSD,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 32),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: ClipPath(
                                    child: Image.asset(
                                      'assets/flags/png/us.png',
                                      height: 60,
                                      width: 42,
                                    ),
                                  ),
                                  //Altura do bloco retangular branco
                                  padding: EdgeInsets.all(0),
                                ),
                                SizedBox(
                                  width: 16, //Espaço icone do texto
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "USD",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[900]),
                                      ),
                                      Text(
                                        "Dólar Comercial",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[500]),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Observer(builder: (_) {
                                      return Text(
                                        "\$: ${convertCurrency.usdResult} ", //Campo de digitar a moeda
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[900]),
                                      );
                                    }),
                                    usdPct >= 0
                                        ? Text(
                                            "▲+$usdPct%",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.lightGreen),
                                          )
                                        : Text(
                                            "▼$usdPct%",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.red[600]),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      SizedBox(
                        height: 12, //Espaço filtros dos cards de moedas
                      ),

                      //USDT - DÓLAR TURISMO
                      Observer(builder: (_) {
                        return Visibility(
                          visible: showContainer.showUSDT,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 32),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: ClipPath(
                                    child: Image.asset(
                                      'assets/flags/png/us.png',
                                      height: 60,
                                      width: 42,
                                    ),
                                  ),
                                  //Altura do bloco retangular branco
                                  padding: EdgeInsets.all(0),
                                ),
                                SizedBox(
                                  width: 16, //Espaço icone do texto
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "USDT",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[900]),
                                      ),
                                      Text(
                                        "Dólar Turismo",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[500]),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Observer(builder: (_) {
                                      return Text(
                                        "\$: ${convertCurrency.usdtResult}", //Campo de digitar a moeda
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[900]),
                                      );
                                    }),
                                    usdtPct >= 0
                                        ? Text(
                                            "▲+$usdtPct%",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.lightGreen),
                                          )
                                        : Text(
                                            "▼$usdtPct%",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.red[600]),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      SizedBox(
                        height: 12, //Espaço filtros dos cards de moedas
                      ),

                      //EUR - EURO
                      Observer(builder: (_) {
                        return Visibility(
                          visible: showContainer.showEUR,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 32),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: ClipPath(
                                    child: Image.asset(
                                      'assets/flags/png/eu.png',
                                      height: 60,
                                      width: 42,
                                    ),
                                  ),
                                  //Altura do bloco retangular branco
                                  padding: EdgeInsets.all(0),
                                ),
                                SizedBox(
                                  width: 16, //Espaço icone do texto
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "EUR",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[900]),
                                      ),
                                      Text(
                                        "Euro",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[500]),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Observer(builder: (_) {
                                      return Text(
                                        "€: ${convertCurrency.eurResult}", //Campo de digitar a moeda
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[900]),
                                      );
                                    }),
                                    eurPct >= 0
                                        ? Text(
                                            "▲+$eurPct%",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.lightGreen),
                                          )
                                        : Text(
                                            "▼$eurPct%",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.red[600]),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      SizedBox(
                        height: 12, //Espaço filtros dos cards de moedas
                      ),

                      //GBP - LIBRA ESTERLINA
                      Observer(builder: (_) {
                        return Visibility(
                          visible: showContainer.showGBP,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 32),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: ClipPath(
                                    child: Image.asset(
                                      'assets/flags/png/sh.png',
                                      height: 60,
                                      width: 42,
                                    ),
                                  ),
                                  //Altura do bloco retangular branco
                                  padding: EdgeInsets.all(0),
                                ),
                                SizedBox(
                                  width: 16, //Espaço icone do texto
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "GBP",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[900]),
                                      ),
                                      Text(
                                        "Libra Esterlina",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[500]),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Observer(builder: (_) {
                                      return Text(
                                        "£: ${convertCurrency.gbpResult}", //Campo de digitar a moeda
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[900]),
                                      );
                                    }),
                                    gbpPct >= 0
                                        ? Text(
                                            "▲+$gbpPct%",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.lightGreen),
                                          )
                                        : Text(
                                            "▼$gbpPct%",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.red[600]),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      SizedBox(
                        height: 12, //Espaço filtros dos cards de moedas
                      ),

                      //CAD - DÓLAR CANADENSE
                      Observer(builder: (_) {
                        return Visibility(
                          visible: showContainer.showCAD,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 32),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: ClipPath(
                                    child: Image.asset(
                                      'assets/flags/png/ca.png',
                                      height: 60,
                                      width: 42,
                                    ),
                                  ),
                                  //Altura do bloco retangular branco
                                  padding: EdgeInsets.all(0),
                                ),
                                SizedBox(
                                  width: 16, //Espaço icone do texto
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "CAD",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[900]),
                                      ),
                                      Text(
                                        "Dólar Canadense",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[500]),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Observer(builder: (_) {
                                      return Text(
                                        "C\$: ${convertCurrency.cadResult}", //Campo de digitar a moeda
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[900]),
                                      );
                                    }),
                                    cadPct >= 0
                                        ? Text(
                                            "▲+$cadPct%",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.lightGreen),
                                          )
                                        : Text(
                                            "▼$cadPct%",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.red[600]),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      SizedBox(
                        height: 12, //Espaço filtros dos cards de moedas
                      ),

                      //AUD - DÓLAR AUSTRALIANO
                      Observer(builder: (_) {
                        return Visibility(
                          visible: showContainer.showAUD,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 32),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: ClipPath(
                                    child: Image.asset(
                                      'assets/flags/png/au.png',
                                      height: 60,
                                      width: 42,
                                    ),
                                  ),
                                  //Altura do bloco retangular branco
                                  padding: EdgeInsets.all(0),
                                ),
                                SizedBox(
                                  width: 16, //Espaço icone do texto
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "AUD",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[900]),
                                      ),
                                      Text(
                                        "Dólar Australiano",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[500]),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Observer(builder: (_) {
                                      return Text(
                                        "A\$: ${convertCurrency.audResult}", //Campo de digitar a moeda
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[900]),
                                      );
                                    }),
                                    audPct >= 0
                                        ? Text(
                                            "▲+$audPct%",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.lightGreen),
                                          )
                                        : Text(
                                            "▼$audPct%",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.red[600]),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      SizedBox(
                        height: 12, //Espaço filtros dos cards de moedas
                      ),

                      //ARS - Peso Argentino
                      Observer(builder: (_) {
                        return Visibility(
                          visible: showContainer.showARS,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 32),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: ClipPath(
                                    child: Image.asset(
                                      'assets/flags/png/ar.png',
                                      height: 60,
                                      width: 42,
                                    ),
                                  ),
                                  //Altura do bloco retangular branco
                                  padding: EdgeInsets.all(0),
                                ),
                                SizedBox(
                                  width: 16, //Espaço icone do texto
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "ARS",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[900]),
                                      ),
                                      Text(
                                        "Peso Argentino",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[500]),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Observer(builder: (_) {
                                      return Text(
                                        "\$: ${convertCurrency.arsResult}", //Campo de digitar a moeda
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[900]),
                                      );
                                    }),
                                    arsPct >= 0
                                        ? Text(
                                            "▲+$arsPct%",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.lightGreen),
                                          )
                                        : Text(
                                            "▼$arsPct%",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.red[600]),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      SizedBox(
                        height: 12, //Espaço filtros dos cards de moedas
                      ),

                      //JPY - ENE JAPONÊS
                      Observer(builder: (_) {
                        return Visibility(
                          visible: showContainer.showJPY,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 32),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: ClipPath(
                                    child: Image.asset(
                                      'assets/flags/png/jp.png',
                                      height: 60,
                                      width: 42,
                                    ),
                                  ),
                                  //Altura do bloco retangular branco
                                  padding: EdgeInsets.all(0),
                                ),
                                SizedBox(
                                  width: 16, //Espaço icone do texto
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "JPY",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[900]),
                                      ),
                                      Text(
                                        "Iene Japonês",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[500]),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Observer(builder: (_) {
                                      return Text(
                                        "¥: ${convertCurrency.jpyResult}", //Campo de digitar a moeda
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[900]),
                                      );
                                    }),
                                    jpyPct >= 0
                                        ? Text(
                                            "▲+$jpyPct%",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.lightGreen),
                                          )
                                        : Text(
                                            "▼$jpyPct%",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.red[600]),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      SizedBox(
                        height: 12, //Espaço filtros dos cards de moedas
                      ),

                      //CNY - YUAN CHINÊS
                      Observer(builder: (_) {
                        return Visibility(
                          visible: showContainer.showCNY,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 32),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: ClipPath(
                                    child: Image.asset(
                                      'assets/flags/png/cn.png',
                                      height: 60,
                                      width: 42,
                                    ),
                                  ),
                                  //Altura do bloco retangular branco
                                  padding: EdgeInsets.all(0),
                                ),
                                SizedBox(
                                  width: 16, //Espaço icone do texto
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "CNY",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[900]),
                                      ),
                                      Text(
                                        "Yuan Chinês",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[500]),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Observer(builder: (_) {
                                      return Text(
                                        "¥: ${convertCurrency.cnyResult}", //Campo de digitar a moeda
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[900]),
                                      );
                                    }),
                                    cnyPct >= 0
                                        ? Text(
                                            "▲+$cnyPct%",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.lightGreen),
                                          )
                                        : Text(
                                            "▼$cnyPct%",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.red[600]),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      SizedBox(
                        height: 12, //Espaço filtros dos cards de moedas
                      ),

                      //CHF - FRANCO SUÍÇO
                      Observer(builder: (_) {
                        return Visibility(
                          visible: showContainer.showCHF,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 32),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: ClipPath(
                                    child: Image.asset(
                                      'assets/flags/png/ch.png',
                                      height: 60,
                                      width: 42,
                                    ),
                                  ),
                                  //Altura do bloco retangular branco
                                  padding: EdgeInsets.all(0),
                                ),
                                SizedBox(
                                  width: 16, //Espaço icone do texto
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "CHF",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[900]),
                                      ),
                                      Text(
                                        "Franco Suíço",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[500]),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Observer(builder: (_) {
                                      return Text(
                                        "Fr: ${convertCurrency.chfResult}", //Campo de digitar a moeda
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[900]),
                                      );
                                    }),
                                    chfPct >= 0
                                        ? Text(
                                            "▲+$chfPct%",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.lightGreen),
                                          )
                                        : Text(
                                            "▼$chfPct%",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.red[600]),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      SizedBox(
                        height: 12, //Espaço filtros dos cards de moedas
                      ),

                      //ils - NOVO SHEKEL ISRAELENSE
                      Observer(builder: (_) {
                        return Visibility(
                          visible: showContainer.showILS,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 32),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: ClipPath(
                                    child: Image.asset(
                                      'assets/flags/png/il.png',
                                      height: 60,
                                      width: 42,
                                    ),
                                  ),
                                  //Altura do bloco retangular branco
                                  padding: EdgeInsets.all(0),
                                ),
                                SizedBox(
                                  width: 16, //Espaço icone do texto
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "ILS",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[900]),
                                      ),
                                      Text(
                                        "Novo Shekel Israelense",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[500]),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Observer(builder: (_) {
                                      return Text(
                                        "₪: ${convertCurrency.ilsResult}", //Campo de digitar a moeda
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[900]),
                                      );
                                    }),
                                    ilsPct >= 0
                                        ? Text(
                                            "▲+$ilsPct%",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.lightGreen),
                                          )
                                        : Text(
                                            "▼$ilsPct%",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.red[600]),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      SizedBox(
                        height: 12, //Espaço filtros dos cards de moedas
                      ),
                      //DATA HORA
                      // Center(
                      //   //margin: EdgeInsets.symmetric(horizontal: 133),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "v 1.0.0",
                              style: TextStyle(
                                  fontSize: 13, color: Colors.grey[500]),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 32),
                      ),
                      SizedBox(
                        height: 12, //Espaço filtros dos cards de moedas
                      ),
                    ],
                  ),
                  controller: scrollController,
                ),
              );
            },
            initialChildSize: 0.65,
            minChildSize: 0.65,
            maxChildSize: 1,
          )
        ],
      ),
    );
  }
}

import 'package:conversor_moeda_jpvp/charts/chartARS.dart';
import 'package:conversor_moeda_jpvp/charts/chartAUD.dart';
import 'package:conversor_moeda_jpvp/charts/chartCAD.dart';
import 'package:conversor_moeda_jpvp/charts/chartCHF.dart';
import 'package:conversor_moeda_jpvp/charts/chartCNY.dart';
import 'package:conversor_moeda_jpvp/charts/chartEUR.dart';
import 'package:conversor_moeda_jpvp/charts/chartGBP.dart';
import 'package:conversor_moeda_jpvp/charts/chartILS.dart';
import 'package:conversor_moeda_jpvp/charts/chartJPY.dart';
import 'package:conversor_moeda_jpvp/charts/chartUSD.dart';
import 'package:conversor_moeda_jpvp/charts/chartUSDT.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';

// INÍCIO USD //
double closureUSD,
    usdHigh1D,
    usdHigh2D,
    usdHigh3D,
    usdHigh4D,
    usdHigh5D,
    usdHigh6D,
    usdHigh7D,
    usdHigh8D,
    usdHigh9D;

dynamic usdDay1,
    usdDay2,
    usdDay3,
    usdDay4,
    usdDay5,
    usdDay6,
    usdDay7,
    usdDay8,
    usdDay9;

//USD-BRL (Dólar Comercial)
const requestUSD = 'https://economia.awesomeapi.com.br/json/daily/USD-BRL/10';

//Função no que pega a string no futuro no site e transforma em formato json.
Future<List> getDataUSD() async {
  http.Response responseUSD =
      await http.get(requestUSD); //Solicita a string do servidor
  return json.decode(responseUSD.body); //Retorna a string convertida em json
}

class LoadClosureUSD extends StatefulWidget {
  @override
  _LoadClosureUSDState createState() => _LoadClosureUSDState();
}

class _LoadClosureUSDState extends State<LoadClosureUSD> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List>(
        future: getDataUSD(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Icon(
                    Icons.wifi_off,
                    color: Color.fromRGBO(243, 245, 248, 1),
                    size: 70,
                  ),
                );
              } else {
                //Valores
                usdHigh1D = double.parse(snapshot.data[1]["high"]);
                usdHigh2D = double.parse(snapshot.data[2]["high"]);
                usdHigh3D = double.parse(snapshot.data[3]["high"]);
                usdHigh4D = double.parse(snapshot.data[4]["high"]);
                usdHigh5D = double.parse(snapshot.data[5]["high"]);
                usdHigh6D = double.parse(snapshot.data[6]["high"]);
                usdHigh7D = double.parse(snapshot.data[7]["high"]);
                usdHigh8D = double.parse(snapshot.data[8]["high"]);
                usdHigh9D = double.parse(snapshot.data[9]["high"]);

                //Dias
                usdDay1 = int.parse(snapshot.data[1]["timestamp"]);
                usdDay1 =
                    new DateTime.fromMicrosecondsSinceEpoch(usdDay1 * 1000000);
                usdDay1 = int.parse(DateFormat('dd').format(usdDay1));
                usdDay1 = usdDay1.toString();

                usdDay2 = int.parse(snapshot.data[2]["timestamp"]);
                usdDay2 =
                    new DateTime.fromMicrosecondsSinceEpoch(usdDay2 * 1000000);
                usdDay2 = int.parse(DateFormat('dd').format(usdDay2));
                usdDay2 = usdDay2.toString();

                usdDay3 = int.parse(snapshot.data[3]["timestamp"]);
                usdDay3 =
                    new DateTime.fromMicrosecondsSinceEpoch(usdDay3 * 1000000);
                usdDay3 = int.parse(DateFormat('dd').format(usdDay3));
                usdDay3 = usdDay3.toString();

                usdDay4 = int.parse(snapshot.data[4]["timestamp"]);
                usdDay4 =
                    new DateTime.fromMicrosecondsSinceEpoch(usdDay4 * 1000000);
                usdDay4 = int.parse(DateFormat('dd').format(usdDay4));
                usdDay4 = usdDay4.toString();

                usdDay5 = int.parse(snapshot.data[5]["timestamp"]);
                usdDay5 =
                    new DateTime.fromMicrosecondsSinceEpoch(usdDay5 * 1000000);
                usdDay5 = int.parse(DateFormat('dd').format(usdDay5));
                usdDay5 = usdDay5.toString();

                usdDay6 = int.parse(snapshot.data[6]["timestamp"]);
                usdDay6 =
                    new DateTime.fromMicrosecondsSinceEpoch(usdDay6 * 1000000);
                usdDay6 = int.parse(DateFormat('dd').format(usdDay6));
                usdDay6 = usdDay6.toString();

                usdDay7 = int.parse(snapshot.data[7]["timestamp"]);
                usdDay7 =
                    new DateTime.fromMicrosecondsSinceEpoch(usdDay7 * 1000000);
                usdDay7 = int.parse(DateFormat('dd').format(usdDay7));
                usdDay7 = usdDay7.toString();

                usdDay8 = int.parse(snapshot.data[8]["timestamp"]);
                usdDay8 =
                    new DateTime.fromMicrosecondsSinceEpoch(usdDay8 * 1000000);
                usdDay8 = int.parse(DateFormat('dd').format(usdDay8));
                usdDay8 = usdDay8.toString();

                usdDay9 = int.parse(snapshot.data[9]["timestamp"]);
                usdDay9 =
                    new DateTime.fromMicrosecondsSinceEpoch(usdDay9 * 1000000);
                usdDay9 = int.parse(DateFormat('dd').format(usdDay9));
                usdDay9 = usdDay9.toString();

                print('✔ GET fechamento USD - Dólar');
                return ChartUSD();
              }
          }
        },
      ),
    );
  }
}
// FIM USD //

///////////////////////////////////////////////////////////////////////////////

//INÍCIO USDT //
double closureUSDT,
    usdtHigh0D,
    usdtHigh1D,
    usdtHigh2D,
    usdtHigh3D,
    usdtHigh4D,
    usdtHigh5D,
    usdtHigh6D,
    usdtHigh7D,
    usdtHigh8D,
    usdtHigh9D;

dynamic usdtDay1,
    usdtDay2,
    usdtDay3,
    usdtDay4,
    usdtDay5,
    usdtDay6,
    usdtDay7,
    usdtDay8,
    usdtDay9;

//USDT-BRL (Dólar Turismo)
const requestUSDT = 'https://economia.awesomeapi.com.br/json/daily/USDT-BRL/10';
Future<List> getDataUSDT() async {
  http.Response responseUSDT =
      await http.get(requestUSDT); //Solicita a string do servidor
  return json.decode(responseUSDT.body); //Retorna a string convertida em json
}

class LoadClosureUSDT extends StatefulWidget {
  @override
  _LoadClosureUSDTState createState() => _LoadClosureUSDTState();
}

class _LoadClosureUSDTState extends State<LoadClosureUSDT> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List>(
        future: getDataUSDT(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                  //child: CircularProgressIndicator(),
                  );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Icon(
                    Icons.wifi_off,
                    color: Color.fromRGBO(243, 245, 248, 1),
                    size: 70,
                  ),
                );
              } else {
                //Valores
                usdtHigh1D = double.parse(snapshot.data[1]["high"]);
                usdtHigh2D = double.parse(snapshot.data[2]["high"]);
                usdtHigh3D = double.parse(snapshot.data[3]["high"]);
                usdtHigh4D = double.parse(snapshot.data[4]["high"]);
                usdtHigh5D = double.parse(snapshot.data[5]["high"]);
                usdtHigh6D = double.parse(snapshot.data[6]["high"]);
                usdtHigh7D = double.parse(snapshot.data[7]["high"]);
                usdtHigh8D = double.parse(snapshot.data[8]["high"]);
                usdtHigh9D = double.parse(snapshot.data[9]["high"]);

                //Dias
                usdtDay1 = int.parse(snapshot.data[1]["timestamp"]);
                usdtDay1 =
                    new DateTime.fromMicrosecondsSinceEpoch(usdtDay1 * 1000000);
                usdtDay1 = int.parse(DateFormat('dd').format(usdtDay1));
                usdtDay1 = usdtDay1.toString();

                usdtDay2 = int.parse(snapshot.data[2]["timestamp"]);
                usdtDay2 =
                    new DateTime.fromMicrosecondsSinceEpoch(usdtDay2 * 1000000);
                usdtDay2 = int.parse(DateFormat('dd').format(usdtDay2));
                usdtDay2 = usdtDay2.toString();

                usdtDay3 = int.parse(snapshot.data[3]["timestamp"]);
                usdtDay3 =
                    new DateTime.fromMicrosecondsSinceEpoch(usdtDay3 * 1000000);
                usdtDay3 = int.parse(DateFormat('dd').format(usdtDay3));
                usdtDay3 = usdtDay3.toString();

                usdtDay4 = int.parse(snapshot.data[4]["timestamp"]);
                usdtDay4 =
                    new DateTime.fromMicrosecondsSinceEpoch(usdtDay4 * 1000000);
                usdtDay4 = int.parse(DateFormat('dd').format(usdtDay4));
                usdtDay4 = usdtDay4.toString();

                usdtDay5 = int.parse(snapshot.data[5]["timestamp"]);
                usdtDay5 =
                    new DateTime.fromMicrosecondsSinceEpoch(usdtDay5 * 1000000);
                usdtDay5 = int.parse(DateFormat('dd').format(usdtDay5));
                usdtDay5 = usdtDay5.toString();

                usdtDay6 = int.parse(snapshot.data[6]["timestamp"]);
                usdtDay6 =
                    new DateTime.fromMicrosecondsSinceEpoch(usdtDay6 * 1000000);
                usdtDay6 = int.parse(DateFormat('dd').format(usdtDay6));
                usdtDay6 = usdtDay6.toString();

                usdtDay7 = int.parse(snapshot.data[7]["timestamp"]);
                usdtDay7 =
                    new DateTime.fromMicrosecondsSinceEpoch(usdtDay7 * 1000000);
                usdtDay7 = int.parse(DateFormat('dd').format(usdtDay7));
                usdtDay7 = usdtDay7.toString();

                usdtDay8 = int.parse(snapshot.data[8]["timestamp"]);
                usdtDay8 =
                    new DateTime.fromMicrosecondsSinceEpoch(usdtDay8 * 1000000);
                usdtDay8 = int.parse(DateFormat('dd').format(usdtDay8));
                usdtDay8 = usdtDay8.toString();

                usdtDay9 = int.parse(snapshot.data[9]["timestamp"]);
                usdtDay9 =
                    new DateTime.fromMicrosecondsSinceEpoch(usdtDay9 * 1000000);
                usdtDay9 = int.parse(DateFormat('dd').format(usdtDay9));
                usdtDay9 = usdtDay9.toString();
                print('✔ GET fechamento USDT - Dólar Turismo');
                return ChartUSDT();
              }
          }
        },
      ),
    );
  }
}
//FIM USDT //

///////////////////////////////////////////////////////////////////////////////

// INÍCIO EUR //

double closureEUR,
    eurHigh0D,
    eurHigh1D,
    eurHigh2D,
    eurHigh3D,
    eurHigh4D,
    eurHigh5D,
    eurHigh6D,
    eurHigh7D,
    eurHigh8D,
    eurHigh9D;

dynamic eurDay1,
    eurDay2,
    eurDay3,
    eurDay4,
    eurDay5,
    eurDay6,
    eurDay7,
    eurDay8,
    eurDay9;
//EUR-BRL (Euro)
const requestEUR = 'https://economia.awesomeapi.com.br/json/daily/EUR-BRL/10';
Future<List> getDataEUR() async {
  http.Response responseEUR =
      await http.get(requestEUR); //Solicita a string do servidor
  return json.decode(responseEUR.body); //Retorna a string convertida em json
}

class LoadClosureEUR extends StatefulWidget {
  @override
  _LoadClosureEURState createState() => _LoadClosureEURState();
}

class _LoadClosureEURState extends State<LoadClosureEUR> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List>(
        future: getDataEUR(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                  //child: CircularProgressIndicator(),
                  );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Icon(
                    Icons.wifi_off,
                    color: Color.fromRGBO(243, 245, 248, 1),
                    size: 70,
                  ),
                );
              } else {
                //Valores
                eurHigh1D = double.parse(snapshot.data[1]["high"]);
                eurHigh2D = double.parse(snapshot.data[2]["high"]);
                eurHigh3D = double.parse(snapshot.data[3]["high"]);
                eurHigh4D = double.parse(snapshot.data[4]["high"]);
                eurHigh5D = double.parse(snapshot.data[5]["high"]);
                eurHigh6D = double.parse(snapshot.data[6]["high"]);
                eurHigh7D = double.parse(snapshot.data[7]["high"]);
                eurHigh8D = double.parse(snapshot.data[8]["high"]);
                eurHigh9D = double.parse(snapshot.data[9]["high"]);

                //Dias
                eurDay1 = int.parse(snapshot.data[1]["timestamp"]);
                eurDay1 =
                    new DateTime.fromMicrosecondsSinceEpoch(eurDay1 * 1000000);
                eurDay1 = int.parse(DateFormat('dd').format(eurDay1));
                eurDay1 = eurDay1.toString();

                eurDay2 = int.parse(snapshot.data[2]["timestamp"]);
                eurDay2 =
                    new DateTime.fromMicrosecondsSinceEpoch(eurDay2 * 1000000);
                eurDay2 = int.parse(DateFormat('dd').format(eurDay2));
                eurDay2 = eurDay2.toString();

                eurDay3 = int.parse(snapshot.data[3]["timestamp"]);
                eurDay3 =
                    new DateTime.fromMicrosecondsSinceEpoch(eurDay3 * 1000000);
                eurDay3 = int.parse(DateFormat('dd').format(eurDay3));
                eurDay3 = eurDay3.toString();

                eurDay4 = int.parse(snapshot.data[4]["timestamp"]);
                eurDay4 =
                    new DateTime.fromMicrosecondsSinceEpoch(eurDay4 * 1000000);
                eurDay4 = int.parse(DateFormat('dd').format(eurDay4));
                eurDay4 = eurDay4.toString();

                eurDay5 = int.parse(snapshot.data[5]["timestamp"]);
                eurDay5 =
                    new DateTime.fromMicrosecondsSinceEpoch(eurDay5 * 1000000);
                eurDay5 = int.parse(DateFormat('dd').format(eurDay5));
                eurDay5 = eurDay5.toString();

                eurDay6 = int.parse(snapshot.data[6]["timestamp"]);
                eurDay6 =
                    new DateTime.fromMicrosecondsSinceEpoch(eurDay6 * 1000000);
                eurDay6 = int.parse(DateFormat('dd').format(eurDay6));
                eurDay6 = eurDay6.toString();

                eurDay7 = int.parse(snapshot.data[7]["timestamp"]);
                eurDay7 =
                    new DateTime.fromMicrosecondsSinceEpoch(eurDay7 * 1000000);
                eurDay7 = int.parse(DateFormat('dd').format(eurDay7));
                eurDay7 = eurDay7.toString();

                eurDay8 = int.parse(snapshot.data[8]["timestamp"]);
                eurDay8 =
                    new DateTime.fromMicrosecondsSinceEpoch(eurDay8 * 1000000);
                eurDay8 = int.parse(DateFormat('dd').format(eurDay8));
                eurDay8 = eurDay8.toString();

                eurDay9 = int.parse(snapshot.data[9]["timestamp"]);
                eurDay9 =
                    new DateTime.fromMicrosecondsSinceEpoch(eurDay9 * 1000000);
                eurDay9 = int.parse(DateFormat('dd').format(eurDay9));
                eurDay9 = eurDay9.toString();
                print('✔ GET fechamento EUR - Euro');
                return ChartEUR();
              }
          }
        },
      ),
    );
  }
}
//FIM EUR //

///////////////////////////////////////////////////////////////////////////////

//INÍCIO GBP //

double closureGBP,
    gbpHigh0D,
    gbpHigh1D,
    gbpHigh2D,
    gbpHigh3D,
    gbpHigh4D,
    gbpHigh5D,
    gbpHigh6D,
    gbpHigh7D,
    gbpHigh8D,
    gbpHigh9D;

dynamic gbpDay1,
    gbpDay2,
    gbpDay3,
    gbpDay4,
    gbpDay5,
    gbpDay6,
    gbpDay7,
    gbpDay8,
    gbpDay9;
//GBP-BRL (Libra Esterlina)
const requestGBP = 'https://economia.awesomeapi.com.br/json/daily/GBP-BRL/10';
Future<List> getDataGBP() async {
  http.Response responseGBP =
      await http.get(requestGBP); //Solicita a string do servidor
  return json.decode(responseGBP.body); //Retorna a string convertida em json
}

class LoadClosureGBP extends StatefulWidget {
  @override
  _LoadClosureGBPState createState() => _LoadClosureGBPState();
}

class _LoadClosureGBPState extends State<LoadClosureGBP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List>(
        future: getDataGBP(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                  //child: CircularProgressIndicator(),
                  );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Icon(
                    Icons.wifi_off,
                    color: Color.fromRGBO(243, 245, 248, 1),
                    size: 70,
                  ),
                );
              } else {
                //Valores
                gbpHigh1D = double.parse(snapshot.data[1]["high"]);
                gbpHigh2D = double.parse(snapshot.data[2]["high"]);
                gbpHigh3D = double.parse(snapshot.data[3]["high"]);
                gbpHigh4D = double.parse(snapshot.data[4]["high"]);
                gbpHigh5D = double.parse(snapshot.data[5]["high"]);
                gbpHigh6D = double.parse(snapshot.data[6]["high"]);
                gbpHigh7D = double.parse(snapshot.data[7]["high"]);
                gbpHigh8D = double.parse(snapshot.data[8]["high"]);
                gbpHigh9D = double.parse(snapshot.data[9]["high"]);

                //Dias
                gbpDay1 = int.parse(snapshot.data[1]["timestamp"]);
                gbpDay1 =
                    new DateTime.fromMicrosecondsSinceEpoch(gbpDay1 * 1000000);
                gbpDay1 = int.parse(DateFormat('dd').format(gbpDay1));
                gbpDay1 = gbpDay1.toString();

                gbpDay2 = int.parse(snapshot.data[2]["timestamp"]);
                gbpDay2 =
                    new DateTime.fromMicrosecondsSinceEpoch(gbpDay2 * 1000000);
                gbpDay2 = int.parse(DateFormat('dd').format(gbpDay2));
                gbpDay2 = gbpDay2.toString();

                gbpDay3 = int.parse(snapshot.data[3]["timestamp"]);
                gbpDay3 =
                    new DateTime.fromMicrosecondsSinceEpoch(gbpDay3 * 1000000);
                gbpDay3 = int.parse(DateFormat('dd').format(gbpDay3));
                gbpDay3 = gbpDay3.toString();

                gbpDay4 = int.parse(snapshot.data[4]["timestamp"]);
                gbpDay4 =
                    new DateTime.fromMicrosecondsSinceEpoch(gbpDay4 * 1000000);
                gbpDay4 = int.parse(DateFormat('dd').format(gbpDay4));
                gbpDay4 = gbpDay4.toString();

                gbpDay5 = int.parse(snapshot.data[5]["timestamp"]);
                gbpDay5 =
                    new DateTime.fromMicrosecondsSinceEpoch(gbpDay5 * 1000000);
                gbpDay5 = int.parse(DateFormat('dd').format(gbpDay5));
                gbpDay5 = gbpDay5.toString();

                gbpDay6 = int.parse(snapshot.data[6]["timestamp"]);
                gbpDay6 =
                    new DateTime.fromMicrosecondsSinceEpoch(gbpDay6 * 1000000);
                gbpDay6 = int.parse(DateFormat('dd').format(gbpDay6));
                gbpDay6 = gbpDay6.toString();

                gbpDay7 = int.parse(snapshot.data[7]["timestamp"]);
                gbpDay7 =
                    new DateTime.fromMicrosecondsSinceEpoch(gbpDay7 * 1000000);
                gbpDay7 = int.parse(DateFormat('dd').format(gbpDay7));
                gbpDay7 = gbpDay7.toString();

                gbpDay8 = int.parse(snapshot.data[8]["timestamp"]);
                gbpDay8 =
                    new DateTime.fromMicrosecondsSinceEpoch(gbpDay8 * 1000000);
                gbpDay8 = int.parse(DateFormat('dd').format(gbpDay8));
                gbpDay8 = gbpDay8.toString();

                gbpDay9 = int.parse(snapshot.data[9]["timestamp"]);
                gbpDay9 =
                    new DateTime.fromMicrosecondsSinceEpoch(gbpDay9 * 1000000);
                gbpDay9 = int.parse(DateFormat('dd').format(gbpDay9));
                gbpDay9 = gbpDay9.toString();
                print('✔ GET fechamento GBP - Libra Esterlina');
                return ChartGBP();
              }
          }
        },
      ),
    );
  }
}
//FIM GBP //

///////////////////////////////////////////////////////////////////////////////

//INÍCIO CAD //

double closureCAD,
    cadHigh0D,
    cadHigh1D,
    cadHigh2D,
    cadHigh3D,
    cadHigh4D,
    cadHigh5D,
    cadHigh6D,
    cadHigh7D,
    cadHigh8D,
    cadHigh9D;

dynamic cadDay1,
    cadDay2,
    cadDay3,
    cadDay4,
    cadDay5,
    cadDay6,
    cadDay7,
    cadDay8,
    cadDay9;
//CAD-BRL (Dólar Canadense)
const requestCAD = 'https://economia.awesomeapi.com.br/json/daily/CAD-BRL/10';
Future<List> getDataCAD() async {
  http.Response responseCAD =
      await http.get(requestCAD); //Solicita a string do servidor
  return json.decode(responseCAD.body); //Retorna a string convertida em json
}

class LoadClosureCAD extends StatefulWidget {
  @override
  _LoadClosureCADState createState() => _LoadClosureCADState();
}

class _LoadClosureCADState extends State<LoadClosureCAD> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List>(
        future: getDataCAD(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                  //child: CircularProgressIndicator(),
                  );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Icon(
                    Icons.wifi_off,
                    color: Color.fromRGBO(243, 245, 248, 1),
                    size: 70,
                  ),
                );
              } else {
                //Valores
                cadHigh1D = double.parse(snapshot.data[1]["high"]);
                cadHigh2D = double.parse(snapshot.data[2]["high"]);
                cadHigh3D = double.parse(snapshot.data[3]["high"]);
                cadHigh4D = double.parse(snapshot.data[4]["high"]);
                cadHigh5D = double.parse(snapshot.data[5]["high"]);
                cadHigh6D = double.parse(snapshot.data[6]["high"]);
                cadHigh7D = double.parse(snapshot.data[7]["high"]);
                cadHigh8D = double.parse(snapshot.data[8]["high"]);
                cadHigh9D = double.parse(snapshot.data[9]["high"]);

                //Dias
                cadDay1 = int.parse(snapshot.data[1]["timestamp"]);
                cadDay1 =
                    new DateTime.fromMicrosecondsSinceEpoch(cadDay1 * 1000000);
                cadDay1 = int.parse(DateFormat('dd').format(cadDay1));
                cadDay1 = cadDay1.toString();

                cadDay2 = int.parse(snapshot.data[2]["timestamp"]);
                cadDay2 =
                    new DateTime.fromMicrosecondsSinceEpoch(cadDay2 * 1000000);
                cadDay2 = int.parse(DateFormat('dd').format(cadDay2));
                cadDay2 = cadDay2.toString();

                cadDay3 = int.parse(snapshot.data[3]["timestamp"]);
                cadDay3 =
                    new DateTime.fromMicrosecondsSinceEpoch(cadDay3 * 1000000);
                cadDay3 = int.parse(DateFormat('dd').format(cadDay3));
                cadDay3 = cadDay3.toString();

                cadDay4 = int.parse(snapshot.data[4]["timestamp"]);
                cadDay4 =
                    new DateTime.fromMicrosecondsSinceEpoch(cadDay4 * 1000000);
                cadDay4 = int.parse(DateFormat('dd').format(cadDay4));
                cadDay4 = cadDay4.toString();

                cadDay5 = int.parse(snapshot.data[5]["timestamp"]);
                cadDay5 =
                    new DateTime.fromMicrosecondsSinceEpoch(cadDay5 * 1000000);
                cadDay5 = int.parse(DateFormat('dd').format(cadDay5));
                cadDay5 = cadDay5.toString();

                cadDay6 = int.parse(snapshot.data[6]["timestamp"]);
                cadDay6 =
                    new DateTime.fromMicrosecondsSinceEpoch(cadDay6 * 1000000);
                cadDay6 = int.parse(DateFormat('dd').format(cadDay6));
                cadDay6 = cadDay6.toString();

                cadDay7 = int.parse(snapshot.data[7]["timestamp"]);
                cadDay7 =
                    new DateTime.fromMicrosecondsSinceEpoch(cadDay7 * 1000000);
                cadDay7 = int.parse(DateFormat('dd').format(cadDay7));
                cadDay7 = cadDay7.toString();

                cadDay8 = int.parse(snapshot.data[8]["timestamp"]);
                cadDay8 =
                    new DateTime.fromMicrosecondsSinceEpoch(cadDay8 * 1000000);
                cadDay8 = int.parse(DateFormat('dd').format(cadDay8));
                cadDay8 = cadDay8.toString();

                cadDay9 = int.parse(snapshot.data[9]["timestamp"]);
                cadDay9 =
                    new DateTime.fromMicrosecondsSinceEpoch(cadDay9 * 1000000);
                cadDay9 = int.parse(DateFormat('dd').format(cadDay9));
                cadDay9 = cadDay9.toString();
                print('✔ GET fechamento CAD - Dólar Canadense');
                return ChartCAD();
              }
          }
        },
      ),
    );
  }
}
//FIM CAD //

///////////////////////////////////////////////////////////////////////////////

//INÍCIO AUD //

double closureAUD,
    audHigh0D,
    audHigh1D,
    audHigh2D,
    audHigh3D,
    audHigh4D,
    audHigh5D,
    audHigh6D,
    audHigh7D,
    audHigh8D,
    audHigh9D;

dynamic audDay1,
    audDay2,
    audDay3,
    audDay4,
    audDay5,
    audDay6,
    audDay7,
    audDay8,
    audDay9;
//AUD-BRL (Dólar Australiano)
const requestAUD = 'https://economia.awesomeapi.com.br/json/daily/AUD-BRL/10';
Future<List> getDataAUD() async {
  http.Response responseAUD =
      await http.get(requestAUD); //Solicita a string do servidor
  return json.decode(responseAUD.body); //Retorna a string convertida em json
}

class LoadClosureAUD extends StatefulWidget {
  @override
  _LoadClosureAUDState createState() => _LoadClosureAUDState();
}

class _LoadClosureAUDState extends State<LoadClosureAUD> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List>(
        future: getDataAUD(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                  //child: CircularProgressIndicator(),
                  );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Icon(
                    Icons.wifi_off,
                    color: Color.fromRGBO(243, 245, 248, 1),
                    size: 70,
                  ),
                );
              } else {
                //Valores
                audHigh1D = double.parse(snapshot.data[1]["high"]);
                audHigh2D = double.parse(snapshot.data[2]["high"]);
                audHigh3D = double.parse(snapshot.data[3]["high"]);
                audHigh4D = double.parse(snapshot.data[4]["high"]);
                audHigh5D = double.parse(snapshot.data[5]["high"]);
                audHigh6D = double.parse(snapshot.data[6]["high"]);
                audHigh7D = double.parse(snapshot.data[7]["high"]);
                audHigh8D = double.parse(snapshot.data[8]["high"]);
                audHigh9D = double.parse(snapshot.data[9]["high"]);

                //Dias
                audDay1 = int.parse(snapshot.data[1]["timestamp"]);
                audDay1 =
                    new DateTime.fromMicrosecondsSinceEpoch(audDay1 * 1000000);
                audDay1 = int.parse(DateFormat('dd').format(audDay1));
                audDay1 = audDay1.toString();

                audDay2 = int.parse(snapshot.data[2]["timestamp"]);
                audDay2 =
                    new DateTime.fromMicrosecondsSinceEpoch(audDay2 * 1000000);
                audDay2 = int.parse(DateFormat('dd').format(audDay2));
                audDay2 = audDay2.toString();

                audDay3 = int.parse(snapshot.data[3]["timestamp"]);
                audDay3 =
                    new DateTime.fromMicrosecondsSinceEpoch(audDay3 * 1000000);
                audDay3 = int.parse(DateFormat('dd').format(audDay3));
                audDay3 = audDay3.toString();

                audDay4 = int.parse(snapshot.data[4]["timestamp"]);
                audDay4 =
                    new DateTime.fromMicrosecondsSinceEpoch(audDay4 * 1000000);
                audDay4 = int.parse(DateFormat('dd').format(audDay4));
                audDay4 = audDay4.toString();

                audDay5 = int.parse(snapshot.data[5]["timestamp"]);
                audDay5 =
                    new DateTime.fromMicrosecondsSinceEpoch(audDay5 * 1000000);
                audDay5 = int.parse(DateFormat('dd').format(audDay5));
                audDay5 = audDay5.toString();

                audDay6 = int.parse(snapshot.data[6]["timestamp"]);
                audDay6 =
                    new DateTime.fromMicrosecondsSinceEpoch(audDay6 * 1000000);
                audDay6 = int.parse(DateFormat('dd').format(audDay6));
                audDay6 = audDay6.toString();

                audDay7 = int.parse(snapshot.data[7]["timestamp"]);
                audDay7 =
                    new DateTime.fromMicrosecondsSinceEpoch(audDay7 * 1000000);
                audDay7 = int.parse(DateFormat('dd').format(audDay7));
                audDay7 = audDay7.toString();

                audDay8 = int.parse(snapshot.data[8]["timestamp"]);
                audDay8 =
                    new DateTime.fromMicrosecondsSinceEpoch(audDay8 * 1000000);
                audDay8 = int.parse(DateFormat('dd').format(audDay8));
                audDay8 = audDay8.toString();

                audDay9 = int.parse(snapshot.data[9]["timestamp"]);
                audDay9 =
                    new DateTime.fromMicrosecondsSinceEpoch(audDay9 * 1000000);
                audDay9 = int.parse(DateFormat('dd').format(audDay9));
                audDay9 = audDay9.toString();
                print('✔ GET fechamento AUD - Dólar Australiano');
                return ChartAUD();
              }
          }
        },
      ),
    );
  }
}
//FIM AUD //

///////////////////////////////////////////////////////////////////////////////

//INÍCIO ARS //

double closureARS,
    arsHigh0D,
    arsHigh1D,
    arsHigh2D,
    arsHigh3D,
    arsHigh4D,
    arsHigh5D,
    arsHigh6D,
    arsHigh7D,
    arsHigh8D,
    arsHigh9D;

dynamic arsDay1,
    arsDay2,
    arsDay3,
    arsDay4,
    arsDay5,
    arsDay6,
    arsDay7,
    arsDay8,
    arsDay9;
//ARS-BRL (Peso Argentino)
const requestARS = 'https://economia.awesomeapi.com.br/json/daily/ARS-BRL/10';
Future<List> getDataARS() async {
  http.Response responseARS =
      await http.get(requestARS); //Solicita a string do servidor
  return json.decode(responseARS.body); //Retorna a string convertida em json
}

class LoadClosureARS extends StatefulWidget {
  @override
  _LoadClosureARSState createState() => _LoadClosureARSState();
}

class _LoadClosureARSState extends State<LoadClosureARS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List>(
        future: getDataARS(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                  //child: CircularProgressIndicator(),
                  );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Icon(
                    Icons.wifi_off,
                    color: Color.fromRGBO(243, 245, 248, 1),
                    size: 70,
                  ),
                );
              } else {
                //Valores
                arsHigh1D = double.parse(snapshot.data[1]["high"]);
                arsHigh2D = double.parse(snapshot.data[2]["high"]);
                arsHigh3D = double.parse(snapshot.data[3]["high"]);
                arsHigh4D = double.parse(snapshot.data[4]["high"]);
                arsHigh5D = double.parse(snapshot.data[5]["high"]);
                arsHigh6D = double.parse(snapshot.data[6]["high"]);
                arsHigh7D = double.parse(snapshot.data[7]["high"]);
                arsHigh8D = double.parse(snapshot.data[8]["high"]);
                arsHigh9D = double.parse(snapshot.data[9]["high"]);

                //Dias
                arsDay1 = int.parse(snapshot.data[1]["timestamp"]);
                arsDay1 =
                    new DateTime.fromMicrosecondsSinceEpoch(arsDay1 * 1000000);
                arsDay1 = int.parse(DateFormat('dd').format(arsDay1));
                arsDay1 = arsDay1.toString();

                arsDay2 = int.parse(snapshot.data[2]["timestamp"]);
                arsDay2 =
                    new DateTime.fromMicrosecondsSinceEpoch(arsDay2 * 1000000);
                arsDay2 = int.parse(DateFormat('dd').format(arsDay2));
                arsDay2 = arsDay2.toString();

                arsDay3 = int.parse(snapshot.data[3]["timestamp"]);
                arsDay3 =
                    new DateTime.fromMicrosecondsSinceEpoch(arsDay3 * 1000000);
                arsDay3 = int.parse(DateFormat('dd').format(arsDay3));
                arsDay3 = arsDay3.toString();

                arsDay4 = int.parse(snapshot.data[4]["timestamp"]);
                arsDay4 =
                    new DateTime.fromMicrosecondsSinceEpoch(arsDay4 * 1000000);
                arsDay4 = int.parse(DateFormat('dd').format(arsDay4));
                arsDay4 = arsDay4.toString();

                arsDay5 = int.parse(snapshot.data[5]["timestamp"]);
                arsDay5 =
                    new DateTime.fromMicrosecondsSinceEpoch(arsDay5 * 1000000);
                arsDay5 = int.parse(DateFormat('dd').format(arsDay5));
                arsDay5 = arsDay5.toString();

                arsDay6 = int.parse(snapshot.data[6]["timestamp"]);
                arsDay6 =
                    new DateTime.fromMicrosecondsSinceEpoch(arsDay6 * 1000000);
                arsDay6 = int.parse(DateFormat('dd').format(arsDay6));
                arsDay6 = arsDay6.toString();

                arsDay7 = int.parse(snapshot.data[7]["timestamp"]);
                arsDay7 =
                    new DateTime.fromMicrosecondsSinceEpoch(arsDay7 * 1000000);
                arsDay7 = int.parse(DateFormat('dd').format(arsDay7));
                arsDay7 = arsDay7.toString();

                arsDay8 = int.parse(snapshot.data[8]["timestamp"]);
                arsDay8 =
                    new DateTime.fromMicrosecondsSinceEpoch(arsDay8 * 1000000);
                arsDay8 = int.parse(DateFormat('dd').format(arsDay8));
                arsDay8 = arsDay8.toString();

                arsDay9 = int.parse(snapshot.data[9]["timestamp"]);
                arsDay9 =
                    new DateTime.fromMicrosecondsSinceEpoch(arsDay9 * 1000000);
                arsDay9 = int.parse(DateFormat('dd').format(arsDay9));
                arsDay9 = arsDay9.toString();
                print('✔ GET fechamento ARS - Peso Argentino');
                return ChartARS();
              }
          }
        },
      ),
    );
  }
}
//FIM ARS //

///////////////////////////////////////////////////////////////////////////////

//INÍCIO JPY //

double closureJPY,
    jpyHigh0D,
    jpyHigh1D,
    jpyHigh2D,
    jpyHigh3D,
    jpyHigh4D,
    jpyHigh5D,
    jpyHigh6D,
    jpyHigh7D,
    jpyHigh8D,
    jpyHigh9D;

dynamic jpyDay1,
    jpyDay2,
    jpyDay3,
    jpyDay4,
    jpyDay5,
    jpyDay6,
    jpyDay7,
    jpyDay8,
    jpyDay9;
//JPY-BRL (Iene Japonês)
const requestJPY = 'https://economia.awesomeapi.com.br/json/daily/JPY-BRL/10';
Future<List> getDataJPY() async {
  http.Response responseJPY =
      await http.get(requestJPY); //Solicita a string do servidor
  return json.decode(responseJPY.body); //Retorna a string convertida em json
}

class LoadClosureJPY extends StatefulWidget {
  @override
  _LoadClosureJPYState createState() => _LoadClosureJPYState();
}

class _LoadClosureJPYState extends State<LoadClosureJPY> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List>(
        future: getDataJPY(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                  //child: CircularProgressIndicator(),
                  );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Icon(
                    Icons.wifi_off,
                    color: Color.fromRGBO(243, 245, 248, 1),
                    size: 70,
                  ),
                );
              } else {
                //Valores
                jpyHigh1D = double.parse(snapshot.data[1]["high"]);
                jpyHigh2D = double.parse(snapshot.data[2]["high"]);
                jpyHigh3D = double.parse(snapshot.data[3]["high"]);
                jpyHigh4D = double.parse(snapshot.data[4]["high"]);
                jpyHigh5D = double.parse(snapshot.data[5]["high"]);
                jpyHigh6D = double.parse(snapshot.data[6]["high"]);
                jpyHigh7D = double.parse(snapshot.data[7]["high"]);
                jpyHigh8D = double.parse(snapshot.data[8]["high"]);
                jpyHigh9D = double.parse(snapshot.data[9]["high"]);

                //Dias
                jpyDay1 = int.parse(snapshot.data[1]["timestamp"]);
                jpyDay1 =
                    new DateTime.fromMicrosecondsSinceEpoch(jpyDay1 * 1000000);
                jpyDay1 = int.parse(DateFormat('dd').format(jpyDay1));
                jpyDay1 = jpyDay1.toString();

                jpyDay2 = int.parse(snapshot.data[2]["timestamp"]);
                jpyDay2 =
                    new DateTime.fromMicrosecondsSinceEpoch(jpyDay2 * 1000000);
                jpyDay2 = int.parse(DateFormat('dd').format(jpyDay2));
                jpyDay2 = jpyDay2.toString();

                jpyDay3 = int.parse(snapshot.data[3]["timestamp"]);
                jpyDay3 =
                    new DateTime.fromMicrosecondsSinceEpoch(jpyDay3 * 1000000);
                jpyDay3 = int.parse(DateFormat('dd').format(jpyDay3));
                jpyDay3 = jpyDay3.toString();

                jpyDay4 = int.parse(snapshot.data[4]["timestamp"]);
                jpyDay4 =
                    new DateTime.fromMicrosecondsSinceEpoch(jpyDay4 * 1000000);
                jpyDay4 = int.parse(DateFormat('dd').format(jpyDay4));
                jpyDay4 = jpyDay4.toString();

                jpyDay5 = int.parse(snapshot.data[5]["timestamp"]);
                jpyDay5 =
                    new DateTime.fromMicrosecondsSinceEpoch(jpyDay5 * 1000000);
                jpyDay5 = int.parse(DateFormat('dd').format(jpyDay5));
                jpyDay5 = jpyDay5.toString();

                jpyDay6 = int.parse(snapshot.data[6]["timestamp"]);
                jpyDay6 =
                    new DateTime.fromMicrosecondsSinceEpoch(jpyDay6 * 1000000);
                jpyDay6 = int.parse(DateFormat('dd').format(jpyDay6));
                jpyDay6 = jpyDay6.toString();

                jpyDay7 = int.parse(snapshot.data[7]["timestamp"]);
                jpyDay7 =
                    new DateTime.fromMicrosecondsSinceEpoch(jpyDay7 * 1000000);
                jpyDay7 = int.parse(DateFormat('dd').format(jpyDay7));
                jpyDay7 = jpyDay7.toString();

                jpyDay8 = int.parse(snapshot.data[8]["timestamp"]);
                jpyDay8 =
                    new DateTime.fromMicrosecondsSinceEpoch(jpyDay8 * 1000000);
                jpyDay8 = int.parse(DateFormat('dd').format(jpyDay8));
                jpyDay8 = jpyDay8.toString();

                jpyDay9 = int.parse(snapshot.data[9]["timestamp"]);
                jpyDay9 =
                    new DateTime.fromMicrosecondsSinceEpoch(jpyDay9 * 1000000);
                jpyDay9 = int.parse(DateFormat('dd').format(jpyDay9));
                jpyDay9 = jpyDay9.toString();
                print('✔ GET fechamento JPY - Iene Japonês');
                return ChartJPY();
              }
          }
        },
      ),
    );
  }
}
//FIM JPY //

///////////////////////////////////////////////////////////////////////////////

//INÍCIO CNY //

double closureCNY,
    cnyHigh0D,
    cnyHigh1D,
    cnyHigh2D,
    cnyHigh3D,
    cnyHigh4D,
    cnyHigh5D,
    cnyHigh6D,
    cnyHigh7D,
    cnyHigh8D,
    cnyHigh9D;

dynamic cnyDay1,
    cnyDay2,
    cnyDay3,
    cnyDay4,
    cnyDay5,
    cnyDay6,
    cnyDay7,
    cnyDay8,
    cnyDay9;
//CNY-BRL (Yuan Chinês)
const requestCNY = 'https://economia.awesomeapi.com.br/json/daily/CNY-BRL/10';
Future<List> getDataCNY() async {
  http.Response responseCNY =
      await http.get(requestCNY); //Solicita a string do servidor
  return json.decode(responseCNY.body); //Retorna a string convertida em json
}

class LoadClosureCNY extends StatefulWidget {
  @override
  _LoadClosureCNYState createState() => _LoadClosureCNYState();
}

class _LoadClosureCNYState extends State<LoadClosureCNY> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List>(
        future: getDataCNY(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                  //child: CircularProgressIndicator(),
                  );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Icon(
                    Icons.wifi_off,
                    color: Color.fromRGBO(243, 245, 248, 1),
                    size: 70,
                  ),
                );
              } else {
                //Valores
                cnyHigh1D = double.parse(snapshot.data[1]["high"]);
                cnyHigh2D = double.parse(snapshot.data[2]["high"]);
                cnyHigh3D = double.parse(snapshot.data[3]["high"]);
                cnyHigh4D = double.parse(snapshot.data[4]["high"]);
                cnyHigh5D = double.parse(snapshot.data[5]["high"]);
                cnyHigh6D = double.parse(snapshot.data[6]["high"]);
                cnyHigh7D = double.parse(snapshot.data[7]["high"]);
                cnyHigh8D = double.parse(snapshot.data[8]["high"]);
                cnyHigh9D = double.parse(snapshot.data[9]["high"]);

                //Dias
                cnyDay1 = int.parse(snapshot.data[1]["timestamp"]);
                cnyDay1 =
                    new DateTime.fromMicrosecondsSinceEpoch(cnyDay1 * 1000000);
                cnyDay1 = int.parse(DateFormat('dd').format(cnyDay1));
                cnyDay1 = cnyDay1.toString();

                cnyDay2 = int.parse(snapshot.data[2]["timestamp"]);
                cnyDay2 =
                    new DateTime.fromMicrosecondsSinceEpoch(cnyDay2 * 1000000);
                cnyDay2 = int.parse(DateFormat('dd').format(cnyDay2));
                cnyDay2 = cnyDay2.toString();

                cnyDay3 = int.parse(snapshot.data[3]["timestamp"]);
                cnyDay3 =
                    new DateTime.fromMicrosecondsSinceEpoch(cnyDay3 * 1000000);
                cnyDay3 = int.parse(DateFormat('dd').format(cnyDay3));
                cnyDay3 = cnyDay3.toString();

                cnyDay4 = int.parse(snapshot.data[4]["timestamp"]);
                cnyDay4 =
                    new DateTime.fromMicrosecondsSinceEpoch(cnyDay4 * 1000000);
                cnyDay4 = int.parse(DateFormat('dd').format(cnyDay4));
                cnyDay4 = cnyDay4.toString();

                cnyDay5 = int.parse(snapshot.data[5]["timestamp"]);
                cnyDay5 =
                    new DateTime.fromMicrosecondsSinceEpoch(cnyDay5 * 1000000);
                cnyDay5 = int.parse(DateFormat('dd').format(cnyDay5));
                cnyDay5 = cnyDay5.toString();

                cnyDay6 = int.parse(snapshot.data[6]["timestamp"]);
                cnyDay6 =
                    new DateTime.fromMicrosecondsSinceEpoch(cnyDay6 * 1000000);
                cnyDay6 = int.parse(DateFormat('dd').format(cnyDay6));
                cnyDay6 = cnyDay6.toString();

                cnyDay7 = int.parse(snapshot.data[7]["timestamp"]);
                cnyDay7 =
                    new DateTime.fromMicrosecondsSinceEpoch(cnyDay7 * 1000000);
                cnyDay7 = int.parse(DateFormat('dd').format(cnyDay7));
                cnyDay7 = cnyDay7.toString();

                cnyDay8 = int.parse(snapshot.data[8]["timestamp"]);
                cnyDay8 =
                    new DateTime.fromMicrosecondsSinceEpoch(cnyDay8 * 1000000);
                cnyDay8 = int.parse(DateFormat('dd').format(cnyDay8));
                cnyDay8 = cnyDay8.toString();

                cnyDay9 = int.parse(snapshot.data[9]["timestamp"]);
                cnyDay9 =
                    new DateTime.fromMicrosecondsSinceEpoch(cnyDay9 * 1000000);
                cnyDay9 = int.parse(DateFormat('dd').format(cnyDay9));
                cnyDay9 = cnyDay9.toString();
                print('✔ GET fechamento CNY - Yuan Chinês');
                return ChartCNY();
              }
          }
        },
      ),
    );
  }
}

//FIM CNY //

///////////////////////////////////////////////////////////////////////////////

//INÍCIO CHF //

double closureCHF,
    chfHigh0D,
    chfHigh1D,
    chfHigh2D,
    chfHigh3D,
    chfHigh4D,
    chfHigh5D,
    chfHigh6D,
    chfHigh7D,
    chfHigh8D,
    chfHigh9D;

dynamic chfDay1,
    chfDay2,
    chfDay3,
    chfDay4,
    chfDay5,
    chfDay6,
    chfDay7,
    chfDay8,
    chfDay9;
//CHF-BRL (Franco Suíço)
const requestCHF = 'https://economia.awesomeapi.com.br/json/daily/CHF-BRL/10';
Future<List> getDataCHF() async {
  http.Response responseCHF =
      await http.get(requestCHF); //Solicita a string do servidor
  return json.decode(responseCHF.body); //Retorna a string convertida em json
}

class LoadClosureCHF extends StatefulWidget {
  @override
  _LoadClosureCHFState createState() => _LoadClosureCHFState();
}

class _LoadClosureCHFState extends State<LoadClosureCHF> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List>(
        future: getDataCHF(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                  //child: CircularProgressIndicator(),
                  );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Icon(
                    Icons.wifi_off,
                    color: Color.fromRGBO(243, 245, 248, 1),
                    size: 70,
                  ),
                );
              } else {
                //Valores
                chfHigh1D = double.parse(snapshot.data[1]["high"]);
                chfHigh2D = double.parse(snapshot.data[2]["high"]);
                chfHigh3D = double.parse(snapshot.data[3]["high"]);
                chfHigh4D = double.parse(snapshot.data[4]["high"]);
                chfHigh5D = double.parse(snapshot.data[5]["high"]);
                chfHigh6D = double.parse(snapshot.data[6]["high"]);
                chfHigh7D = double.parse(snapshot.data[7]["high"]);
                chfHigh8D = double.parse(snapshot.data[8]["high"]);
                chfHigh9D = double.parse(snapshot.data[9]["high"]);

                //Dias
                chfDay1 = int.parse(snapshot.data[1]["timestamp"]);
                chfDay1 =
                    new DateTime.fromMicrosecondsSinceEpoch(chfDay1 * 1000000);
                chfDay1 = int.parse(DateFormat('dd').format(chfDay1));
                chfDay1 = chfDay1.toString();

                chfDay2 = int.parse(snapshot.data[2]["timestamp"]);
                chfDay2 =
                    new DateTime.fromMicrosecondsSinceEpoch(chfDay2 * 1000000);
                chfDay2 = int.parse(DateFormat('dd').format(chfDay2));
                chfDay2 = chfDay2.toString();

                chfDay3 = int.parse(snapshot.data[3]["timestamp"]);
                chfDay3 =
                    new DateTime.fromMicrosecondsSinceEpoch(chfDay3 * 1000000);
                chfDay3 = int.parse(DateFormat('dd').format(chfDay3));
                chfDay3 = chfDay3.toString();

                chfDay4 = int.parse(snapshot.data[4]["timestamp"]);
                chfDay4 =
                    new DateTime.fromMicrosecondsSinceEpoch(chfDay4 * 1000000);
                chfDay4 = int.parse(DateFormat('dd').format(chfDay4));
                chfDay4 = chfDay4.toString();

                chfDay5 = int.parse(snapshot.data[5]["timestamp"]);
                chfDay5 =
                    new DateTime.fromMicrosecondsSinceEpoch(chfDay5 * 1000000);
                chfDay5 = int.parse(DateFormat('dd').format(chfDay5));
                chfDay5 = chfDay5.toString();

                chfDay6 = int.parse(snapshot.data[6]["timestamp"]);
                chfDay6 =
                    new DateTime.fromMicrosecondsSinceEpoch(chfDay6 * 1000000);
                chfDay6 = int.parse(DateFormat('dd').format(chfDay6));
                chfDay6 = chfDay6.toString();

                chfDay7 = int.parse(snapshot.data[7]["timestamp"]);
                chfDay7 =
                    new DateTime.fromMicrosecondsSinceEpoch(chfDay7 * 1000000);
                chfDay7 = int.parse(DateFormat('dd').format(chfDay7));
                chfDay7 = chfDay7.toString();

                chfDay8 = int.parse(snapshot.data[8]["timestamp"]);
                chfDay8 =
                    new DateTime.fromMicrosecondsSinceEpoch(chfDay8 * 1000000);
                chfDay8 = int.parse(DateFormat('dd').format(chfDay8));
                chfDay8 = chfDay8.toString();

                chfDay9 = int.parse(snapshot.data[9]["timestamp"]);
                chfDay9 =
                    new DateTime.fromMicrosecondsSinceEpoch(chfDay9 * 1000000);
                chfDay9 = int.parse(DateFormat('dd').format(chfDay9));
                chfDay9 = chfDay9.toString();
                print('✔ GET fechamento CHF - Franco Suíço');
                return ChartCHF();
              }
          }
        },
      ),
    );
  }
}

//FIM CHF //

///////////////////////////////////////////////////////////////////////////////

//INÍCIO ILS //

double closureILS,
    ilsHigh0D,
    ilsHigh1D,
    ilsHigh2D,
    ilsHigh3D,
    ilsHigh4D,
    ilsHigh5D,
    ilsHigh6D,
    ilsHigh7D,
    ilsHigh8D,
    ilsHigh9D;

dynamic ilsDay1,
    ilsDay2,
    ilsDay3,
    ilsDay4,
    ilsDay5,
    ilsDay6,
    ilsDay7,
    ilsDay8,
    ilsDay9;

//ILS-BRL (Novo Shekel Israelense)
const requestILS = 'https://economia.awesomeapi.com.br/json/daily/ILS-BRL/10';
Future<List> getDataILS() async {
  http.Response responseILS =
      await http.get(requestILS); //Solicita a string do servidor
  return json.decode(responseILS.body);
}

class LoadClosureILS extends StatefulWidget {
  @override
  _LoadClosureILSState createState() => _LoadClosureILSState();
}

class _LoadClosureILSState extends State<LoadClosureILS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List>(
        future: getDataILS(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                  //child: CircularProgressIndicator(),
                  );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Icon(
                    Icons.wifi_off,
                    color: Color.fromRGBO(243, 245, 248, 1),
                    size: 70,
                  ),
                );
              } else {
                //Valores
                ilsHigh1D = double.parse(snapshot.data[1]["high"]);
                ilsHigh2D = double.parse(snapshot.data[2]["high"]);
                ilsHigh3D = double.parse(snapshot.data[3]["high"]);
                ilsHigh4D = double.parse(snapshot.data[4]["high"]);
                ilsHigh5D = double.parse(snapshot.data[5]["high"]);
                ilsHigh6D = double.parse(snapshot.data[6]["high"]);
                ilsHigh7D = double.parse(snapshot.data[7]["high"]);
                ilsHigh8D = double.parse(snapshot.data[8]["high"]);
                ilsHigh9D = double.parse(snapshot.data[9]["high"]);

                //Dias
                ilsDay1 = int.parse(snapshot.data[1]["timestamp"]);
                ilsDay1 =
                    new DateTime.fromMicrosecondsSinceEpoch(ilsDay1 * 1000000);
                ilsDay1 = int.parse(DateFormat('dd').format(ilsDay1));
                ilsDay1 = ilsDay1.toString();

                ilsDay2 = int.parse(snapshot.data[2]["timestamp"]);
                ilsDay2 =
                    new DateTime.fromMicrosecondsSinceEpoch(ilsDay2 * 1000000);
                ilsDay2 = int.parse(DateFormat('dd').format(ilsDay2));
                ilsDay2 = ilsDay2.toString();

                ilsDay3 = int.parse(snapshot.data[3]["timestamp"]);
                ilsDay3 =
                    new DateTime.fromMicrosecondsSinceEpoch(ilsDay3 * 1000000);
                ilsDay3 = int.parse(DateFormat('dd').format(ilsDay3));
                ilsDay3 = ilsDay3.toString();

                ilsDay4 = int.parse(snapshot.data[4]["timestamp"]);
                ilsDay4 =
                    new DateTime.fromMicrosecondsSinceEpoch(ilsDay4 * 1000000);
                ilsDay4 = int.parse(DateFormat('dd').format(ilsDay4));
                ilsDay4 = ilsDay4.toString();

                ilsDay5 = int.parse(snapshot.data[5]["timestamp"]);
                ilsDay5 =
                    new DateTime.fromMicrosecondsSinceEpoch(ilsDay5 * 1000000);
                ilsDay5 = int.parse(DateFormat('dd').format(ilsDay5));
                ilsDay5 = ilsDay5.toString();

                ilsDay6 = int.parse(snapshot.data[6]["timestamp"]);
                ilsDay6 =
                    new DateTime.fromMicrosecondsSinceEpoch(ilsDay6 * 1000000);
                ilsDay6 = int.parse(DateFormat('dd').format(ilsDay6));
                ilsDay6 = ilsDay6.toString();

                ilsDay7 = int.parse(snapshot.data[7]["timestamp"]);
                ilsDay7 =
                    new DateTime.fromMicrosecondsSinceEpoch(ilsDay7 * 1000000);
                ilsDay7 = int.parse(DateFormat('dd').format(ilsDay7));
                ilsDay7 = ilsDay7.toString();

                ilsDay8 = int.parse(snapshot.data[8]["timestamp"]);
                ilsDay8 =
                    new DateTime.fromMicrosecondsSinceEpoch(ilsDay8 * 1000000);
                ilsDay8 = int.parse(DateFormat('dd').format(ilsDay8));
                ilsDay8 = ilsDay8.toString();

                ilsDay9 = int.parse(snapshot.data[9]["timestamp"]);
                ilsDay9 =
                    new DateTime.fromMicrosecondsSinceEpoch(ilsDay9 * 1000000);
                ilsDay9 = int.parse(DateFormat('dd').format(ilsDay9));
                ilsDay9 = ilsDay9.toString();
                print('✔ GET fechamento ILS - Novo Shekel Israelense');
                return ChartILS();
              }
          }
        },
      ),
    );
  }
}

//FIM ILS //

///////////////////////////////////////////////////////////////////////////////


import 'package:conversor_moeda_jpvp/homeScreen.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:conversor_moeda_jpvp/currencyList.dart';

const request = "https://economia.awesomeapi.com.br/json/all";

String formatedDate;

//Função no que pega a string no futuro no site e transforma em formato json
Future<Map> getData() async {
  http.Response response =
      await http.get(request); //Solicita a string do servidor
  return json.decode(response.body); //Retorna a string convertida em json
}

// INICIO CLASSE DO LOAD //
class LoadStart extends StatefulWidget {
  @override
  _LoadStartState createState() => _LoadStartState();
}

class _LoadStartState extends State<LoadStart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<Map>(
        future: getData(),
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
                  child: Center(
                    child: Icon(
                      Icons.wifi_off,
                      color: Color.fromRGBO(243, 245, 248, 1),
                      size: 70,
                    ),
                  ),
                );
              } else {
                brl = 1.0;
                usd = double.parse(snapshot.data["USD"]["high"]);
                usdt = double.parse(snapshot.data["USDT"]["high"]);
                eur = double.parse(snapshot.data["EUR"]["high"]);
                gbp = double.parse(snapshot.data["GBP"]["high"]);
                cad = double.parse(snapshot.data["CAD"]["high"]);
                aud = double.parse(snapshot.data["AUD"]["high"]);
                ars = double.parse(snapshot.data["ARS"]["high"]);
                jpy = double.parse(snapshot.data["JPY"]["high"]);
                cny = double.parse(snapshot.data["CNY"]["high"]);
                chf = double.parse(snapshot.data["CHF"]["high"]);
                ils = double.parse(snapshot.data["ILS"]["high"]);

                brlFlag = 'BRL';
                usdFlag = snapshot.data["USD"]["code"];
                usdtFlag = snapshot.data["USDT"]["code"];
                eurFlag = snapshot.data["EUR"]["code"];
                gbpFlag = snapshot.data["GBP"]["code"];
                cadFlag = snapshot.data["CAD"]["code"];
                audFlag = snapshot.data["AUD"]["code"];
                arsFlag = snapshot.data["ARS"]["code"];
                jpyFlag = snapshot.data["JPY"]["code"];
                cnyFlag = snapshot.data["CNY"]["code"];
                chfFlag = snapshot.data["CHF"]["code"];
                ilsFlag = snapshot.data["ILS"]["code"];

                brlPct = 0.0;
                usdPct = double.parse(snapshot.data["USD"]["pctChange"]);
                usdtPct = double.parse(snapshot.data["USDT"]["pctChange"]);
                eurPct = double.parse(snapshot.data["EUR"]["pctChange"]);
                gbpPct = double.parse(snapshot.data["GBP"]["pctChange"]);
                cadPct = double.parse(snapshot.data["CAD"]["pctChange"]);
                audPct = double.parse(snapshot.data["AUD"]["pctChange"]);
                arsPct = double.parse(snapshot.data["ARS"]["pctChange"]);
                jpyPct = double.parse(snapshot.data["JPY"]["pctChange"]);
                cnyPct = double.parse(snapshot.data["CNY"]["pctChange"]);
                chfPct = double.parse(snapshot.data["CHF"]["pctChange"]);
                ilsPct = double.parse(snapshot.data["ILS"]["pctChange"]);

                DateTime now = DateTime.now();
                String formatedDate =
                    DateFormat('dd/MM/yyyy – kk:mm').format(now);
                print('Informações coletadas as $formatedDate');

                print('✔ GET Cotação de todas moedas.');
                return HomeScreen(); //Chama a pagina principal caso a API seja carregada com sucesso.
              }
          }
        },
      ),
    );
  }
}
// FIM CLASSE DO LOAD //

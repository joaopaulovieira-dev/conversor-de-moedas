import 'package:flutter/material.dart';

import 'currencyList.dart';

//Informações botão compratilhar
String linkApp =
    'https://play.google.com/store/apps/details?id=dev.joaopaulovieira.conversor_moeda_jpvp  \nBaixe agora o App Conversor de Moedas e tenha de forma instantânea a conversão das principais moedas do mercado!';
String subText = 'Conheça o App Conversor de Moedas';

// INÍCIO VARIÁVEIS //

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: CurrencyList(),
    );
  }
}

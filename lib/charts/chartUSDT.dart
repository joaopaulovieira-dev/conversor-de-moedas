import 'package:conversor_moeda_jpvp/get/LoadClosures.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartUSDT extends StatefulWidget {
  ChartUSDT({Key key}) : super(key: key);

  @override
  _ChartUSDTState createState() => _ChartUSDTState();
}

class _ChartUSDTState extends State<ChartUSDT> {
  TrackballBehavior _trackballBehavior;

  @override
  void initState() {
    _trackballBehavior = TrackballBehavior(
        enable: true,
        // Display mode of trackball tooltip

        tooltipDisplayMode: TrackballDisplayMode.floatAllPoints);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCartesianChart(
        backgroundColor: Colors.white,
        trackballBehavior: _trackballBehavior,
        primaryXAxis: CategoryAxis(),

        // Enable legend
        legend: Legend(isVisible: false),

        // Enable tooltip
        tooltipBehavior: TooltipBehavior(enable: true),

        series: <AreaSeries<ValorData, String>>[
          AreaSeries<ValorData, String>(
              name: 'Dia/Valor',
              color: Colors.black45,
              borderColor: Colors.black,
              borderWidth: 3,
              markerSettings:
                  MarkerSettings(isVisible: true), //Bolinhas do gráfico
              dataSource: <ValorData>[
                ValorData(usdtDay9, usdtHigh1D),
                ValorData(usdtDay8, usdtHigh2D),
                ValorData(usdtDay7, usdtHigh3D),
                ValorData(usdtDay6, usdtHigh4D),
                ValorData(usdtDay5, usdtHigh5D),
                ValorData(usdtDay4, usdtHigh6D),
                ValorData(usdtDay3, usdtHigh7D),
                ValorData(usdtDay2, usdtHigh8D),
                ValorData(usdtDay1, usdtHigh9D)
              ],
              xValueMapper: (ValorData valor, _) => valor.day,
              yValueMapper: (ValorData valor, _) => valor.valor,
              // Enable data label
              dataLabelSettings:
                  DataLabelSettings(isVisible: false)) //Valor das bolinhas.
        ],
      ),
    );
  }
}

class ValorData {
  ValorData(this.day, this.valor);

  final String day;
  final double valor;
}

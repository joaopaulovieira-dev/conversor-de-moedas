import 'package:conversor_moeda_jpvp/get/LoadClosures.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartUSD extends StatefulWidget {
  ChartUSD({Key key}) : super(key: key);

  @override
  _ChartUSDState createState() => _ChartUSDState();
}

class _ChartUSDState extends State<ChartUSD> {
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
                ValorData(usdDay9, usdHigh1D),
                ValorData(usdDay8, usdHigh2D),
                ValorData(usdDay7, usdHigh3D),
                ValorData(usdDay6, usdHigh4D),
                ValorData(usdDay5, usdHigh5D),
                ValorData(usdDay4, usdHigh6D),
                ValorData(usdDay3, usdHigh7D),
                ValorData(usdDay2, usdHigh8D),
                ValorData(usdDay1, usdHigh9D)
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

import 'package:conversor_moeda_jpvp/get/LoadClosures.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartCNY extends StatefulWidget {
  ChartCNY({Key key}) : super(key: key);

  @override
  _ChartCNYState createState() => _ChartCNYState();
}

class _ChartCNYState extends State<ChartCNY> {
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
                ValorData(cnyDay9, cnyHigh1D),
                ValorData(cnyDay8, cnyHigh2D),
                ValorData(cnyDay7, cnyHigh3D),
                ValorData(cnyDay6, cnyHigh4D),
                ValorData(cnyDay5, cnyHigh5D),
                ValorData(cnyDay4, cnyHigh6D),
                ValorData(cnyDay3, cnyHigh7D),
                ValorData(cnyDay2, cnyHigh8D),
                ValorData(cnyDay1, cnyHigh9D)
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

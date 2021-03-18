import 'package:conversor_moeda_jpvp/get/LoadClosures.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartAUD extends StatefulWidget {
  ChartAUD({Key key}) : super(key: key);

  @override
  _ChartAUDState createState() => _ChartAUDState();
}

class _ChartAUDState extends State<ChartAUD> {
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
                ValorData(audDay9, audHigh1D),
                ValorData(audDay8, audHigh2D),
                ValorData(audDay7, audHigh3D),
                ValorData(audDay6, audHigh4D),
                ValorData(audDay5, audHigh5D),
                ValorData(audDay4, audHigh6D),
                ValorData(audDay3, audHigh7D),
                ValorData(audDay2, audHigh8D),
                ValorData(audDay1, audHigh9D)
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

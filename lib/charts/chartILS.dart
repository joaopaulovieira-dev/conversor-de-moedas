import 'package:conversor_moeda_jpvp/get/LoadClosures.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartILS extends StatefulWidget {
  ChartILS({Key key}) : super(key: key);

  @override
  _ChartILSState createState() => _ChartILSState();
}

class _ChartILSState extends State<ChartILS> {
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
                ValorData(ilsDay9, ilsHigh1D),
                ValorData(ilsDay8, ilsHigh2D),
                ValorData(ilsDay7, ilsHigh3D),
                ValorData(ilsDay6, ilsHigh4D),
                ValorData(ilsDay5, ilsHigh5D),
                ValorData(ilsDay4, ilsHigh6D),
                ValorData(ilsDay3, ilsHigh7D),
                ValorData(ilsDay2, ilsHigh8D),
                ValorData(ilsDay1, ilsHigh9D)
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

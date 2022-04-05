import 'package:covid_pandemic/data/models/state.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:covid_pandemic/core/constants/styles.dart';

class CovidBarChart extends StatelessWidget {
  final List<ActualsTimesery> covidCases;
  late double limit;

  CovidBarChart({
    Key? key,
    required this.covidCases,
  }) : super(key: key) {
    limit = 0;
    covidCases.forEach((element) {
      if (element.newCases > limit) {
        limit = element.newCases.toDouble();
      }
    });
    print(covidCases.last);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.0,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Daily New Cases',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              height: 420,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: (limit * 1.5),
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: SideTitles(
                        margin: 5.0,
                        showTitles: true,
                        getTextStyles: (_, __) => Styles.chartLabelsTextStyle,
                        rotateAngle: 35.0,
                        getTitles: (double value) {
                          switch (value.toInt()) {
                            case 0:
                              return formatDate(
                                  covidCases[0].date, [M, '-', dd]);
                            case 1:
                              return formatDate(
                                  covidCases[1].date, [M, '-', dd]);
                            case 2:
                              return formatDate(
                                  covidCases[2].date, [M, '-', dd]);
                            case 3:
                              return formatDate(
                                  covidCases[3].date, [M, '-', dd]);
                            case 4:
                              return formatDate(
                                  covidCases[4].date, [M, '-', dd]);
                            case 5:
                              return formatDate(
                                  covidCases[5].date, [M, '-', dd]);
                            case 6:
                              return formatDate(
                                  covidCases[6].date, [M, '-', dd]);
                            default:
                              return '';
                          }
                        },
                      ),
                      rightTitles: SideTitles(
                        reservedSize: 40,
                        showTitles: true,
                      ),
                      leftTitles:
                          SideTitles(reservedSize: 40, showTitles: true)),
                  gridData: FlGridData(
                    show: true,
                    checkToShowHorizontalLine: (value) => value % 3 == 0,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: Colors.black12,
                      strokeWidth: 1.0,
                      dashArray: [5],
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: covidCases
                      .map((e) => e.newCases)
                      .toList()
                      .asMap()
                      .map((key, value) => MapEntry(
                          key,
                          BarChartGroupData(
                            x: key,
                            barRods: [
                              BarChartRodData(
                                y: value.toDouble(),
                                colors: [Colors.red],
                              ),
                            ],
                          )))
                      .values
                      .toList(),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
}

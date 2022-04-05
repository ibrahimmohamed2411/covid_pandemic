import 'package:covid_pandemic/data/models/data_model.dart';
import 'package:flutter/material.dart';

class StatisticsGrid extends StatelessWidget {
  final DataModel dataModel;
  final bool today;
  final bool yesterday;

  const StatisticsGrid({
    Key? key,
    required this.dataModel,
    required this.today,
    required this.yesterday,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        children: <Widget>[
          Flexible(
            child: Row(
              children: [
                _buildStatCard(
                    (!today && !yesterday)
                        ? 'Total Cases'
                        : today
                            ? 'Today\'s Cases'
                            : 'yesterday\'Cases',
                    (!today && !yesterday)
                        ? '${dataModel.totalCases}'
                        : today
                            ? '${dataModel.newCases}'
                            : '${dataModel.yesterdayNewCases}',
                    Colors.orange),
                _buildStatCard(
                    (!today && !yesterday)
                        ? 'Total Deaths'
                        : today
                            ? 'Today\'sDeaths'
                            : 'yesterday\'Deaths',
                    (!today && !yesterday)
                        ? '${dataModel.totalDeaths}'
                        : today
                            ? '${dataModel.newDeath}'
                            : '${dataModel.yesterdayNewDeath}',
                    Colors.red),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard('Negative Tests', '${dataModel.negativeTests}',
                    Colors.green),
                _buildStatCard('Positive test', '${dataModel.positiveTests}',
                    Colors.lightBlue),
                _buildStatCard('Case density', '${dataModel.caseDensity}/5',
                    Colors.purple),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildStatCard(String title, String count, MaterialColor color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FittedBox(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            FittedBox(
              child: Text(
                count,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

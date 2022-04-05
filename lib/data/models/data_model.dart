import 'package:covid_pandemic/data/models/state.dart';

abstract class DataModel {
  int get totalCases;

  int get totalDeaths;

  int get positiveTests;

  int get activeVaccinations;

  int get negativeTests;

  int get populationNumber;

  int get caseDensity;

  int get newCases;

  int get newDeath;

  int get yesterdayNewCases;

  int get yesterdayNewDeath;

  List<ActualsTimesery> get actualLastWeek;
}

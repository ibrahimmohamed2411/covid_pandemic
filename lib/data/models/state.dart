// To parse this JSON data, do
//
//     final state = stateFromJson(jsonString);

import 'dart:convert';

import 'package:covid_pandemic/data/models/data_model.dart';

State stateFromJson(String str) => State.fromJson(json.decode(str));

String stateToJson(State data) => json.encode(data.toJson());

class State implements DataModel {
  State({
    required this.state,
    required this.population,
    required this.actuals,
    required this.lastUpdatedDate,
    required this.actualsTimeseries,
    required this.riskLevelsTimeseries,
  });

  String state;
  int population;
  Actuals actuals;
  DateTime lastUpdatedDate;
  List<ActualsTimesery> actualsTimeseries;
  List<RiskLevelsTimesery> riskLevelsTimeseries;

  factory State.fromJson(Map<String, dynamic> json) => State(
        state: json["state"],
        population: json["population"],
        actuals: Actuals.fromJson(json["actuals"]),
        lastUpdatedDate: DateTime.parse(json["lastUpdatedDate"]),
        actualsTimeseries: List<ActualsTimesery>.from(
            json["actualsTimeseries"].map((x) => ActualsTimesery.fromJson(x))),
        riskLevelsTimeseries: List<RiskLevelsTimesery>.from(
            json["riskLevelsTimeseries"]
                .map((x) => RiskLevelsTimesery.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "state": state,
        "population": population,
        "actuals": actuals.toJson(),
        "lastUpdatedDate":
            "${lastUpdatedDate.year.toString().padLeft(4, '0')}-${lastUpdatedDate.month.toString().padLeft(2, '0')}-${lastUpdatedDate.day.toString().padLeft(2, '0')}",
        "actualsTimeseries":
            List<dynamic>.from(actualsTimeseries.map((x) => x.toJson())),
        "riskLevelsTimeseries":
            List<dynamic>.from(riskLevelsTimeseries.map((x) => x.toJson())),
      };

  @override
  int get activeVaccinations => actuals.vaccinationsInitiated;

  @override
  int get negativeTests => actuals.negativeTests;

  @override
  int get positiveTests => actuals.positiveTests;

  @override
  int get totalCases => actuals.cases;

  @override
  int get populationNumber => population;

  @override
  int get totalDeaths => actuals.deaths;

  @override
  int get caseDensity => riskLevelsTimeseries.last.caseDensity;

  @override
  List<ActualsTimesery> get actualLastWeek {
    List<ActualsTimesery> lastWeek = [];
    for (int i = actualsTimeseries.length - 8;
        i < actualsTimeseries.length;
        i++) {
      lastWeek.add(actualsTimeseries[i]);
    }
    return lastWeek;
  }

  @override
  int get newCases => actuals.newCases;

  @override
  int get newDeath => actuals.newDeaths;

  @override
  int get yesterdayNewCases =>
      actualsTimeseries[actualsTimeseries.length - 3].newCases;

  @override
  int get yesterdayNewDeath =>
      actualsTimeseries[actualsTimeseries.length - 3].newDeaths;
}

class Actuals {
  Actuals({
    required this.cases,
    required this.deaths,
    required this.positiveTests,
    required this.negativeTests,
    required this.contactTracers,
    required this.hospitalBeds,
    required this.icuBeds,
    required this.newCases,
    required this.newDeaths,
    required this.vaccinesDistributed,
    required this.vaccinationsInitiated,
    required this.vaccinationsCompleted,
    required this.vaccinesAdministered,
  });

  int cases;
  int deaths;
  int positiveTests;
  int negativeTests;
  int contactTracers;
  Beds hospitalBeds;
  Beds icuBeds;
  int newCases;
  int newDeaths;
  int vaccinesDistributed;
  int vaccinationsInitiated;
  int vaccinationsCompleted;
  int vaccinesAdministered;

  factory Actuals.fromJson(Map<String, dynamic> json) => Actuals(
        cases: json["cases"],
        deaths: json["deaths"],
        positiveTests: json["positiveTests"],
        negativeTests: json["negativeTests"],
        contactTracers: json["contactTracers"],
        hospitalBeds: Beds.fromJson(json["hospitalBeds"]),
        icuBeds: Beds.fromJson(json["icuBeds"]),
        newCases: json["newCases"],
        newDeaths: json["newDeaths"],
        vaccinesDistributed: json["vaccinesDistributed"],
        vaccinationsInitiated: json["vaccinationsInitiated"],
        vaccinationsCompleted: json["vaccinationsCompleted"],
        vaccinesAdministered: json["vaccinesAdministered"],
      );

  Map<String, dynamic> toJson() => {
        "cases": cases,
        "deaths": deaths,
        "positiveTests": positiveTests,
        "negativeTests": negativeTests,
        "contactTracers": contactTracers,
        "hospitalBeds": hospitalBeds.toJson(),
        "icuBeds": icuBeds.toJson(),
        "newCases": newCases,
        "newDeaths": newDeaths,
        "vaccinesDistributed": vaccinesDistributed,
        "vaccinationsInitiated": vaccinationsInitiated,
        "vaccinationsCompleted": vaccinationsCompleted,
        "vaccinesAdministered": vaccinesAdministered,
      };
}

class Beds {
  Beds({
    required this.capacity,
    required this.currentUsageTotal,
    required this.currentUsageCovid,
  });

  int capacity;
  int currentUsageTotal;
  int currentUsageCovid;

  factory Beds.fromJson(Map<String, dynamic> json) => Beds(
        capacity: json["capacity"] ?? 0,
        currentUsageTotal: json["currentUsageTotal"] ?? 0,
        currentUsageCovid: json["currentUsageCovid"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "capacity": capacity,
        "currentUsageTotal": currentUsageTotal,
        "currentUsageCovid": currentUsageCovid,
      };
}

class ActualsTimesery {
  ActualsTimesery({
    required this.cases,
    required this.deaths,
    required this.positiveTests,
    required this.negativeTests,
    required this.contactTracers,
    required this.hospitalBeds,
    required this.icuBeds,
    required this.newCases,
    required this.newDeaths,
    required this.date,
  });

  int cases;
  int deaths;
  int positiveTests;
  int negativeTests;
  int contactTracers;
  Beds hospitalBeds;
  Beds icuBeds;
  int newCases;
  int newDeaths;
  DateTime date;

  factory ActualsTimesery.fromJson(Map<String, dynamic> json) =>
      ActualsTimesery(
        cases: json["cases"] ?? 0,
        deaths: json["deaths"] ?? 0,
        positiveTests: json["positiveTests"] ?? 0,
        negativeTests: json["negativeTests"] ?? 0,
        contactTracers: json["contactTracers"] ?? 0,
        hospitalBeds: Beds.fromJson(json["hospitalBeds"]),
        icuBeds: Beds.fromJson(json["icuBeds"]),
        newCases: json["newCases"] ?? 0,
        newDeaths: json["newDeaths"] ?? 0,
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "cases": cases,
        "deaths": deaths,
        "positiveTests": positiveTests,
        "negativeTests": negativeTests,
        "contactTracers": contactTracers,
        "hospitalBeds": hospitalBeds.toJson(),
        "icuBeds": icuBeds.toJson(),
        "newCases": newCases,
        "newDeaths": newDeaths,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      };
}

class RiskLevelsTimesery {
  RiskLevelsTimesery({
    required this.overall,
    required this.caseDensity,
    required this.date,
  });

  int overall;
  int caseDensity;
  DateTime date;

  factory RiskLevelsTimesery.fromJson(Map<String, dynamic> json) =>
      RiskLevelsTimesery(
        overall: json["overall"],
        caseDensity: json["caseDensity"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "overall": overall,
        "caseDensity": caseDensity,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      };
}

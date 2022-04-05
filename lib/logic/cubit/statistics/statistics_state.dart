part of 'statistics_cubit.dart';

abstract class StatisticsState extends Equatable {
  const StatisticsState();
}

class StatisticsInitialState extends StatisticsState {
  @override
  List<Object> get props => [];
}

class StatisticsLoadingState extends StatisticsState {
  @override
  List<Object> get props => [];
}

class StatisticsErrorState extends StatisticsState {
  @override
  List<Object> get props => [];
}

class StatisticsLoadedState extends StatisticsState {
  final State state;
  final Country country;
  final bool useState;
  final bool today;
  final bool yesterday;
  final String stateName;

  const StatisticsLoadedState(
      {required this.state,
      required this.country,
      required this.useState,
      required this.today,
      required this.yesterday,
      required this.stateName});

  StatisticsLoadedState copyWith(
          {bool? useState, bool? today, bool? yesterday}) =>
      StatisticsLoadedState(
        state: state,
        country: country,
        useState: useState ?? this.useState,
        today: today ?? this.today,
        yesterday: yesterday ?? this.yesterday,
        stateName: stateName,
      );

  @override
  List<Object> get props => [useState, today, yesterday];
}

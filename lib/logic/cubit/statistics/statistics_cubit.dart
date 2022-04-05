import 'package:bloc/bloc.dart';
import 'package:covid_pandemic/core/constants/state_to_iso.dart';
import 'package:covid_pandemic/data/models/country.dart';
import 'package:covid_pandemic/data/models/state.dart';
import 'package:covid_pandemic/data/repositories/statistics_repository.dart';
import 'package:equatable/equatable.dart';

part 'statistics_state.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  StatisticsRepository statisticsRepository;

  StatisticsCubit({required this.statisticsRepository})
      : super(StatisticsInitialState());

  void initialize({required String stateCode}) async {
    try {
      State state = await statisticsRepository.getStateData(stateCode);
      Country country = await statisticsRepository.getCountryData();
      print(stateCode);
      emit(StatisticsLoadedState(
          state: state,
          country: country,
          useState: true,
          today: false,
          yesterday: false,
          stateName: StateToIso.stateToName[stateCode]!));
    } catch (e) {
      emit(StatisticsErrorState());
    }
  }

  void stateOnClick() {
    if (state is StatisticsLoadedState) {
      emit((state as StatisticsLoadedState).copyWith(useState: true));
    }
  }

  void countryOnClick() {
    if (state is StatisticsLoadedState) {
      emit((state as StatisticsLoadedState).copyWith(useState: false));
    }
  }

  void todayOnClick() {
    if (state is StatisticsLoadedState) {
      emit((state as StatisticsLoadedState)
          .copyWith(today: true, yesterday: false));
    }
  }

  void yesterdayOnClick() {
    if (state is StatisticsLoadedState) {
      emit((state as StatisticsLoadedState)
          .copyWith(today: false, yesterday: true));
    }
  }

  void totalOnClick() {
    if (state is StatisticsLoadedState) {
      emit((state as StatisticsLoadedState)
          .copyWith(today: false, yesterday: false));
    }
  }
}

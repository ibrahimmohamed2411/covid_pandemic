import 'package:covid_pandemic/data/dataProviders/country_api.dart';
import 'package:covid_pandemic/data/dataProviders/state_api.dart';
import 'package:covid_pandemic/data/models/country.dart';
import 'package:covid_pandemic/data/models/state.dart';

class StatisticsRepository {
  final StateApi _stateApi = StateApi.instance;

  final CountryApi _countryApi = CountryApi.instance;

  StatisticsRepository();

  Future<State> getStateData(String stateCode) async {
    Map<String, dynamic> response =
        await _stateApi.fetchStateInformation(stateCode: stateCode);

    return State.fromJson(response);
  }

  Future<Country> getCountryData() async {
    Map<String, dynamic> response = await _countryApi.fetchCountryInformation();

    return Country.fromJson(response);
  }
}

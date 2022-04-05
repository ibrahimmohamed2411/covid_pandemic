import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:covid_pandemic/core/constants/palette.dart';
import 'package:covid_pandemic/core/constants/styles.dart';
import 'package:covid_pandemic/logic/cubit/statistics/statistics_cubit.dart';
import 'package:covid_pandemic/presentation/widgets/covid_bar_chart.dart';
import 'package:covid_pandemic/presentation/widgets/custom_app_bar.dart';
import 'package:covid_pandemic/presentation/widgets/drawer.dart';
import 'package:covid_pandemic/presentation/widgets/stats_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      appBar: const CustomAppBar(),
      drawer: const DrawerWidget(),
      body: BlocConsumer<StatisticsCubit, StatisticsState>(
        listener: (context, state) {
          if (state is StatisticsLoadedState) {}
        },
        builder: (context, state) {
          if (state is StatisticsLoadedState) {
            return CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: <Widget>[
                _buildHeader(state),
                _buildRegionTabBar(),
                _buildStatsTabBar(),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  sliver: SliverToBoxAdapter(
                    child: StatisticsGrid(
                        dataModel: state.useState ? state.state : state.country,
                        today: state.today,
                        yesterday: state.yesterday),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(top: 20.0),
                  sliver: SliverToBoxAdapter(
                    child: CovidBarChart(
                      covidCases: state.useState
                          ? state.state.actualLastWeek
                          : state.country.actualLastWeek,
                    ),
                  ),
                ),
              ],
            );
          } else if (state is StatisticsErrorState) {
            return const Center(
              child: Text('Error'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  SliverPadding _buildHeader(StatisticsLoadedState state) {
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Statistics',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${state.stateName}/USA',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildRegionTabBar() {
    return SliverToBoxAdapter(
      child: DefaultTabController(
        length: 2,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: TabBar(
            indicator: const BubbleTabIndicator(
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
              indicatorHeight: 40.0,
              indicatorColor: Colors.white,
            ),
            labelStyle: Styles.tabTextStyle,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            tabs: const [
              Text('Current state'),
              Text('Country'),
            ],
            onTap: (index) {
              final cubit = context.read<StatisticsCubit>();
              if (index == 0) {
                cubit.stateOnClick();
              } else if (index == 1) {
                cubit.countryOnClick();
              }
            },
          ),
        ),
      ),
    );
  }

  SliverPadding _buildStatsTabBar() {
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: DefaultTabController(
          length: 3,
          child: TabBar(
            indicatorColor: Colors.transparent,
            labelStyle: Styles.tabTextStyle,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            tabs: <Widget>[
              Text('Total'),
              Text('Today'),
              Text('Yesterday'),
            ],
            onTap: (index) {
              if (index == 0) {
                context.read<StatisticsCubit>().totalOnClick();
              } else if (index == 1) {
                context.read<StatisticsCubit>().todayOnClick();
              } else if (index == 2) {
                context.read<StatisticsCubit>().yesterdayOnClick();
              }
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:covid_pandemic/core/constants/palette.dart';
import 'package:covid_pandemic/core/constants/question.dart';
import 'package:covid_pandemic/logic/cubit/statistics/statistics_cubit.dart';
import 'package:covid_pandemic/presentation/screens/questions/widgets/web_view.dart';
import 'package:covid_pandemic/presentation/widgets/custom_app_bar.dart';
import 'package:covid_pandemic/presentation/widgets/drawer.dart';
import 'package:covid_pandemic/presentation/widgets/main_button.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({Key? key}) : super(key: key);

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  double percent = 0;
  bool computed = false;
  final List<bool> _chronicDiseases = [
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  final List<bool> _possibleSymptoms = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  final List<bool> _precautionsToBeFollowed = [false, false, false];
  final List<bool> _activitiesYouDo = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: const CustomAppBar(),
      drawer: const DrawerWidget(),
      body: BlocBuilder<StatisticsCubit, StatisticsState>(
        builder: (context, state) {
          if (state is StatisticsLoadedState) {
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    AbsorbPointer(
                      absorbing: true,
                      child: SleekCircularSlider(
                        initialValue: computed ? percent : 0,
                        onChange: (value) => setState(() {
                          percent = value;
                        }),
                        max: 100,
                        min: 0,
                      ),
                    ),
                    ComputeWidget(),
                    ExpansionTile(
                      title: const Text(
                          'Do you have any of these chronic diseases'),
                      children: [
                        buildListTile(
                            index: 0,
                            title: 'Kidney disease.',
                            question: _chronicDiseases,
                            evaluationMap: Questions.chronicDiseases),
                        buildListTile(
                            index: 1,
                            title: 'Chronic lung.',
                            question: _chronicDiseases,
                            evaluationMap: Questions.chronicDiseases),
                        buildListTile(
                            index: 2,
                            title: 'Diabetes.',
                            question: _chronicDiseases,
                            evaluationMap: Questions.chronicDiseases),
                        buildListTile(
                            index: 3,
                            title: 'Cancer for pregnant women.',
                            question: _chronicDiseases,
                            evaluationMap: Questions.chronicDiseases),
                        buildListTile(
                            index: 4,
                            title: 'Hypertension.',
                            question: _chronicDiseases,
                            evaluationMap: Questions.chronicDiseases),
                        buildListTile(
                          index: 5,
                          title: 'The heart.',
                          question: _chronicDiseases,
                          evaluationMap: Questions.chronicDiseases,
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: const Text(
                          'Do you have any of the following symptoms?'),
                      children: [
                        buildListTile(
                          index: 0,
                          title: 'Loss of sense of smell.',
                          question: _possibleSymptoms,
                          evaluationMap: Questions.possibleSymptoms,
                        ),
                        buildListTile(
                          index: 1,
                          title: 'Bone pain.',
                          question: _possibleSymptoms,
                          evaluationMap: Questions.possibleSymptoms,
                        ),
                        buildListTile(
                          index: 2,
                          title: 'Increase in temperature.',
                          question: _possibleSymptoms,
                          evaluationMap: Questions.possibleSymptoms,
                        ),
                        buildListTile(
                          index: 3,
                          title: 'Diarrhea.',
                          question: _possibleSymptoms,
                          evaluationMap: Questions.possibleSymptoms,
                        ),
                        buildListTile(
                          index: 4,
                          title: 'Shortness of breath.',
                          question: _possibleSymptoms,
                          evaluationMap: Questions.possibleSymptoms,
                        ),
                        buildListTile(
                          index: 5,
                          title: 'Headache.',
                          question: _possibleSymptoms,
                          evaluationMap: Questions.possibleSymptoms,
                        ),
                        buildListTile(
                          index: 6,
                          title: 'Sore throat.',
                          question: _possibleSymptoms,
                          evaluationMap: Questions.possibleSymptoms,
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: const Text('Do you not do the following?'),
                      children: [
                        buildListTile(
                          index: 0,
                          title:
                              'Wash your hands well and use sanitizers such as alcohol etc..',
                          question: _precautionsToBeFollowed,
                          evaluationMap: Questions.precautionsToBeFollowed,
                        ),
                        buildListTile(
                          index: 1,
                          title: 'Wearing a mask in public places and gloves.',
                          question: _precautionsToBeFollowed,
                          evaluationMap: Questions.precautionsToBeFollowed,
                        ),
                        buildListTile(
                          index: 2,
                          title: 'Avoid crowded places.',
                          question: _precautionsToBeFollowed,
                          evaluationMap: Questions.precautionsToBeFollowed,
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: const Text('Activities you do'),
                      children: [
                        buildListTile(
                          index: 0,
                          title: 'Work or study.',
                          question: _activitiesYouDo,
                          evaluationMap: Questions.activitiesYouDo,
                        ),
                        buildListTile(
                          index: 1,
                          title: 'The shopping.',
                          question: _activitiesYouDo,
                          evaluationMap: Questions.activitiesYouDo,
                        ),
                        buildListTile(
                          index: 3,
                          title: 'Public Transport.',
                          question: _activitiesYouDo,
                          evaluationMap: Questions.activitiesYouDo,
                        ),
                        buildListTile(
                          index: 4,
                          title: 'Religious places, funerals or weddings.',
                          question: _activitiesYouDo,
                          evaluationMap: Questions.activitiesYouDo,
                        ),
                        buildListTile(
                          index: 5,
                          title: 'Cinemas.',
                          question: _activitiesYouDo,
                          evaluationMap: Questions.activitiesYouDo,
                        ),
                        buildListTile(
                          index: 6,
                          title: 'Visiting relatives.',
                          question: _activitiesYouDo,
                          evaluationMap: Questions.activitiesYouDo,
                        ),
                        buildListTile(
                          index: 7,
                          title: 'Strolling on the beach.',
                          question: _activitiesYouDo,
                          evaluationMap: Questions.activitiesYouDo,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MainButton(
                      title: 'Compute',
                      onPressed: () {
                        if (percent != 0) {
                          setState(() {
                            computed = true;
                          });
                        }
                      },
                      color: Palette.primaryColor,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget ComputeWidget() {
    if (computed) {
      if (percent > 0 && percent < 30) {
        return safeWidget(percent.toInt());
      } else if (percent > 30 && percent < 70) {
        return moderateWidget(percent.toInt());
      } else {
        return highWidget(percent.toInt());
      }
    } else {
      return Container();
    }
  }

  Widget safeWidget(int score) => Column(
        children: [
          Text(
              'The risk score for people with similar characteristics and behaviors as you is $score , which is (relatively) safe.'
              ' Even so, it\'s a good time to make sure that you\'re'),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const WebView2(
                        url:
                            'https://www.cdc.gov/coronavirus/2019-ncov/prevent-getting-sick/prevention.html?CDC_AA_refVal=https%3A%2F%2Fwww.cdc.gov%2Fcoronavirus%2F2019-ncov%2Fdaily-life-coping%2Fchecklist-household-ready.html')));
              },
              child: Text('Prepared')),
        ],
      );

  Widget moderateWidget(int score) => Column(
        children: [
          Text(
              'The risk score for people with similar characteristics and behaviors as you is $score . Please take the time to review this'),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const WebView2(
                          url:
                              'https://www.cdc.gov/coronavirus/2019-ncov/prevent-getting-sick/prevention.html?CDC_AA_refVal=https%3A%2F%2Fwww.cdc.gov%2Fcoronavirus%2F2019-ncov%2Fdaily-life-coping%2Fchecklist-household-ready.html',
                        )));
              },
              child: const Text('page')),
        ],
      );

  Widget highWidget(int score) => Column(
        children: [
          Text(
              'The risk score for people with similar characteristics and behaviors as you is $score , which is quite serious. Avoiding exposure, practicing good hygiene, and making sure you have a'),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const WebView2(
                          url:
                              'https://www.cdc.gov/coronavirus/2019-ncov/prevent-getting-sick/prevention.html',
                        )));
              },
              child: const Text('plan in place')),
        ],
      );

  ListTile buildListTile({
    required int index,
    required String title,
    required List<bool> question,
    required Map<String, int> evaluationMap,
  }) {
    return ListTile(
      dense: true,
      leading: Checkbox(
          value: question[index],
          onChanged: (val) {
            setState(() {
              question[index] = val!;

              if (val == true) {
                percent += evaluationMap[title]!;
              } else {
                percent -= evaluationMap[title]!;
              }
            });
            print(percent);
          }),
      title: Text(title),
    );
  }
}

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:covid_pandemic/core/constants/styles.dart';
import 'package:covid_pandemic/presentation/screens/onBoarding/widgets/on_boarding_card.dart';
import 'package:covid_pandemic/presentation/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);
  final List<Widget> middle = [
    Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Order',
          style: Styles.title1,
        ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Order all you want from your\n favourite stores.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    ),
    Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Pick Delivery Time',
          style: Styles.title1,
        ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Receive your order in less than 1 hour.\n'
            'Or pick a specific delivery time',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    ),
    Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Get Your Order',
          style: Styles.title1,
        ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Real-time tracking will keep you posted\n'
            'about order progress.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    ),
  ];

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  final CarouselController _carouselController1 = CarouselController();
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 60),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Welcome',
                  style: Styles.title1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: SizedBox(
                child: CarouselSlider(
                  carouselController: _carouselController1,
                  options: CarouselOptions(
                    height: 390,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.scale,
                    onPageChanged: (index, reason) {
                      setState(() {
                        activeIndex = index;
                        _animationController.reset();
                        _animationController.forward();
                      });
                    },
                  ),
                  items: const [
                    OnBoardingCard(imageName: 'onBoarding1.jpg'),
                    OnBoardingCard(imageName: 'onBoarding2.jpg'),
                    OnBoardingCard(imageName: 'onBoarding3.jpg'),
                  ],
                ),
              ),
            ),
            AnimatedBuilder(
                animation: _animationController,
                child: widget.middle[activeIndex],
                builder: (context, child) {
                  return Opacity(
                    opacity: _animationController.value,
                    child: child!,
                  );
                }),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: AnimatedSmoothIndicator(
                count: 3,
                activeIndex: activeIndex,
                onDotClicked: (index) {
                  _carouselController1.animateToPage(index);
                },
                effect: WormEffect(
                    dotWidth: 10,
                    dotHeight: 10,
                    spacing: 18,
                    type: WormType.thin,
                    paintStyle: PaintingStyle.fill,
                    dotColor: Theme.of(context).primaryColor.withOpacity(0.5),
                    activeDotColor: Theme.of(context).primaryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: MainButton(
                title: 'Start Now',
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

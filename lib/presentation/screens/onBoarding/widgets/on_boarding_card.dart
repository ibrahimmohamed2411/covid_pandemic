import 'package:flutter/material.dart';

class OnBoardingCard extends StatelessWidget {
  const OnBoardingCard({Key? key, required this.imageName}) : super(key: key);
  final String imageName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10,
            )
          ],
          image: DecorationImage(
              image: AssetImage('assets/images/$imageName'), fit: BoxFit.cover),
        ),
      ),
    );
  }
}

import 'package:covid_pandemic/core/constants/palette.dart';
import 'package:covid_pandemic/logic/cubit/authentication/authentication_cubit.dart';
import 'package:covid_pandemic/presentation/screens/questions/widgets/web_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Palette.primaryColor,
        //other styles
      ),
      child: Drawer(
        child: ListView(
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(
              color: Colors.transparent,
              child: ListTile(
                leading: const Icon(
                  Icons.web,
                  color: Colors.white,
                ),
                title: const Text(
                  'Ministry of Health',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const WebView2(
                            url: 'https://www.hhs.gov/',
                          )));
                },
              ),
            ),
            Container(
              color: Colors.transparent,
              child: ListTile(
                leading: const Icon(
                  Icons.web_asset_rounded,
                  color: Colors.white,
                ),
                title: const Text(
                  'Vaccine locations near you',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const WebView2(
                            url: 'https://www.vaccines.gov/',
                          )));
                },
              ),
            ),
            Container(
              color: Colors.transparent,
              child: ListTile(
                leading: const Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  BlocProvider.of<AuthenticationCubit>(context).signOut();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:best_bread_formulation/constants/assets_constants.dart';
import 'package:best_bread_formulation/constants/ui_constants.dart';
import 'package:best_bread_formulation/features/formulation/views/create_formulation_view.dart';
import 'package:best_bread_formulation/theme/pallete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class HomeView extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const HomeView(),
      );
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _page = 0;
  final appBar = UIConstants.appBar();

  void onPageChange(int index) {
    setState(() {
      _page = index;
    });
  }

  onCreateFormulation() {
    Navigator.push(context, CreateFormulationView.route());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _page == 0 ? appBar : null,

      body: IndexedStack(
        index: _page,
        children: UIConstants.bottomTabBarPages,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onCreateFormulation,
        backgroundColor: Pallete.redColor,
        shape: CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Pallete.whiteColor,
          size: 28,
        ),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _page,
        onTap: onPageChange,
        backgroundColor: Pallete.backgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
           AssetsConstants.bread2,
                width: 30.0,
                height: 30.0
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetsConstants.bread3,
                width: 30.0, height: 30.0
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
          AssetsConstants.croissant,
                width: 30.0,
                height: 30.0
            ),
          ),
        ],
      ),
    );
  }
}

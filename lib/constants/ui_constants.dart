import 'package:best_bread_formulation/constants/assets_constants.dart';
import 'package:best_bread_formulation/features/auth/view/signup_view.dart';
import 'package:best_bread_formulation/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../features/formulation/widgets/formulation_list.dart';


class UIConstants {
  static AppBar appBar() {
    return AppBar(
      title: SvgPicture.asset(
        AssetsConstants.bread,
        height: 30,
        colorFilter: const ColorFilter.mode(Pallete.greyColor, BlendMode.dst),
      ),
      centerTitle: true,
    );
  }

  static const List<Widget> bottomTabBarPages = [
    FormulationList(),
    SignUpView(),
  ];
}

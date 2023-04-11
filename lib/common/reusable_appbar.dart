import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ReUsableAppBar extends StatelessWidget {
  const ReUsableAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: SvgPicture.asset('assets/svgs/twitter_logo.svg'),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskmanager/presentation/utils/assets_path.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AssetPath.logoSvg,
      width: 120,
      fit: BoxFit.scaleDown,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:wanas/core/theme/app_styles.dart';
import 'package:wanas/core/theme/colors.dart';

class RecitersView extends StatelessWidget {
  const RecitersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'القراء',
        style: AppStyles.font24Bold.copyWith(color: ColorsManager.primaryText),
      ),
    );
  }
}

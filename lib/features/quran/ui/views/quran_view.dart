import 'package:flutter/material.dart';
import 'package:wanas/core/theme/app_styles.dart';
import 'package:wanas/core/theme/colors.dart';

class QuranView extends StatelessWidget {
  const QuranView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'القرآن الكريم',
        style: AppStyles.font24Bold.copyWith(color: ColorsManager.primaryText),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanas/core/helper/constants.dart';
import 'package:wanas/core/helper/shared_pref_helper.dart';
import 'wanas.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  final bool isOnboardingDone = await SharedPrefHelper.getBool(
    SharedPrefKeys.onboardingDone,
  );
  runApp(Wanas(isOnboardingDone: isOnboardingDone));
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wanas/core/routing/app_router.dart';
import 'package:wanas/core/theme/colors.dart';

class Wanas extends StatelessWidget {
  const Wanas({super.key, required this.isOnboardingDone});

  final bool isOnboardingDone;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(374, 812),
      ensureScreenSize: true,
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      child: MaterialApp.router(
        routerConfig: AppRouter.router(isOnboardingDone),
        title: 'Wanas',
        locale: const Locale('ar'),
        supportedLocales: const [Locale('ar')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: ThemeData(
          fontFamily: 'NotoSansArabic',
          primaryColor: ColorsManager.primaryText,
          scaffoldBackgroundColor: ColorsManager.primaryBackground,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

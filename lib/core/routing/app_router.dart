import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wanas/features/home/ui/views/home_view.dart';
import 'package:wanas/features/onboarding/ui/views/onboarding_view.dart';

abstract class AppRouter {
  static const kSplashView = '/';
  static const kOnboardingView = '/onboardingView';
  static const kHomeView = '/homeView';

  static GoRouter router(bool isOnboardingDone) => GoRouter(
    initialLocation: isOnboardingDone ? kHomeView : kSplashView,
    routes: [
      GoRoute(
        path: kSplashView,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const OnboardingView(),
          transitionsBuilder: customNavigateAnimation,
        ),
      ),
      GoRoute(
        path: kHomeView,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const HomeView(),
          transitionsBuilder: customNavigateAnimation,
        ),
      ),
    ],
  );
}

Widget customNavigateAnimation(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  const begin = Offset(1.0, 0.0);
  const end = Offset.zero;
  const curve = Curves.easeOut;

  final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  final offsetAnimation = animation.drive(tween);

  return SlideTransition(position: offsetAnimation, child: child);
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:wanas/core/helper/constants.dart';
import 'package:wanas/core/helper/shared_pref_helper.dart';
import 'package:wanas/core/routing/app_router.dart';
import 'package:wanas/core/theme/app_styles.dart';
import 'package:wanas/core/theme/colors.dart';
import 'package:wanas/features/onboarding/data/models/onboarding_model.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingModel> onboardingList = const [
    OnboardingModel(
      image: 'assets/images/first.png',
      title: 'اكتشف تلاوتك',
      subtitle: 'دعنا نختار لك تلاوة مخصصة لك',
    ),
    OnboardingModel(
      image: 'assets/images/second.png',
      title: 'تلاوة خاشعة',
      subtitle: 'استمتع بتلاوات خاشعة ومؤثرة من القرآن الكريم',
    ),
    OnboardingModel(
      image: 'assets/images/third.png',
      title: 'هدوء في بيت الله',
      subtitle: 'تفعيل وضع المسجد تلقائيا عند دخولك المسجد',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primaryBackground,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () async {
                  await SharedPrefHelper.setData(
                    SharedPrefKeys.onboardingDone,
                    true,
                  );
                  if (context.mounted) {
                    GoRouter.of(context).go(AppRouter.kHomeView);
                  }
                },
                child: Text(
                  'تخطي',
                  style: AppStyles.font14Regular.copyWith(
                    color: ColorsManager.primaryText,
                  ),
                ),
              ),
            ),

            // PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingList.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return _buildOnboardingPage(onboardingList[index]);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onboardingList.length,
                  (index) => _buildDotIndicator(index),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              child: SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_currentPage < onboardingList.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      await SharedPrefHelper.setData(
                        SharedPrefKeys.onboardingDone,
                        true,
                      );
                      if (context.mounted) {
                        GoRouter.of(context).go(AppRouter.kHomeView);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManager.primaryAccent,
                    foregroundColor: ColorsManager.primaryBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    _currentPage == onboardingList.length - 1
                        ? 'ابدأ الآن'
                        : 'التالي',
                    style: AppStyles.font20Bold,
                  ),
                ),
              ),
            ),

            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(OnboardingModel model) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 300.h,
            child: Image.asset(
              model.image,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 300.h,
                  decoration: BoxDecoration(
                    color: ColorsManager.secondaryBackground,
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: Icon(
                    Icons.image_outlined,
                    size: 80.sp,
                    color: ColorsManager.secondaryText,
                  ),
                );
              },
            ),
          ),

          Text(
            model.title,
            textAlign: TextAlign.center,
            style: AppStyles.font26Bold.copyWith(
              color: ColorsManager.primaryText,
            ),
          ),

          SizedBox(height: 16.h),
          Text(
            model.subtitle,
            textAlign: TextAlign.center,
            style: AppStyles.font14SemiBold.copyWith(
              color: ColorsManager.secondaryText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDotIndicator(int index) {
    bool isActive = _currentPage == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      width: isActive ? 28.w : 10.w,
      height: 10.h,
      decoration: BoxDecoration(
        color: isActive
            ? ColorsManager.primaryAccent
            : ColorsManager.secondaryBackground,
        borderRadius: BorderRadius.circular(8.r),
      ),
    );
  }
}

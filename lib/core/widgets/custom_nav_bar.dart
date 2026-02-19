import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wanas/core/theme/app_styles.dart';
import 'package:wanas/core/theme/colors.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const _items = [
    _NavItemData(icon: Icons.mic_rounded, label: 'القراء'),
    _NavItemData(icon: Icons.home_rounded, label: 'الرئيسية'),
    _NavItemData(icon: Icons.menu_book_rounded, label: 'القرآن'),
  ];

  static const _visualToLogical = [2, 0, 1];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: ColorsManager.secondaryBackground,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 24,
            spreadRadius: 0,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: ColorsManager.primaryAccent.withValues(alpha: 0.08),
            blurRadius: 40,
            spreadRadius: -4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_items.length, (visualIndex) {
          final logicalIndex = _visualToLogical[visualIndex];
          final item = _items[visualIndex];
          final isActive = currentIndex == logicalIndex;

          return _NavTab(
            icon: item.icon,
            label: item.label,
            isActive: isActive,
            onTap: () => onTap(logicalIndex),
          );
        }),
      ),
    );
  }
}

class _NavItemData {
  const _NavItemData({required this.icon, required this.label});
  final IconData icon;
  final String label;
}
class _NavTab extends StatelessWidget {
  const _NavTab({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.symmetric(
          horizontal: isActive ? 20.w : 14.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: isActive
              ? ColorsManager.primaryAccent.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder<Color?>(
              tween: ColorTween(
                end: isActive
                    ? ColorsManager.primaryAccent
                    : ColorsManager.secondaryText,
              ),
              duration: const Duration(milliseconds: 300),
              builder: (context, color, _) {
                return Icon(icon, size: 24.sp, color: color);
              },
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: isActive
                  ? Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: const Duration(milliseconds: 250),
                        builder: (context, opacity, child) {
                          return Opacity(opacity: opacity, child: child);
                        },
                        child: Text(
                          label,
                          style: AppStyles.font12Regular.copyWith(
                            color: ColorsManager.primaryAccent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}

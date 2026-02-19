import 'package:flutter/material.dart';
import 'package:wanas/core/theme/app_styles.dart';
import 'package:wanas/core/theme/colors.dart';
import 'package:wanas/core/widgets/custom_nav_bar.dart';
import 'package:wanas/features/quran/ui/views/quran_view.dart';
import 'package:wanas/features/reciters/ui/views/reciters_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    _HomeContent(),
    QuranView(),
    RecitersView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: ColorsManager.primaryBackground,
      body: SafeArea(
        child: IndexedStack(index: _currentIndex, children: _pages),
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

/// The actual home page content (extracted from old HomeView body).
class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'الرئيسية',
        style: AppStyles.font24Bold.copyWith(color: ColorsManager.primaryText),
      ),
    );
  }
}

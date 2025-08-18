import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_nav.dart';
import '../utils/app_theme.dart';
import 'home_screen.dart';
import 'doctors_screen.dart';
import 'services_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const DoctorsScreen(),
    const ServicesScreen(),
    const ProfileScreen(),
  ];

  final List<String> _titles = [
    '',
    'Our Doctors',
    'Our Services',
    'My Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: _titles[_currentIndex],
        showLanguageToggle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: CustomBottomNav(
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
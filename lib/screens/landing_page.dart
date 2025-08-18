import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../providers/language_provider.dart';
import '../l10n/app_localizations.dart';
import '../utils/app_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/animated_button.dart';
import 'main_screen.dart';
import 'auth/login_screen.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  late AnimationController _floatingController;
  late Animation<double> _floatingAnimation;

  @override
  void initState() {
    super.initState();
    _floatingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _floatingAnimation = Tween<double>(
      begin: 0,
      end: 10,
    ).animate(CurvedAnimation(
      parent: _floatingController,
      curve: Curves.easeInOut,
    ));

    _floatingController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Header with Logo and Language Toggle
                AnimationConfiguration.staggeredList(
                  position: 0,
                  duration: const Duration(milliseconds: 800),
                  child: SlideAnimation(
                    verticalOffset: -50,
                    child: FadeInAnimation(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Logo
                          Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  gradient: AppTheme.primaryGradient,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Icon(
                                  Icons.local_hospital,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Samad',
                                    style: AppTheme.headingMedium.copyWith(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    'Nursing Home',
                                    style: AppTheme.bodyMedium.copyWith(
                                      color: AppTheme.darkGray,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // Language Toggle
                          Consumer<LanguageProvider>(
                            builder: (context, languageProvider, child) {
                              return GestureDetector(
                                onTap: () {
                                  languageProvider.changeLanguage(
                                    languageProvider.isEnglish
                                        ? const Locale('hi', '')
                                        : const Locale('en', ''),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: AppTheme.lightGradient,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.language,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        languageProvider.isEnglish ? 'EN' : 'हि',
                                        style: AppTheme.bodyMedium.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Hero Section
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Floating Illustration
                      AnimationConfiguration.staggeredList(
                        position: 1,
                        duration: const Duration(milliseconds: 1000),
                        child: SlideAnimation(
                          verticalOffset: 50,
                          child: FadeInAnimation(
                            child: AnimatedBuilder(
                              animation: _floatingAnimation,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: Offset(0, _floatingAnimation.value),
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      gradient: AppTheme.lightGradient,
                                      borderRadius: BorderRadius.circular(100),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppTheme.primaryBlue.withOpacity(0.3),
                                          blurRadius: 30,
                                          offset: const Offset(0, 15),
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.medical_services,
                                      color: Colors.white,
                                      size: 80,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Hero Text
                      AnimationConfiguration.staggeredList(
                        position: 2,
                        duration: const Duration(milliseconds: 1200),
                        child: SlideAnimation(
                          verticalOffset: 30,
                          child: FadeInAnimation(
                            child: Column(
                              children: [
                                AnimatedTextKit(
                                  animatedTexts: [
                                    TypewriterAnimatedText(
                                      localizations.welcomeTitle,
                                      textStyle: AppTheme.headingLarge.copyWith(
                                        fontSize: 28,
                                      ),
                                      speed: const Duration(milliseconds: 100),
                                    ),
                                  ],
                                  totalRepeatCount: 1,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  localizations.welcomeSubtitle,
                                  style: AppTheme.bodyLarge.copyWith(
                                    fontSize: 16,
                                    height: 1.6,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 50),

                      // Get Started Button
                      AnimationConfiguration.staggeredList(
                        position: 3,
                        duration: const Duration(milliseconds: 1400),
                        child: SlideAnimation(
                          verticalOffset: 30,
                          child: FadeInAnimation(
                            child: AnimatedButton(
                              text: localizations.getStarted,
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                              width: double.infinity,
                              height: 60,
                              icon: Icons.arrow_forward_rounded,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Footer
                AnimationConfiguration.staggeredList(
                  position: 4,
                  duration: const Duration(milliseconds: 1600),
                  child: SlideAnimation(
                    verticalOffset: 20,
                    child: FadeInAnimation(
                      child: GlassCard(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: () {
                                // Terms of Service
                              },
                              child: Text(
                                'Terms of Service',
                                style: AppTheme.bodySmall.copyWith(
                                  color: AppTheme.primaryBlue,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 16,
                              color: AppTheme.darkGray.withOpacity(0.3),
                            ),
                            TextButton(
                              onPressed: () {
                                // Privacy Policy
                              },
                              child: Text(
                                'Privacy Policy',
                                style: AppTheme.bodySmall.copyWith(
                                  color: AppTheme.primaryBlue,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
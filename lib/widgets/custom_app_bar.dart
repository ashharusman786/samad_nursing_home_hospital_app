import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../providers/language_provider.dart';
import '../utils/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showLanguageToggle;
  final bool showBackButton;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showLanguageToggle = true,
    this.showBackButton = false,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      decoration: const BoxDecoration(
        gradient: AppTheme.backgroundGradient,
      ),
      child: SafeArea(
        child: GlassmorphicContainer(
          width: double.infinity,
          height: 60,
          borderRadius: 0,
          blur: 20,
          alignment: Alignment.bottomCenter,
          border: 0,
          linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(0.3),
              Colors.white.withOpacity(0.1),
            ],
          ),
          borderGradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.transparent, Colors.transparent],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                if (showBackButton)
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: AppTheme.primaryBlue,
                    ),
                  )
                else
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: AppTheme.primaryGradient,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.local_hospital,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Samad',
                            style: AppTheme.headingSmall.copyWith(
                              fontSize: 16,
                              color: AppTheme.primaryBlue,
                            ),
                          ),
                          Text(
                            'Nursing Home',
                            style: AppTheme.bodySmall.copyWith(
                              fontSize: 12,
                              color: AppTheme.darkGray,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                const Spacer(),
                if (title.isNotEmpty)
                  Text(
                    title,
                    style: AppTheme.headingMedium.copyWith(fontSize: 18),
                  ),
                const Spacer(),
                if (showLanguageToggle)
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
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            gradient: AppTheme.lightGradient,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.language,
                                color: Colors.white,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                languageProvider.isEnglish ? 'EN' : 'हि',
                                style: AppTheme.bodySmall.copyWith(
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
                if (actions != null) ...actions!,
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
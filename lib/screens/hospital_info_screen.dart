import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/app_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/custom_app_bar.dart';

class HospitalInfoScreen extends StatelessWidget {
  const HospitalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final facilities = [
      {
        'title': 'Child Care',
        'icon': Icons.child_care,
        'description': 'Specialized pediatric care and treatment for children',
      },
      {
        'title': 'Pharmacy',
        'icon': Icons.local_pharmacy,
        'description': 'On-site pharmacy with essential medicines',
      },
      {
        'title': 'OPD',
        'icon': Icons.medical_services,
        'description': 'Outpatient department for consultations',
      },
      {
        'title': 'OB/GYN',
        'icon': Icons.pregnant_woman,
        'description': 'Obstetrics and gynecology services',
      },
      {
        'title': 'Vaccination',
        'icon': Icons.vaccines,
        'description': 'Immunization services for all age groups',
      },
    ];

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Hospital Info',
        showBackButton: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: AnimationLimiter(
            child: ListView(
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 600),
                childAnimationBuilder: (widget) => SlideAnimation(
                  verticalOffset: 50,
                  child: FadeInAnimation(child: widget),
                ),
                children: [
                  // Hospital Timings
                  GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                gradient: AppTheme.primaryGradient,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.access_time,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hospital Timings',
                                    style: AppTheme.headingSmall,
                                  ),
                                  Text(
                                    '9:00 AM - 10:00 PM',
                                    style: AppTheme.bodyLarge.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.primaryBlue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: _isHospitalOpen() 
                                    ? AppTheme.success 
                                    : AppTheme.error,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                _isHospitalOpen() ? 'Open' : 'Closed',
                                style: AppTheme.bodySmall.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Emergency Contact
                  GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: AppTheme.error,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.emergency,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Emergency Contact',
                                    style: AppTheme.headingSmall.copyWith(
                                      color: AppTheme.error,
                                    ),
                                  ),
                                  Text(
                                    '24/7 Available',
                                    style: AppTheme.bodyMedium,
                                  ),
                                  Text(
                                    '+91 7860120688',
                                    style: AppTheme.bodyLarge.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.error,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                final Uri phoneUri = Uri.parse('tel:+917860120688');
                                if (await canLaunchUrl(phoneUri)) {
                                  await launchUrl(phoneUri);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppTheme.error,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Facilities Section
                  Text(
                    'Available Facilities',
                    style: AppTheme.headingMedium,
                  ),
                  const SizedBox(height: 16),

                  // Facilities Grid
                  ...facilities.map((facility) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: GlassCard(
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                gradient: AppTheme.lightGradient,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Icon(
                                facility['icon'] as IconData,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    facility['title'] as String,
                                    style: AppTheme.headingSmall.copyWith(
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    facility['description'] as String,
                                    style: AppTheme.bodyMedium.copyWith(
                                      color: AppTheme.darkGray,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _isHospitalOpen() {
    final now = DateTime.now();
    final currentHour = now.hour;
    return currentHour >= 9 && currentHour < 22; // 9 AM to 10 PM
  }
}
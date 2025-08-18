import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/app_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/animated_button.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      {
        'title': 'Outpatient Consultation',
        'icon': Icons.medical_services,
        'description': 'General health checkups and consultations',
      },
      {
        'title': 'Child Care',
        'icon': Icons.child_care,
        'description': 'Specialized pediatric care and treatment',
      },
      {
        'title': 'Pharmacy Support',
        'icon': Icons.local_pharmacy,
        'description': 'On-site pharmacy with essential medicines',
      },
      {
        'title': 'FemSupport',
        'icon': Icons.pregnant_woman,
        'description': 'Women\'s health and maternity care',
      },
      {
        'title': 'Vaccination',
        'icon': Icons.vaccines,
        'description': 'Immunization services for all ages',
      },
      {
        'title': 'Emergency Care 24/7',
        'icon': Icons.emergency,
        'description': 'Round-the-clock emergency medical services',
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            child: AnimationLimiter(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final service = services[index];
                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: const Duration(milliseconds: 600),
                    columnCount: 2,
                    child: ScaleAnimation(
                      child: FadeInAnimation(
                        child: GlassCard(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  gradient: index % 2 == 0
                                      ? AppTheme.primaryGradient
                                      : AppTheme.lightGradient,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Icon(
                                  service['icon'] as IconData,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                service['title'] as String,
                                style: AppTheme.headingSmall.copyWith(
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                service['description'] as String,
                                style: AppTheme.bodySmall.copyWith(
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          AnimationConfiguration.synchronized(
            duration: const Duration(milliseconds: 800),
            child: SlideAnimation(
              verticalOffset: 50,
              child: FadeInAnimation(
                child: AnimatedButton(
                  text: 'Request More Info',
                  onPressed: () async {
                    final Uri whatsappUri = Uri.parse(
                      'https://wa.me/917860120688?text=Hi, I would like to know more about your services at Samad Nursing Home.',
                    );
                    if (await canLaunchUrl(whatsappUri)) {
                      await launchUrl(whatsappUri);
                    }
                  },
                  width: double.infinity,
                  icon: Icons.info_outline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
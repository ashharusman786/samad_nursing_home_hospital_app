import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../utils/app_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/animated_button.dart';
import 'book_appointment_screen.dart';
import 'hospital_info_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: AnimationLimiter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 600),
            childAnimationBuilder: (widget) => SlideAnimation(
              verticalOffset: 50,
              child: FadeInAnimation(child: widget),
            ),
            children: [
              // Welcome Section
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: AppTheme.primaryGradient,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            Icons.waving_hand,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Good Morning!',
                                style: AppTheme.headingMedium,
                              ),
                              Text(
                                'How can we help you today?',
                                style: AppTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Quick Actions
              Text(
                'Quick Actions',
                style: AppTheme.headingMedium,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: GlassCard(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const BookAppointmentScreen(),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              gradient: AppTheme.primaryGradient,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Book\nAppointment',
                            style: AppTheme.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GlassCard(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const HospitalInfoScreen(),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              gradient: AppTheme.lightGradient,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.info_outline,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Hospital\nInfo',
                            style: AppTheme.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Emergency Contact
              GlassCard(
                child: Row(
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
                            '24/7 Available: +91 7860120688',
                            style: AppTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // Launch phone dialer
                      },
                      icon: const Icon(
                        Icons.phone,
                        color: AppTheme.error,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Hospital Status
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                            color: AppTheme.success,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Hospital is Open',
                          style: AppTheme.headingSmall.copyWith(
                            color: AppTheme.success,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Timings: 9:00 AM - 10:00 PM',
                      style: AppTheme.bodyMedium,
                    ),
                    Text(
                      'Emergency services available 24/7',
                      style: AppTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
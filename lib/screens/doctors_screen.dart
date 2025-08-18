import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../utils/app_theme.dart';
import '../widgets/glass_card.dart';

class DoctorsScreen extends StatelessWidget {
  const DoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final doctors = [
      {
        'name': 'Dr. Zeeshan Ahmad',
        'specialty': 'General Physician & Child Specialist',
        'morningTime': '9:00 AM - 3:00 PM',
        'eveningTime': '5:00 PM - 10:00 PM',
        'email': 'zeeshanshaikh5045@gmail.com',
        'phone': '+91 7860120688',
        'isAvailable': _isDoctorAvailable(),
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: AnimationLimiter(
        child: ListView.builder(
          itemCount: doctors.length,
          itemBuilder: (context, index) {
            final doctor = doctors[index];
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 600),
              child: SlideAnimation(
                verticalOffset: 50,
                child: FadeInAnimation(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: GlassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              // Doctor Avatar
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  gradient: AppTheme.primaryGradient,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      doctor['name'] as String,
                                      style: AppTheme.headingSmall,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      doctor['specialty'] as String,
                                      style: AppTheme.bodyMedium.copyWith(
                                        color: AppTheme.darkGray,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: doctor['isAvailable'] as bool
                                            ? AppTheme.success
                                            : AppTheme.error,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        doctor['isAvailable'] as bool
                                            ? 'Available'
                                            : 'Not Available',
                                        style: AppTheme.bodySmall.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          
                          // Timings
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Timings',
                                  style: AppTheme.headingSmall.copyWith(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.wb_sunny,
                                      color: AppTheme.warning,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Morning: ${doctor['morningTime']}',
                                      style: AppTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.nights_stay,
                                      color: AppTheme.primaryBlue,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Evening: ${doctor['eveningTime']}',
                                      style: AppTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          
                          // Contact Information
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.email_outlined,
                                        color: AppTheme.primaryBlue,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          doctor['email'] as String,
                                          style: AppTheme.bodySmall,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  gradient: AppTheme.primaryGradient,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.phone,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Call',
                                      style: AppTheme.bodyMedium.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  bool _isDoctorAvailable() {
    final now = DateTime.now();
    final currentHour = now.hour;
    
    // Morning: 9 AM - 3 PM (9-15)
    // Evening: 5 PM - 10 PM (17-22)
    return (currentHour >= 9 && currentHour < 15) || 
           (currentHour >= 17 && currentHour < 22);
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../providers/user_provider.dart';
import '../utils/app_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/animated_button.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: AnimationLimiter(
            child: Column(
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 600),
                childAnimationBuilder: (widget) => SlideAnimation(
                  verticalOffset: 50,
                  child: FadeInAnimation(child: widget),
                ),
                children: [
                  // Profile Header
                  GlassCard(
                    child: Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            gradient: AppTheme.primaryGradient,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          userProvider.name.isEmpty 
                              ? 'User Name' 
                              : userProvider.name,
                          style: AppTheme.headingMedium,
                        ),
                        Text(
                          userProvider.email.isEmpty 
                              ? 'user@example.com' 
                              : userProvider.email,
                          style: AppTheme.bodyMedium.copyWith(
                            color: AppTheme.darkGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Profile Information
                  Expanded(
                    child: GlassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Profile Information',
                            style: AppTheme.headingSmall,
                          ),
                          const SizedBox(height: 20),
                          
                          _buildInfoRow(
                            'Name',
                            userProvider.name.isEmpty ? 'Not set' : userProvider.name,
                            Icons.person_outline,
                          ),
                          _buildInfoRow(
                            'Age',
                            userProvider.age == 0 ? 'Not set' : '${userProvider.age} years',
                            Icons.cake_outlined,
                          ),
                          _buildInfoRow(
                            'Gender',
                            userProvider.gender.isEmpty ? 'Not set' : userProvider.gender,
                            Icons.wc_outlined,
                          ),
                          _buildInfoRow(
                            'Contact',
                            userProvider.contactNumber.isEmpty ? 'Not set' : userProvider.contactNumber,
                            Icons.phone_outlined,
                          ),
                          _buildInfoRow(
                            'Email',
                            userProvider.email.isEmpty ? 'Not set' : userProvider.email,
                            Icons.email_outlined,
                          ),
                          _buildInfoRow(
                            'Medical History',
                            userProvider.medicalHistory.isEmpty ? 'None' : userProvider.medicalHistory,
                            Icons.medical_information_outlined,
                            isLast: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: AnimatedButton(
                          text: 'Edit Profile',
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const EditProfileScreen(),
                              ),
                            );
                          },
                          icon: Icons.edit_outlined,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          height: 56,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppTheme.error,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                _showLogoutDialog(context, userProvider);
                              },
                              borderRadius: BorderRadius.circular(16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.logout,
                                    color: AppTheme.error,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Logout',
                                    style: AppTheme.buttonText.copyWith(
                                      color: AppTheme.error,
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(
    String label,
    String value,
    IconData icon, {
    bool isLast = false,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: AppTheme.primaryBlue,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTheme.bodySmall.copyWith(
                      color: AppTheme.darkGray,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: AppTheme.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (!isLast) ...[
          const SizedBox(height: 16),
          Divider(
            color: AppTheme.darkGray.withOpacity(0.2),
            height: 1,
          ),
          const SizedBox(height: 16),
        ],
      ],
    );
  }

  void _showLogoutDialog(BuildContext context, UserProvider userProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Logout',
          style: AppTheme.headingSmall,
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: AppTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.darkGray,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              await userProvider.signOut();
              if (context.mounted) {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/',
                  (route) => false,
                );
              }
            },
            child: Text(
              'Logout',
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
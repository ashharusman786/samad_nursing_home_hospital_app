import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../providers/user_provider.dart';
import '../utils/app_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/animated_button.dart';
import '../widgets/custom_app_bar.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _contactController = TextEditingController();
  final _emailController = TextEditingController();
  final _medicalHistoryController = TextEditingController();
  
  String _selectedGender = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    _nameController.text = userProvider.name;
    _ageController.text = userProvider.age == 0 ? '' : userProvider.age.toString();
    _selectedGender = userProvider.gender;
    _contactController.text = userProvider.contactNumber;
    _emailController.text = userProvider.email;
    _medicalHistoryController.text = userProvider.medicalHistory;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _contactController.dispose();
    _emailController.dispose();
    _medicalHistoryController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      await userProvider.updateProfile(
        name: _nameController.text.trim(),
        age: int.tryParse(_ageController.text) ?? 0,
        gender: _selectedGender,
        contactNumber: _contactController.text.trim(),
        email: _emailController.text.trim(),
        medicalHistory: _medicalHistoryController.text.trim(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully!'),
            backgroundColor: AppTheme.success,
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to update profile'),
            backgroundColor: AppTheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Edit Profile',
        showBackButton: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: AnimationLimiter(
            child: Form(
              key: _formKey,
              child: ListView(
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 600),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    verticalOffset: 50,
                    child: FadeInAnimation(child: widget),
                  ),
                  children: [
                    // Profile Avatar
                    Center(
                      child: Container(
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
                    ),
                    const SizedBox(height: 30),

                    // Form Fields
                    GlassCard(
                      child: Column(
                        children: [
                          // Name Field
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: 'Full Name',
                              prefixIcon: const Icon(Icons.person_outline),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.8),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Age Field
                          TextFormField(
                            controller: _ageController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Age',
                              prefixIcon: const Icon(Icons.cake_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.8),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your age';
                              }
                              final age = int.tryParse(value);
                              if (age == null || age < 1 || age > 120) {
                                return 'Please enter a valid age';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Gender Selection
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppTheme.primaryBlue.withOpacity(0.3),
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedGender.isEmpty ? null : _selectedGender,
                                hint: const Text('Select Gender'),
                                isExpanded: true,
                                items: ['Male', 'Female', 'Other'].map((gender) {
                                  return DropdownMenuItem(
                                    value: gender,
                                    child: Text(gender),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedGender = value ?? '';
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Contact Field
                          TextFormField(
                            controller: _contactController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: 'Contact Number',
                              prefixIcon: const Icon(Icons.phone_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.8),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your contact number';
                              }
                              if (value.length < 10) {
                                return 'Please enter a valid contact number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Email Field
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: const Icon(Icons.email_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.8),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!value.contains('@')) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Medical History Field
                          TextFormField(
                            controller: _medicalHistoryController,
                            maxLines: 3,
                            decoration: InputDecoration(
                              labelText: 'Medical History (Optional)',
                              prefixIcon: const Icon(Icons.medical_information_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Save Button
                    AnimatedButton(
                      text: 'Save Profile',
                      onPressed: _saveProfile,
                      isLoading: _isLoading,
                      width: double.infinity,
                      icon: Icons.save_outlined,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
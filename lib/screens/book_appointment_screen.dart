import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import '../utils/app_theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/animated_button.dart';
import '../widgets/custom_app_bar.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({super.key});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  String? selectedDoctor;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  bool isLoading = false;

  final List<String> doctors = [
    'Dr. Zeeshan Ahmad - General Physician & Child Specialist',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Book Appointment',
        showBackButton: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: Padding(
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
                  // Doctor Selection
                  GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select Doctor',
                          style: AppTheme.headingSmall,
                        ),
                        const SizedBox(height: 12),
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
                              value: selectedDoctor,
                              hint: Text(
                                'Choose a doctor',
                                style: AppTheme.bodyMedium.copyWith(
                                  color: AppTheme.darkGray,
                                ),
                              ),
                              isExpanded: true,
                              items: doctors.map((doctor) {
                                return DropdownMenuItem(
                                  value: doctor,
                                  child: Text(
                                    doctor,
                                    style: AppTheme.bodyMedium,
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedDoctor = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Date Selection
                  GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select Date',
                          style: AppTheme.headingSmall,
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                const Duration(days: 30),
                              ),
                            );
                            if (date != null) {
                              setState(() {
                                selectedDate = date;
                              });
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppTheme.primaryBlue.withOpacity(0.3),
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                  color: AppTheme.primaryBlue,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  selectedDate != null
                                      ? DateFormat('dd MMM yyyy').format(selectedDate!)
                                      : 'Choose date',
                                  style: AppTheme.bodyMedium.copyWith(
                                    color: selectedDate != null
                                        ? AppTheme.primaryBlue
                                        : AppTheme.darkGray,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Time Selection
                  GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select Time',
                          style: AppTheme.headingSmall,
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () async {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (time != null) {
                              setState(() {
                                selectedTime = time;
                              });
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppTheme.primaryBlue.withOpacity(0.3),
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  color: AppTheme.primaryBlue,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  selectedTime != null
                                      ? selectedTime!.format(context)
                                      : 'Choose time',
                                  style: AppTheme.bodyMedium.copyWith(
                                    color: selectedTime != null
                                        ? AppTheme.primaryBlue
                                        : AppTheme.darkGray,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),

                  // Book Appointment Button
                  AnimatedButton(
                    text: 'Book Appointment',
                    onPressed: _canBookAppointment() ? _bookAppointment : () {},
                    isLoading: isLoading,
                    width: double.infinity,
                    icon: Icons.check_circle_outline,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _canBookAppointment() {
    return selectedDoctor != null && selectedDate != null && selectedTime != null;
  }

  Future<void> _bookAppointment() async {
    if (!_canBookAppointment()) return;

    setState(() {
      isLoading = true;
    });

    try {
      final message = '''
Hello Dr. Zeeshan Ahmad,

A new appointment has been booked:

📅 Date: ${DateFormat('dd MMM yyyy').format(selectedDate!)}
⏰ Time: ${selectedTime!.format(context)}
👨‍⚕️ Doctor: $selectedDoctor

Patient will visit as scheduled.

Thank you!
Samad Nursing Home App
      ''';

      try {
        final Uri whatsappUri = Uri.parse(
          'https://wa.me/917860120688?text=${Uri.encodeComponent(message)}',
        );

        if (await canLaunchUrl(whatsappUri)) {
          await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
          
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Appointment request sent successfully!'),
                backgroundColor: AppTheme.success,
              ),
            );
            Navigator.of(context).pop();
          }
        } else {
          throw 'Could not launch WhatsApp';
        }
      } catch (e) {
        // Fallback to SMS if WhatsApp is not available
        try {
          final Uri smsUri = Uri.parse('sms:+917860120688?body=${Uri.encodeComponent(message)}');
          if (await canLaunchUrl(smsUri)) {
            await launchUrl(smsUri);
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Opening SMS app for appointment request'),
                  backgroundColor: AppTheme.success,
                ),
              );
              Navigator.of(context).pop();
            }
          } else {
            throw 'Could not launch messaging app';
          }
        } catch (smsError) {
          throw 'Could not send appointment request';
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to send appointment request'),
            backgroundColor: AppTheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
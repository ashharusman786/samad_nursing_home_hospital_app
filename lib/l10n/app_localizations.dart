import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  // Landing Page
  String get welcomeTitle => locale.languageCode == 'hi' 
      ? 'समद नर्सिंग होम में आपका स्वागत है'
      : 'Welcome to Samad Nursing Home';

  String get welcomeSubtitle => locale.languageCode == 'hi'
      ? 'आपका स्वास्थ्य, हमारी प्राथमिकता — आपकी उंगलियों पर दयालु देखभाल।'
      : 'Your health, our priority — Compassionate care at your fingertips.';

  String get getStarted => locale.languageCode == 'hi' ? 'शुरू करें' : 'Get Started';

  // Navigation
  String get home => locale.languageCode == 'hi' ? 'होम' : 'Home';
  String get doctors => locale.languageCode == 'hi' ? 'डॉक्टर' : 'Doctors';
  String get services => locale.languageCode == 'hi' ? 'सेवाएं' : 'Services';
  String get profile => locale.languageCode == 'hi' ? 'प्रोफाइल' : 'Profile';

  // Doctors
  String get ourDoctors => locale.languageCode == 'hi' ? 'हमारे डॉक्टर' : 'Our Doctors';
  String get available => locale.languageCode == 'hi' ? 'उपलब्ध' : 'Available';
  String get notAvailable => locale.languageCode == 'hi' ? 'अनुपलब्ध' : 'Not Available';

  // Services
  String get ourServices => locale.languageCode == 'hi' ? 'हमारी सेवाएं' : 'Our Services';
  String get requestMoreInfo => locale.languageCode == 'hi' ? 'अधिक जानकारी का अनुरोध करें' : 'Request More Info';

  // Appointment
  String get bookAppointment => locale.languageCode == 'hi' ? 'अपॉइंटमेंट बुक करें' : 'Book Appointment';
  String get selectDoctor => locale.languageCode == 'hi' ? 'डॉक्टर चुनें' : 'Select Doctor';
  String get selectDate => locale.languageCode == 'hi' ? 'तारीख चुनें' : 'Select Date';
  String get selectTime => locale.languageCode == 'hi' ? 'समय चुनें' : 'Select Time';

  // Profile
  String get myProfile => locale.languageCode == 'hi' ? 'मेरी प्रोफाइल' : 'My Profile';
  String get editProfile => locale.languageCode == 'hi' ? 'प्रोफाइल संपादित करें' : 'Edit Profile';
  String get name => locale.languageCode == 'hi' ? 'नाम' : 'Name';
  String get age => locale.languageCode == 'hi' ? 'उम्र' : 'Age';
  String get gender => locale.languageCode == 'hi' ? 'लिंग' : 'Gender';
  String get contactNumber => locale.languageCode == 'hi' ? 'संपर्क नंबर' : 'Contact Number';
  String get email => locale.languageCode == 'hi' ? 'ईमेल' : 'Email';
  String get medicalHistory => locale.languageCode == 'hi' ? 'चिकित्सा इतिहास' : 'Medical History';

  // Hospital Info
  String get hospitalInfo => locale.languageCode == 'hi' ? 'अस्पताल की जानकारी' : 'Hospital Info';
  String get hospitalTimings => locale.languageCode == 'hi' ? 'अस्पताल का समय' : 'Hospital Timings';
  String get emergencyContact => locale.languageCode == 'hi' ? 'आपातकालीन संपर्क' : 'Emergency Contact';
  String get facilities => locale.languageCode == 'hi' ? 'सुविधाएं' : 'Facilities';
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'hi'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  String _name = '';
  int _age = 0;
  String _gender = '';
  String _contactNumber = '';
  String _email = '';
  String _medicalHistory = '';

  String get name => _name;
  int get age => _age;
  String get gender => _gender;
  String get contactNumber => _contactNumber;
  String get email => _email;
  String get medicalHistory => _medicalHistory;

  bool get isLoggedIn => _name.isNotEmpty;

  UserProvider() {
    _loadUserData();
  }

  void _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _name = prefs.getString('user_name') ?? '';
    _age = prefs.getInt('user_age') ?? 0;
    _gender = prefs.getString('user_gender') ?? '';
    _contactNumber = prefs.getString('user_contact') ?? '';
    _email = prefs.getString('user_email') ?? '';
    _medicalHistory = prefs.getString('user_medical_history') ?? '';
    notifyListeners();
  }

  Future<void> updateProfile({
    required String name,
    required int age,
    required String gender,
    required String contactNumber,
    required String email,
    required String medicalHistory,
  }) async {
    _name = name;
    _age = age;
    _gender = gender;
    _contactNumber = contactNumber;
    _email = email;
    _medicalHistory = medicalHistory;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', name);
    await prefs.setInt('user_age', age);
    await prefs.setString('user_gender', gender);
    await prefs.setString('user_contact', contactNumber);
    await prefs.setString('user_email', email);
    await prefs.setString('user_medical_history', medicalHistory);

    notifyListeners();
  }

  Future<void> signOut() async {
    notifyListeners();
  }
}
import 'dart:async';

import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  static const String _adminEmail = 'admin@hitungan.com';
  static const String _adminPassword = 'admin123';

  bool _isInitialized = false;
  bool _isLoading = true;
  bool _isAuthenticating = false;
  bool _isAuthenticated = false;
  String? _errorMessage;

  AuthProvider() {
    _initialize();
  }

  bool get isInitialized => _isInitialized;
  bool get isLoading => _isLoading;
  bool get isAuthenticating => _isAuthenticating;
  bool get isAuthenticated => _isAuthenticated;
  String? get errorMessage => _errorMessage;

  Future<void> _initialize() async {
    await Future.delayed(const Duration(seconds: 2));
    _isInitialized = true;
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    if (_isAuthenticating) return false;

    _isAuthenticating = true;
    _errorMessage = null;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 800));

    if (email.trim().toLowerCase() == _adminEmail &&
        password == _adminPassword) {
      _isAuthenticated = true;
    } else {
      _errorMessage = 'Email atau kata sandi salah.';
    }

    _isAuthenticating = false;
    notifyListeners();
    return _isAuthenticated;
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }
}


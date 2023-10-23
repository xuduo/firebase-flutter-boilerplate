// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import '../util/logger.dart';

class UserProvider extends ChangeNotifier {

  final Logger _logger = Logger(UserProvider);

  bool _loggedIn = false;

  bool get loggedIn => _loggedIn;

  bool _emailVerified = false;

  bool get emailVerified => _emailVerified;

  User? _user;

  User? get user => _user;

  UserProvider() {
    _logger.info('init');
    init();
  }

  void init() {

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);

    FirebaseAuth.instance.userChanges().listen((user) {
      _logger.info('userChanges $user');
      _user = user;
      if (user != null) {
        _loggedIn = true;
        _emailVerified = user.emailVerified;
      } else {
        _loggedIn = false;
        _emailVerified = false;
      }
      notifyListeners();
    });
  }

  Future<void> refreshLoggedInUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return;
    }

    await currentUser.reload();
  }
}

// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:flutter/material.dart';
import '../model/guest_book_message.dart';
import '../util/analytics.dart';
import '../util/logger.dart';
import 'auth_provider.dart';

class GuestBookProvider extends ChangeNotifier {
  final Logger _logger = Logger(GuestBookProvider);

  StreamSubscription<QuerySnapshot>? _guestBookSubscription;
  List<GuestBookMessage> _guestBookMessages = [];

  List<GuestBookMessage> get guestBookMessages => _guestBookMessages;

  final UserProvider _userProvider;
  VoidCallback? _userListener;

  GuestBookProvider(this._userProvider) {
    _logger.info('init');
    _userListener = () {
      _logger.info('user changes ${_userProvider.user?.uid}');
      query();
    };
    _userProvider.addListener(_userListener!);
    query();
  }

  @override
  void dispose(){
    super.dispose();
    _logger.info('dispose');
    _guestBookSubscription?.cancel();
    _userProvider.removeListener(_userListener!);
  }

  Future<DocumentReference> addMessageToGuestBook(String message) {
    if (!_userProvider.loggedIn) {
      _logger.error('must be logged in ${_userProvider.user}');
      throw Exception('Must be logged in');
    }

    Analytics.instance.report('addMessageToGuestBook', {
      'text': message,
      'name': FirebaseAuth.instance.currentUser!.displayName,
      'userId': FirebaseAuth.instance.currentUser!.uid
    });

    return FirebaseFirestore.instance
        .collection('guestbook')
        .add(<String, dynamic>{
      'text': message,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'name': FirebaseAuth.instance.currentUser!.displayName,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
  }

  void query() {
    if (_userProvider.user != null) {
      _logger.info('query guestbook');
      _guestBookSubscription = FirebaseFirestore.instance
          .collection('guestbook')
          .orderBy('timestamp', descending: false)
          .snapshots()
          .listen((snapshot) {
        _guestBookMessages = [];
        for (final document in snapshot.docs) {
          _guestBookMessages.add(
            GuestBookMessage(
              name: document.data()['name'] as String,
              message: document.data()['text'] as String,
            ),
          );
        }
        notifyListeners();
        _logger.info('update guestbook ${_guestBookMessages.length}');
      });
    } else {
      _guestBookMessages = [];
      _guestBookSubscription?.cancel();
      notifyListeners();
    }
  }
}

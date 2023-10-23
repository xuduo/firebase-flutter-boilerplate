// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:flutter/material.dart';

import '../util/logger.dart';
import 'auth_provider.dart';

enum Attending { yes, no, unknown }

class AttendeesProvider extends ChangeNotifier {
  // final BuildContext context;
  final UserProvider _userProvider;
  AttendeesProvider(this._userProvider) {
    _logger.info('ApplicationState init');
    init();
  }

  final Logger _logger = Logger(AttendeesProvider);

  int _attendees = 0;

  int get attendees => _attendees;

  static Map<String, dynamic> defaultValues = <String, dynamic>{
    'event_date': 'October 18, 2022',
    'enable_free_swag': false,
    'call_to_action': 'Join us for a day full of Firebase Workshops and Pizza!',
  };

  // ignore: prefer_final_fields
  String _eventDate = defaultValues['event_date'] as String;

  String get eventDate => _eventDate;

  // ignore: prefer_final_fields
  String _callToAction = defaultValues['call_to_action'] as String;

  String get callToAction => _callToAction;

  Attending _attending = Attending.unknown;
  StreamSubscription<DocumentSnapshot>? _attendingSubscription;

  Attending get attending => _attending;

  set attending(Attending attending) {
    final userDoc = FirebaseFirestore.instance
        .collection('attendees')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    if (attending == Attending.yes) {
      userDoc.set(<String, dynamic>{'attending': true});
    } else {
      userDoc.set(<String, dynamic>{'attending': false});
    }
  }

  void init() {
    FirebaseFirestore.instance
        .collection('attendees')
        .where('attending', isEqualTo: true)
        .snapshots()
        .listen((snapshot) {
      _attendees = snapshot.docs.length;
      notifyListeners();
    });
    _userProvider.addListener(() {
      _logger.info('user changes ${_userProvider.user?.uid}');
      if (_userProvider.user != null) {
        _attendingSubscription = FirebaseFirestore.instance
            .collection('attendees')
            .doc(_userProvider.user!.uid)
            .snapshots()
            .listen((snapshot) {
          if (snapshot.data() != null) {
            if (snapshot.data()!['attending'] as bool) {
              _attending = Attending.yes;
            } else {
              _attending = Attending.no;
            }
          } else {
            _attending = Attending.unknown;
          }
          notifyListeners();
        });
      } else {
        _attendingSubscription?.cancel();
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

// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:model/providers/app_state.dart';
import 'package:model/providers/auth_provider.dart';
import 'package:model/util/provider.dart';
import 'package:provider/provider.dart';

import '../widgets/authentication.dart';
import '../widgets/widgets.dart';
import '../widgets/yes_no_selection.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Meetup'),
      ),
      body: ListView(
        children: <Widget>[
          Image.asset('assets/codelab.png'),
          const SizedBox(height: 8),
          Consumer<AttendeesProvider>(
            builder: (context, appState, _) =>
                IconAndDetail(Icons.calendar_today, appState.eventDate),
          ),
          const IconAndDetail(Icons.location_city, 'San Francisco'),
          Consumer<UserProvider>(
            builder: (context, appState, _) => AuthFunc(
              loggedIn: appState.loggedIn,
              signOut: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ),
          const Divider(
            height: 8,
            thickness: 1,
            indent: 8,
            endIndent: 8,
            color: Colors.grey,
          ),
          const Header("What we'll be doing"),
          Consumer<AttendeesProvider>(
            builder: (context, appState, _) => Paragraph(
              appState.callToAction,
            ),
          ),
          Consumer<AttendeesProvider>(
            builder: (context, appState, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                switch (appState.attendees) {
                  1 => const Paragraph('1 person going'),
                  >= 2 => Paragraph('${appState.attendees} people going'),
                  _ => const Paragraph('No one going'),
                },
                if (provider<UserProvider>(context).loggedIn) ...[
                  YesNoSelection(
                    state: appState.attending,
                    onSelection: (attending) => appState.attending = attending,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, bottom: 8),
                    child: StyledButton(
                        onPressed: () {
                          context.push('/guestBook');
                        }, child: const Text('GuestBook'),)
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

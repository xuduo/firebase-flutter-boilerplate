import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:model/providers/auth_provider.dart';
import 'package:model/providers/guest_book_provider.dart';
import 'package:model/util/provider.dart';
import 'package:provider/provider.dart';

import '../widgets/guest_book.dart';

class GuestBookScaffold extends StatelessWidget {
  const GuestBookScaffold({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GuestBookProvider(provider<UserProvider>(context)),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('GuestBook'),
          ),
          body: SafeArea(child: GuestBook())),
    );
  }
}

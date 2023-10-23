import 'package:flutter/material.dart';
import 'package:model/model/guest_book_message.dart';
import 'package:model/providers/guest_book_provider.dart';
import 'package:provider/provider.dart';

class GuestBookListView extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  GuestBookListView({super.key});

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 1),
      curve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GuestBookProvider>(
      builder: (context, provider, child) {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          _scrollToBottom();
        });
        return ListView.builder(
          controller: _scrollController,
          itemCount: provider.guestBookMessages.length,
          itemBuilder: (context, index) {
            GuestBookMessage message = provider.guestBookMessages[index];
            return Container(
              padding: const EdgeInsets.all(8.0),
              child: Text('${message.name}: ${message.message}',style: const TextStyle(fontSize: 18)),
            );
          },
        );
      },
    );
  }
}

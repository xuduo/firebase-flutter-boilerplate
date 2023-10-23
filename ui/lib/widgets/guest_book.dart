import 'package:flutter/material.dart';
import 'package:model/providers/guest_book_provider.dart';
import 'package:model/util/logger.dart';
import 'package:model/util/provider.dart';
import 'package:ui/widgets/widgets.dart';

import 'guest_book_list_view.dart';


class GuestBook extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  final _logger = Logger('GuestBookStateless');

  GuestBook({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: GuestBookListView(),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Leave a message',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your message to continue';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 8),
                StyledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _logger.info('addMessage ${_controller.text}');
                      provider<GuestBookProvider>(context)
                          .addMessageToGuestBook(_controller.text);
                      _formKey.currentState!.reset();
                      FocusScope.of(context).unfocus();
                    }
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.send),
                      SizedBox(width: 4),
                      Text('SEND'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

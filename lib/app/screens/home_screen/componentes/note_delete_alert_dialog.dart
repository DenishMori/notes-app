import 'package:flutter/material.dart';
import 'package:notes_app/app/screens/home_screen/componentes/action_button.dart';
import 'package:notes_app/utils/app_color.dart';

Future<bool> showDeleteNoteDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Delete'),
        content: const Text(
          'Do you really want to delete the note?',
          style: TextStyle(
            color: AppColors.darkGray,
          ),
        ),
        actions: [
          actionButton(
            context,
            text: 'No',
            onTap: () => Navigator.pop(context, false),
          ),
          actionButton(
            context,
            text: 'Yes',
            onTap: () => Navigator.pop(context, true),
          ),
        ],
      );
    },
  );
}

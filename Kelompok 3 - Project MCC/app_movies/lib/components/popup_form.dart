import 'package:app_movies/models/tapes.dart';
import 'package:app_movies/shared/theme.dart';
import 'package:flutter/material.dart';

class PopupForm {
  static void show(BuildContext context, String action, [Tape? tape]) {
    final TextEditingController titleController =
        TextEditingController(text: tape?.tapeTitle ?? '');
    final TextEditingController descriptionController =
        TextEditingController(text: tape?.description ?? '');
    final TextEditingController priceController =
        TextEditingController(text: tape?.tapePrice ?? '');
    final TextEditingController imageController =
        TextEditingController(text: tape?.tapeImage ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('$action Item'),
          backgroundColor: filled,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (action != 'Delete') ...[
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: imageController,
                  decoration: const InputDecoration(
                    labelText: 'Image Path',
                    border: OutlineInputBorder(),
                  ),
                ),
              ] else
                Text(
                  'Are you sure you want to delete "${tape?.tapeTitle}"?',
                  style: const TextStyle(color: Colors.red),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                if (action == 'Edit') {
                  print(
                      'Edit: ${titleController.text}, ${titleController.text}, ${imageController.text}');
                } else if (action == 'Delete') {
                  print('Deleted: ${tape?.tapeTitle}');
                }
                Navigator.of(context).pop();
              },
              child: Text(
                action,
                style: TextStyle(
                    color: action == 'Edit' ? Colors.blue : Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }
}

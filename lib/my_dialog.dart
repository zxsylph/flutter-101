import 'package:flutter/material.dart';

class MyDialog {
  final BuildContext context;
  MyDialog({
    required this.context,
  });

  Future<void> normalDialog(
      {required String title, required String body}) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: const Icon(Icons.face),
          title: Text(title),
          subtitle: Text(body),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showLoadingMessage(BuildContext context) {
  // Android
  if (Platform.isAndroid) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Espere por favor'),
        content: SizedBox(
          width: 100,
          height: 100,
          child: Column(
            children: const [
              CircularProgressIndicator(
                strokeWidth: 3,
                color: Colors.black,
              ),
              Text('Calculando ruta'),
            ],
          ),
        ),
      ),
    );
    return;
  }
  showCupertinoDialog(
    context: context,
    builder: (context) => const CupertinoAlertDialog(
      title: Text('Espere por favor'),
      content: CupertinoActivityIndicator(),
    ),
  );
}

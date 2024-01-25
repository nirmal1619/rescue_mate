
import 'package:flutter/material.dart';

class SnackbarClass{
  static showCustomSnackBar(BuildContext context, String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14)
        ),
        dismissDirection: DismissDirection.startToEnd,
        content: Text(
          content,
          style: const TextStyle(fontSize: 18.0,color: Colors.black), // Adjust text size as needed
        ),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0), // Margin from the bottom
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme.dart';

Widget buildTextInput(String hint, IconData icon, TextEditingController controller, {bool isPassword = false}) {
  return Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: DefaultColors.sentMessageInput,
      borderRadius: BorderRadius.circular(25),
    ),
    child: Row(
      children: [
        Icon(
          icon,
          color: Colors.grey,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: controller,
            obscureText: isPassword,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}

Widget buildActionButton(String label, VoidCallback onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: DefaultColors.buttonColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.symmetric(vertical: 15),
    ),
    child: Text(
      label,
      style: const TextStyle(color: Colors.white),
    ),
  );
}

Widget buildLoginPrompt(String promptText, String actionText, VoidCallback onTap) {
  return Center(
    child: GestureDetector(
      onTap: onTap,
      child: RichText(
        text: TextSpan(
          text: promptText,
          style: const TextStyle(color: Colors.grey),
          children: [
            TextSpan(
              text: actionText,
              style: const TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
    ),
  );
}
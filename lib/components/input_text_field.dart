import "package:flutter/material.dart";

class InputTextField extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String placeHolder;
  // ignore: prefer_typing_uninitialized_variables
  final obscureText;
  final Icon? prefixIcon;
  final Function(String)? onChanged;
  const InputTextField(
      {super.key,
      this.controller,
      required this.placeHolder,
      required this.obscureText,
      this.prefixIcon,
      this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            hintText: placeHolder,
            hintStyle: TextStyle(
              color: Colors.grey.shade600,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade500),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            prefixIcon: prefixIcon),
      ),
    );
  }
}

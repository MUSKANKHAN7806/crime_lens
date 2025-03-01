import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final String labelText;
  final bool isTextArea;
  final TextEditingController controller;
  const FormTextField(
      {super.key,
      required this.labelText,
      this.isTextArea = false,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: controller,
        maxLines: isTextArea ? 5 : null,
        minLines: isTextArea ? 5 : null,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          label: Text(labelText),
        ),
      ),
    );
  }
}

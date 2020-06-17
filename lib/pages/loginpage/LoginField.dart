import 'package:flutter/material.dart';

class LoginField extends StatelessWidget {
  final String labelText;
  final bool isPasswordField;
  final Function(String) validator; // = (value) => value.isEmpty ? '' : null;
  final Function(String) onSaved;
  final Function() onTap;
  final Function() onEditingComplete;
  final TextEditingController controller = TextEditingController();
  final bool useDefaultLabelColor;

  LoginField(this.labelText,
      {this.isPasswordField = false,
      this.validator,
      this.onSaved,
      this.onTap,
      this.onEditingComplete,
      this.useDefaultLabelColor = true});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPasswordField,
      // cursorColor: Colors.grey,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(0.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        labelText: labelText,
        labelStyle:
            useDefaultLabelColor ? TextStyle() : TextStyle(color: Colors.grey),
      ),
      style: TextStyle(
        fontWeight: FontWeight.w300,
      ),
      validator: validator,
      onSaved: onSaved,
      onTap: onTap,
      onEditingComplete: onEditingComplete,
    );
  }
}

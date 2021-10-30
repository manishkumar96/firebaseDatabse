import 'package:flutter/material.dart';

class TextFieldScreen extends StatelessWidget {
  final String? text;

  final bool? obscure;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChangedValue;
  final TextEditingController? textEditingController;
  final errorText, hintText;
  final FormFieldValidator? validator;

  const TextFieldScreen({
    Key? key,
    this.text,
    this.textInputAction,
    this.obscure,
    this.onChangedValue,
    this.textEditingController,
    this.errorText,
    this.hintText,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: false,
      textInputAction: textInputAction,
      onChanged: onChangedValue,
      controller: textEditingController,
      validator: validator,
      decoration: InputDecoration(
          border: InputBorder.none, labelText: text, errorText: errorText),
    );
  }
}

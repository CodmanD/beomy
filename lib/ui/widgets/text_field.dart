
import 'package:beomy_login/ui/style/colors.dart';
import 'package:beomy_login/ui/validators/validators.dart';
import 'package:flutter/material.dart';

class TextFieldApp extends StatefulWidget {
  const TextFieldApp({
    required this.controller,
    this.onChanged,
    this.hintText = '',
    this.focusNode,
    this.inputType,
    this.validators = const [],
    this.onEditingComplete,
    this.obscure = false,
    this.suffix,
    this.prefix,
    this.isError = false,
    super.key,
  });

  final bool isError;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputType? inputType;
  final List<Validator> validators;
  final String hintText;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final Widget? suffix;
  final bool obscure;
  final Widget? prefix;

  @override
  State<TextFieldApp> createState() => _TextFieldAppState();
}

class _TextFieldAppState extends State<TextFieldApp> {
  int findMaxLength(List<Validator> validators) {
    for (final validator in validators) {
      if (validator is StringRangeValidator) {
        return validator.maxLength;
      }
    }
    return -1;
  }

  @override
  Widget build(BuildContext context) {
    final maxLength = findMaxLength(widget.validators);

    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
      autofocus: true,
      maxLength: maxLength,

      enableSuggestions: false,
      obscureText: widget.obscure,
      obscuringCharacter: '*',
      onEditingComplete: widget.onEditingComplete,
      validator: (value) {
        for (final validator in widget.validators) {
          if (validator is DoubleRangeValidator) {
            if (!validator.checkValid(double.parse(value ?? ''))) {
              return validator.error.message;
            } else {
              return null;
            }
          }
          if (!validator.checkValid(value)) {
            return validator.error.message;
          }
        }
        return null;
      },
      keyboardType: widget.inputType,
      cursorColor: Colors.orange,
      decoration: InputDecoration(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        fillColor: Colors.white70,
        //:ColorsApp.red.withOpacity(0.3),
        contentPadding:
        const EdgeInsets.symmetric(vertical: 17, horizontal: 16),
        suffixIcon: widget.suffix,
        //prefix: prefix,
        prefixIcon: widget.prefix,
        prefixIconConstraints: BoxConstraints(maxWidth: 80, maxHeight: 60),
        prefixStyle: TextStyle(color: ColorsApp.secondary),

        //prefixIconConstraints: const BoxConstraints(maxHeight: 20),
        counter: null,
        counterText: '',
        //error: Container(width: 100.w,height: 2.h,color: Colors.yellow,),
        suffixIconConstraints: const BoxConstraints(maxHeight: 20),
        //error: Container(color: ColorsApp.red,),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: const BorderSide(
            width: 2,
            color: ColorsApp.accentRed,
          ),
        ),
        isDense: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.orange,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide(
//strokeAlign: BorderSide.outAlignCenter,
            width: 2,
            color: ColorsApp.accentRed.withOpacity(0.5),
          ),
        ),
        errorStyle: TextStyle(color: ColorsApp.accentRed),
        hintStyle: TextStyle(color: ColorsApp.secondary),
        errorMaxLines: 3,
        hintText: widget.hintText,
        alignLabelWithHint: true,
        enabled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: const BorderSide(
            width: 2,
            color: Color.fromRGBO(243, 234, 255, 0.75),
          ),
        ),
      ),
    );
  }
}

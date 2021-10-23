import 'package:flutter/services.dart';

class CustomTextInputFormatter extends TextInputFormatter {
  CustomTextInputFormatter({this.maximumLimit = 0});

  final int maximumLimit;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if (maximumLimit != 0) {
      if (newValue.text.length <= maximumLimit) {
        return newValue;
      } else {
        truncated = oldValue.text;
        newSelection = oldValue.selection;

        return TextEditingValue(
          text: truncated,
          selection: newSelection,
          composing: TextRange.empty,
        );
      }
    }
    return newValue;
  }
}

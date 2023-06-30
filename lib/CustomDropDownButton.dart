import 'package:ble_template_flutter/theme/AppTheme.dart';
import 'package:ble_template_flutter/validator/FormValidation.dart';
import 'package:flutter/material.dart';

import 'AppColor.dart';

class CustomDropdownButtonFormField extends StatelessWidget {
  final List<String> options;
  final String? title;
  final String? value;
  final String hint;
  final ValueChanged<String?> onChanged;
  final List<FormValidation>? validators;
  final Function(bool)? onValidate;

  const CustomDropdownButtonFormField({Key? key,
    required this.options,
    required this.onChanged,
    this.hint = "請選擇",
    this.title,
    this.value,
    this.validators,
    this.onValidate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: title != null,
          child: Text(
            title ?? "",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColor.normalTextColor),
          ),
        ),
        Visibility(
          visible: title != null,
          child: SizedBox(
            height: 8,
          ),
        ),
        Theme(
          data: ThemeData(
            inputDecorationTheme: AppTheme.inputThemeData,
            buttonTheme: AppTheme.buttonThemeData,
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            borderRadius: BorderRadius.circular(8),
            items: options.map((value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            // value: value,
            hint: Text(
              hint,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColor.placeholderTextColor),
            ),
            onChanged: onChanged,
            dropdownColor: Colors.white,
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: AppColor.normalTextColor,
            ),
            // iconEnabledColor: Colors.black,
            // iconDisabledColor: Colors.grey,
            isExpanded: true,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColor.normalTextColor),
            validator: (value) {
              if (validators != null) {
                for (var validator in validators!) {
                  bool isValid = validator.validator.validate(value);
                  if (!isValid) {
                    //驗證方法失敗回傳false
                    if (onValidate != null) {
                      onValidate!(false);
                    }
                    return validator.errorString;
                  }
                }
                //所有驗證都結束後回傳true
                if (onValidate != null) {
                  onValidate!(true);
                }
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}

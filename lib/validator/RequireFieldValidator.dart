import 'IValidator.dart';

///欄位必填檢查運算式
class RequireFieldValidator extends IValidator{
  @override
  bool validate(String? value) {
    return (value?.trim().isNotEmpty) ?? false;
  }
}
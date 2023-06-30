import 'IValidator.dart';

///檢查Email格式運算式
class EmailFormatValidator extends IValidator{
  @override
  bool validate(String? value) {
    if(value != null) {
      return RegExp("^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$").hasMatch(value) || (value == "");
    }
    return false;
  }
}
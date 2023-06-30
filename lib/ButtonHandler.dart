import '../AnimationConfig.dart';

class ButtonHandler{
  String? buttonId;

  void handleButtonClick(String buttonId, Function() event) async {
    if (this.buttonId != buttonId) {
      this.buttonId = buttonId;
      await Future.delayed(AnimationConfig.clickAnimateDuration);
      event();
      //延遲一秒，防止按鈕重複點擊
      Future.delayed(const Duration(seconds: 1), () {
        this.buttonId = null;
      });
    }
  }
}
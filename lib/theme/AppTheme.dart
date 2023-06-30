import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../AppColor.dart';

class AppTheme {
  static AppBarTheme appBarThemeData = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    backgroundColor: AppColor.appBarColor,
    systemOverlayStyle: const SystemUiOverlayStyle(
      // Status bar color
      statusBarColor: Colors.transparent,
      // Status bar brightness (optional)
      statusBarIconBrightness: Brightness.light,
      // For Android (light icons)
      statusBarBrightness: Brightness.dark, // For iOS (light icons)
    ),
  );

  static InputDecorationTheme inputThemeData = InputDecorationTheme(
    // border: OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(8),
    //   borderSide: BorderSide(color: AppColor.primaryColor600,width: 2),
    // ),
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.only(top: 12, bottom: 12, right: 12),
    prefixStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    errorStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColor.errorColor,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColor.borderColor, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColor.borderColor, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: AppColor.primaryColor600, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColor.errorColor, width: 2),
    ),
    // focusedErrorBorder: OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(8),
    //   borderSide: BorderSide(color: AppColor.primaryColor600, width: 2),
    // ),
  );

  static RadioThemeData radioThemeData = RadioThemeData(
    visualDensity: const VisualDensity(
      horizontal: VisualDensity.minimumDensity,
      vertical: VisualDensity.minimumDensity,
    ),
    fillColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return AppColor.primaryColor600;
        }
        return AppColor.borderColor; // 默認顏色
      },
    ),
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );

  static TextButtonThemeData textButtonThemeData = TextButtonThemeData(
    style: ButtonStyle(
      splashFactory: InkRipple.splashFactory,
      overlayColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          return AppColor.primaryColor600.withOpacity(0.25); // 默認顏色
        },
      ),
      foregroundColor: MaterialStateProperty.all(Colors.white),
    ),
  );

  static ButtonThemeData buttonThemeData = const ButtonThemeData(
    alignedDropdown: true,
  );

  static TextSelectionThemeData textSelectionThemeData = const TextSelectionThemeData(
    cursorColor: AppColor.primaryColor600,
    selectionHandleColor: AppColor.primaryColor600,
  );

  static CheckboxThemeData checkboxThemeData = CheckboxThemeData(
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    fillColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        return AppColor.primaryColor600;
      },
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(2),
    ),
  );

  static FloatingActionButtonThemeData floatingActionButtonThemeData = FloatingActionButtonThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    backgroundColor: AppColor.secondaryColor300,
  );

  static PopupMenuThemeData popupMenuThemeData = PopupMenuThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  static ExpansionTileThemeData expansionTileThemeData = ExpansionTileThemeData(
    tilePadding: EdgeInsets.all(16),
    collapsedIconColor: Colors.transparent,
    iconColor: Colors.transparent,
  );
}

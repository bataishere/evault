import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:identifyapp/Controllers/Documents/DocumentValidation.dart';
import 'package:identifyapp/Models/Colors.dart';
import 'package:identifyapp/Models/User.dart';
import 'package:identifyapp/Views/Widgets/PopUps/PopUpLoading.dart';

class Utils {
  //Fonts Start
  static double smallFonts = 10.0;
  static double xlFonts = 30.0;

  static List<Map<String, dynamic>> docs = [
    {"id": 0, "name": "None", "hasNumber": true, "fieldName": ""},
    {
      "id": 1,
      "name": "National Identity Card",
      "hasNumber": true,
      "fieldName": "NIC Number",
      "validate": true,
      "pattern": DocumentValidation.patternNIC
    },
    {
      "id": 2,
      "name": "Birth Certificate",
      "hasNumber": false,
      "fieldName": "",
      "validate": false
    },
    {
      "id": 3,
      "name": "Passport",
      "hasNumber": true,
      "fieldName": "Passport Number",
      "validate": true,
      "pattern": DocumentValidation.patternPassport
    },
    {
      "id": 4,
      "name": "Covid Vaccinated Report",
      "hasNumber": false,
      "fieldName": "",
      "validate": false
    },
  ];

  static String getDocumentName(key) {
    late String record = "";
    docs.forEach((element) {
      if (element['id'] == key) {
        record = element['name'];
      }
    });
    return record;
  }
  //Fonts End

  static late Size displaySize;
  static late ProfileUser profileUser;

  static var loadingMessage;

  static var lightNavbar = SystemUiOverlayStyle.light.copyWith(
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: UtilColors.blackColor,
      statusBarColor: UtilColors.primaryStatusBarColor);

  static var darkNavbar = SystemUiOverlayStyle.dark.copyWith(
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: UtilColors.blackColor,
      statusBarColor: UtilColors.primaryStatusBarColor);

  //TextStyles
  static TextStyle getprimaryStyle(Color color) {
    return GoogleFonts.openSans(color: color);
  }

  static TextStyle getprimaryStyleSmall(Color color) {
    return GoogleFonts.openSans(color: color, fontSize: 13.0);
  }

  static TextStyle getprimaryBoldStyle(Color color) {
    return GoogleFonts.openSans(color: color, fontWeight: FontWeight.bold);
  }

  static TextStyle getprimaryFieldTextStyle(Color color) {
    return GoogleFonts.openSans(color: UtilColors.blackColor, fontSize: 13.0);
  }

  static TextStyle getprimaryFieldTextStylePopUp(Color color) {
    return GoogleFonts.openSans(color: UtilColors.primaryColor, fontSize: 13.0);
  }

  //TextFormField Styles

  static double borderRadius = 5.0;
  static double buttonBorderRadius = 5.0;

  static InputDecoration getDefaultTextInputDecoration(
      String label, Icon suffixIcon) {
    return InputDecoration(
        labelText: label,
        errorStyle: TextStyle(fontSize: 11, color: Colors.red),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        labelStyle: TextStyle(fontSize: 13.0, color: UtilColors.greyColor),
        suffixIcon: suffixIcon,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: UtilColors.secondaryColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: UtilColors.primaryColor, width: 1),
        ));
  }

  static InputDecoration getDefaultDropdownInputDecoration(String label) {
    return InputDecoration(
        labelText: label,
        errorStyle: TextStyle(fontSize: 11, color: Colors.red),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        labelStyle: TextStyle(fontSize: 13.0, color: UtilColors.greyColor),
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: UtilColors.secondaryColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: UtilColors.primaryColor, width: 1),
        ));
  }

  static InputDecoration getDefaultDropDownInputDecoration(
      String label, Icon suffixIcon) {
    return InputDecoration(
        errorStyle: TextStyle(fontSize: 11, color: Colors.red),
        labelStyle: TextStyle(fontSize: 13.0, color: UtilColors.greyColor),
        suffixIcon: suffixIcon,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: UtilColors.secondaryColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: UtilColors.primaryColor, width: 1),
        ));
  }

  //Loading Widgets

  static late bool checkShowLoader = false;
  static late BuildContext parentLoadingContext;

  static Future showLoader(context) async {
    await showDialog(
      context: context,
      builder: (_) => PopUpLoading(),
    ).then((onValue) {
      parentLoadingContext = context;
      checkShowLoader = true;
    });
  }

  static Future showLoaderWithCustomMessage(context, message) async {
    Utils.loadingMessage = message;
    await showDialog(
      context: context,
      builder: (_) => PopUpLoading(),
    ).then((onValue) {
      parentLoadingContext = context;
      checkShowLoader = true;
    });
  }

  static Future hideLoader() async {
    if (checkShowLoader == true) {
      Navigator.pop(parentLoadingContext);
      checkShowLoader = false;
      Utils.loadingMessage = null;
    }
  }

  static Future hideLoaderCurrrent(context) async {
    Navigator.pop(context);
    checkShowLoader = false;
  }

  //Toast Contents

  static showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 13.0);
  }

  static getGradientBackground() {
    return BoxDecoration(
        gradient: LinearGradient(
      begin: Alignment.topRight,
      tileMode: TileMode.decal,
      end: Alignment.bottomLeft,
      colors: [
        UtilColors.primaryColor,
        UtilColors.secondaryColor,
      ],
    ));
  }

  static getTextGradient() {
    return LinearGradient(
      colors: <Color>[UtilColors.primaryColor, UtilColors.secondaryColor],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  }
}

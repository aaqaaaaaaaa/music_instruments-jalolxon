import 'package:flutter/cupertino.dart';

class AppTheme {
  static const Color background = Color(0xFF9A7046);
  static const Color border = Color(0xFFFFE9CF);
  static const Color primaryColor = Color(0xffC59062);
  static const Color dialog = Color(0xffDAB680);

  static const String fontFamily = "Bangers";
  static const String greatVibes = "GreatVibes";
  static const LinearGradient linearGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppTheme.primaryColor, Color(0xffF6D891)],
  );
  static const TextStyle textStyle = TextStyle(
    color: Color(0xFFFFFFFF),
    fontFamily: fontFamily,
    decoration: TextDecoration.none,
    overflow: TextOverflow.ellipsis,
  );
  static TextStyle body48w4 = const TextStyle(
    letterSpacing: 0,
    wordSpacing: 0,
    color: Color(0xffffffff),
    fontWeight: FontWeight.w400,
    fontSize: 48,
    fontFamily: fontFamily,
    decoration: TextDecoration.none,
    overflow: TextOverflow.ellipsis,
  );
  static TextStyle body50w6 = const TextStyle(
    letterSpacing: 5,
    wordSpacing: 1,
    height: 0.9,
    color: AppTheme.background,
    fontWeight: FontWeight.w900,
    fontSize: 95,
    fontFamily: greatVibes,
    decoration: TextDecoration.none,
    overflow: TextOverflow.ellipsis,
  );
  static TextStyle body10w4 = const TextStyle(
    color: Color(0xFFFFFFFF),
    fontWeight: FontWeight.w400,
    fontSize: 10,
    fontFamily: fontFamily,
    decoration: TextDecoration.none,
    overflow: TextOverflow.ellipsis,
  );
  static TextStyle body12w4 = const TextStyle(
    color: Color(0xFFFFFFFF),
    fontWeight: FontWeight.w400,
    fontSize: 12,
    fontFamily: fontFamily,
    decoration: TextDecoration.none,
    overflow: TextOverflow.ellipsis,
  );
  static TextStyle body12w5 = const TextStyle(
    color: Color(0xFFFFFFFF),
    fontWeight: FontWeight.w500,
    fontSize: 12,
    fontFamily: fontFamily,
    decoration: TextDecoration.none,
    overflow: TextOverflow.ellipsis,
  );

  static TextStyle body12w6 = const TextStyle(
    color: Color(0xFFFFFFFF),
    fontWeight: FontWeight.w600,
    fontSize: 12,
    fontFamily: fontFamily,
    decoration: TextDecoration.none,
    overflow: TextOverflow.ellipsis,
  );
  static TextStyle body14w4 = const TextStyle(
    color: Color(0xFFFFFFFF),
    fontWeight: FontWeight.w400,
    fontSize: 14,
    fontFamily: fontFamily,
  );
  static TextStyle body14w5 = const TextStyle(
    color: Color(0xFFFFFFFF),
    fontWeight: FontWeight.w500,
    fontSize: 14,
    fontFamily: fontFamily,
    decoration: TextDecoration.none,
    overflow: TextOverflow.ellipsis,
  );
  static TextStyle body14w6 = const TextStyle(
    color: Color(0xFFFFFFFF),
    fontWeight: FontWeight.w600,
    fontSize: 14,
    fontFamily: fontFamily,
    decoration: TextDecoration.none,
    overflow: TextOverflow.ellipsis,
  );
  static TextStyle body14w7 = const TextStyle(
    color: Color(0xFFFFFFFF),
    fontWeight: FontWeight.w700,
    fontSize: 14,
    fontFamily: fontFamily,
  );
  static TextStyle body16w4 = const TextStyle(
    color: Color(0xFFFFFFFF),
    fontWeight: FontWeight.w400,
    fontSize: 16,
    fontFamily: fontFamily,
    decoration: TextDecoration.none,
  );
  static TextStyle body16w6 = const TextStyle(
    color: Color(0xFFFFFFFF),
    fontWeight: FontWeight.w600,
    fontSize: 16,
    fontFamily: fontFamily,
    decoration: TextDecoration.none,
    overflow: TextOverflow.ellipsis,
  );
  static TextStyle body16w7 = const TextStyle(
    color: Color(0xFFFFFFFF),
    fontWeight: FontWeight.w700,
    fontSize: 16,
    fontFamily: fontFamily,
    decoration: TextDecoration.none,
    overflow: TextOverflow.ellipsis,
  );
  static TextStyle body18w4 = const TextStyle(
    color: Color(0xFFFFFFFF),
    fontWeight: FontWeight.w400,
    fontSize: 18,
    fontFamily: fontFamily,
    decoration: TextDecoration.none,
    overflow: TextOverflow.ellipsis,
  );
  static TextStyle body18w5 = const TextStyle(
    color: Color(0xFFFFFFFF),
    fontWeight: FontWeight.w500,
    fontSize: 18,
    fontFamily: fontFamily,
    decoration: TextDecoration.none,
    overflow: TextOverflow.ellipsis,
  );
  static TextStyle body18w6 = const TextStyle(
    color: Color(0xFFFFFFFF),
    fontWeight: FontWeight.w600,
    fontSize: 18,
    fontFamily: fontFamily,
    decoration: TextDecoration.none,
    overflow: TextOverflow.ellipsis,
  );
  static TextStyle body18w7 = const TextStyle(
    color: Color(0xFFFFFFFF),
    fontWeight: FontWeight.w700,
    fontSize: 18,
    fontFamily: fontFamily,
    decoration: TextDecoration.none,
    overflow: TextOverflow.ellipsis,
  );
  static TextStyle body20w7 = const TextStyle(
    color: Color(0xFFFFFFFF),
    fontWeight: FontWeight.w700,
    fontSize: 20,
    fontFamily: fontFamily,
    decoration: TextDecoration.none,
    overflow: TextOverflow.ellipsis,
  );

  static TextStyle body24w6 = const TextStyle(
    color: Color(0xFFFFFFFF),
    fontWeight: FontWeight.w600,
    fontSize: 24,
    fontFamily: fontFamily,
    decoration: TextDecoration.none,
  );

  static TextStyle body28w6 = const TextStyle(
    color: Color(0xFFFFFFFF),
    fontWeight: FontWeight.w600,
    fontSize: 28,
    fontFamily: fontFamily,
    decoration: TextDecoration.none,
    overflow: TextOverflow.ellipsis,
  );

// static MaskTextInputFormatter numberMaskFormatter = MaskTextInputFormatter(
//   mask: ' ## ### ## ##',
//   filter: {"#": RegExp(r'\d')},
//   type: MaskAutoCompletionType.eager,
// );
}

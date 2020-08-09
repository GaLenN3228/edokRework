import 'package:flutter/cupertino.dart';


class Thm extends InheritedWidget {
  final AppThemeData data;

  const Thm({
    Key key,
    @required this.data,
    @required Widget child,
  })  : assert(child != null),
        assert(data != null),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(Thm oldWidget) => data != oldWidget.data;

  static AppThemeData of(BuildContext context) {
    // ignore: omit_local_variable_types
    final Thm theme = context.dependOnInheritedWidgetOfExactType();
    return theme?.data ?? AppThemeData.dark();
  }
}

class AppThemeData {
  final Color transparent;
  final Color backgroundColor;
  final Color pinkColor;
  final Color lightBackgroundColor;
  final Color secondaryColor;
  final Color secondaryLighterColor;
  final Color secondaryDarker50Color;
  final Color primaryColor;
  final Color accentColor;
  final Color blackColor;
  final Color acceptedColor;
  final Color draftColor;
  final Color orangeEdok;

  final TextStyle toolbarTitle;
  final TextStyle toolbarTitleNormal;
  final TextStyle contentBodyTitle;
  final TextStyle contentBodyTitleBold;
  final TextStyle contentBodyPrimary;
  final TextStyle contentBodySecondary;
  final TextStyle contentBodySecondaryOrange;
  final TextStyle contentBodyTitleSecondary;
  final TextStyle description;

  AppThemeData({
    @required this.acceptedColor,
    @required this.draftColor,
    @required this.orangeEdok,
    @required this.backgroundColor,
    @required this.pinkColor,
    @required this.blackColor,
    @required this.lightBackgroundColor,
    @required this.secondaryColor,
    @required this.secondaryLighterColor,
    @required this.secondaryDarker50Color,
    @required this.primaryColor,
    @required this.accentColor,
  })  : transparent = const Color(0x00000000),
        contentBodyTitle = _edokFont.copyWith(
          fontWeight: FontWeight.normal,
          fontSize: 24.0,
          color: blackColor,
        ),
        contentBodyTitleBold = _edokFont.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 24.0,
          color: blackColor,
        ),
        contentBodyPrimary = _edokFont.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
          color: blackColor,
        ),
        contentBodyTitleSecondary = _edokFont.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
          color: blackColor,
        ),
        contentBodySecondary = _edokFont.copyWith(
          fontWeight: FontWeight.normal,
          fontSize: 14.0,
          color: secondaryDarker50Color,
        ),
        contentBodySecondaryOrange = _edokFont.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14.0,
          color: orangeEdok,
        ),
        description = _edokFont.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 14.0,
          color: blackColor,
        ),
        toolbarTitleNormal = _edokFont.copyWith(
          fontWeight: FontWeight.normal,
          fontSize: 16.0,
          color: blackColor,
        ),
        toolbarTitle = _edokFont.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
          color: blackColor,
        );

  factory AppThemeData.dark() => AppThemeData(
    backgroundColor: const Color(0xFF0e1418),
    lightBackgroundColor: const Color(0xFF1a2023),
    secondaryColor: const Color(0xFFb0b1b2),
    secondaryDarker50Color: const Color(0xFF626669),
    primaryColor: const Color(0xFFffffff),
    accentColor: const Color(0xFFdc0027),
    secondaryLighterColor: const Color(0xFF909293),
    pinkColor: const Color(0xFFE1306C),
    blackColor: const Color(0xFF000000),
    draftColor:const Color(0xFF1DA1F2),
    acceptedColor: const Color(0xFF1AAD19),
    orangeEdok: const Color(0xFFFF6E40),
  );
  static const String _edokFontFamily = 'SF Pro Display';
  static const TextStyle _edokFont = TextStyle(
    fontFamily: _edokFontFamily,
  );
}
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newedok/themes/fond_and_colors.dart';
import 'package:newedok/ui/components/tappable.dart';

class AAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double height;
  final Widget title;
  final bool isArrowed;
  final Widget trailingIcon;
  final Widget leadingIcon;
  final bool isCenterTitle;
  final bool withDivider;
  final TextStyle textStyle;
  final Color backgroundColor;
  final VoidCallback onDrawerOpen;
  final bool isShowLeading;

  AAppBar({
    Key key,
    this.title,
    this.trailingIcon,
    this.leadingIcon,
    this.isCenterTitle = true,
    this.isArrowed = true,
    this.withDivider = true,
    this.backgroundColor,
    this.textStyle,
    this.onDrawerOpen,
    this.height = 70.0,
    this.isShowLeading = true,
  }) : super(key: key);

  @override
  _AAppBarState createState() => _AAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _AAppBarState extends State<AAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.withDivider
          ? BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: Thm.of(context).primaryColor, width: 1.0),
        ),
      )
          : BoxDecoration(),
      child: SafeArea(
        bottom: false,
        child: Container(
          height: widget.height,
          child: Center(
            child: DefaultTextStyle(
              style: widget.textStyle ?? Thm.of(context).toolbarTitle,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  if (widget.isCenterTitle) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        widget.title ?? Container(),
                      ],
                    )
                  ],
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            if (widget.isShowLeading) ...[
                              IconTheme(
                                data: IconThemeData(
                                  color: Colors.black,
                                  size: 25.0,
                                ),
                                child: widget.leadingIcon != null ? _leading(): Container(),
                              ),
                            ],
                            if (!widget.isCenterTitle) ...[
                              Expanded(child: widget.title ?? Container()),
                            ],
                          ],
                        ),
                      ),
                      IconTheme(
                        data: IconThemeData(
                          color: Colors.black,
                          size: 25.0,
                        ),
                        child: _trailing(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _leading() {
    if (widget.leadingIcon == null) {
      return widget.isArrowed == true
          ? Tappable(
        padding: EdgeInsets.only(
          left: 23.0,
          right: 20.0,
          top: 15.0,
          bottom: 15.0,
        ),
        child: Icon(Icons.arrow_back),
        onTap: () {
          ExtendedNavigator.of(context).pop();
        },
      )
          : Container();
    } else {
      return widget.leadingIcon;
    }
  }

  Widget _trailing() {
    if (widget.onDrawerOpen != null) {
      return Tappable(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30.0),
        onTap: widget.onDrawerOpen,
        child: Icon(Icons.menu),
      );
    } else {
      return widget.trailingIcon ?? Container();
    }
  }
}

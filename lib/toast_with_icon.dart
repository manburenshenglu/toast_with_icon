import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///author xjl
///description
///date 2020/7/10 15:51
///modify
enum ToastWithIconGravity { TOP, CENTER, BOTTOM }

class ToastWithIcon {
  static OverlayEntry _overlayEntry; // toast靠它加到屏幕上
  static bool _showing = false;
  static DateTime _startedTime;

  /// icon assets path
  static String _icon;

  /// msg content
  static String _msg;

  /// toast show time
  static int _showTime;
  static Color _bgColor;
  static Color _textColor;
  static double _textSize;
  static double _paddingHorizontal;
  static double _paddingVertical;
  static double _elevation;

  /// this toast's width is decided by both [_positionedLeft] and [_positionedRight]
  /// notes: [_positionedLeft] and [_positionedRight] is larger , toast's width is smaller!!!
  static double _positionedLeft;
  static double _positionedRight;

  ///[_icon]  width
  static double _iconWidth, _iconHeight;
  static ToastWithIconGravity _toastWithIconGravity;

  ///padding between [_icon] and [_msg]
  static double _textPadding;
  static Axis _axis;

  static void toast(BuildContext context,
      {String icon,
      String msg,
      int showTime = 2000,
      Axis axis = Axis.horizontal,
      Color bgColor = Colors.white,
      Color textColor = const Color(0xFF333333),
      double textSize = 15.0,
      double paddingHorizontal = 10.0,
      double paddingVertical = 10.0,
      double iconWidth = 15.0,
      double iconHeight = 15.0,
      double positionedLeft,
      double positionedRight,
      double textPadding = 5.0,
      double elevation = 1.0,
      ToastWithIconGravity gravity = ToastWithIconGravity.CENTER}) async {
    assert(msg != null);
//    assert(icon != null);
    _msg = msg;
    _icon = icon;
    _startedTime = DateTime.now();
    _axis = axis;
    _showTime = showTime;
    _bgColor = bgColor;
    _textColor = textColor;
    _textSize = textSize;
    _textPadding = textPadding;
    _paddingHorizontal = paddingHorizontal;
    _paddingVertical = paddingVertical;
    _iconWidth = iconWidth;
    _iconHeight = iconHeight;
    _positionedLeft = positionedLeft;
    _positionedRight = positionedRight;
    _elevation = elevation;
    _toastWithIconGravity = gravity;
    //获取OverlayState
    OverlayState overlayState = Overlay.of(context);
    _showing = true;
    if (_overlayEntry == null) {
      debugPrint(
          '${MediaQuery.of(context).size.width},${MediaQuery.of(context).size.height}');
      _overlayEntry = OverlayEntry(
          builder: (BuildContext context) => Positioned(
              //top值，可以改变这个值来改变toast在屏幕中的位置
              top: _calculateToastPosition(context),
              left:
                  _positionedLeft ?? MediaQuery.of(context).size.width * 3 / 10,
              right: _positionedRight ??
                  MediaQuery.of(context).size.width * 3 / 10,
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  child: Center(
                      child: AnimatedOpacity(
                    opacity: _showing ? 1.0 : 0.0, //目标透明度
                    duration: _showing
                        ? Duration(milliseconds: 100)
                        : Duration(milliseconds: 300),
                    child: _buildToastWidget(),
                  )),
                ),
              )));
      overlayState.insert(_overlayEntry);
    } else {
      //重新绘制UI，类似setState
      _overlayEntry?.markNeedsBuild();
    }
    await Future.delayed(Duration(milliseconds: _showTime)); // 等待时间

    //showTime 秒后 到底消失不消失
    if (DateTime.now().difference(_startedTime).inMilliseconds >= _showTime) {
      _showing = false;
      _overlayEntry?.markNeedsBuild();
      await Future.delayed(Duration(milliseconds: 200));
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  //toast paint
  static _buildToastWidget() {
    return Center(
      child: Card(
        elevation: _elevation,
        color: _bgColor,
        child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: _paddingHorizontal, vertical: _paddingVertical),
            child: Center(
              child: _axis == Axis.horizontal
                  ? _horizontalWidget()
                  : _verticalWidget(),
            )),
      ),
    );
  }

  static _horizontalWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _icon != null
            ? Image.asset(
                _icon,
                height: _iconHeight,
                width: _iconWidth,
              )
            : SizedBox(),
        Padding(
          padding: EdgeInsets.only(left: _textPadding),
          child: Text(
            _msg,
            style: TextStyle(
              fontSize: _textSize,
              color: _textColor,
            ),
          ),
        ),
      ],
    );
  }

  static _verticalWidget() {
    return Column(
      children: <Widget>[
        Offstage(
          child: Image.asset(_icon),
          offstage: _icon == null || _icon?.isEmpty,
        ),
        Padding(
          padding: EdgeInsets.only(top: _textPadding),
          child: Text(
            _msg,
            style: TextStyle(
              fontSize: _textSize,
              color: _textColor,
            ),
          ),
        ),
      ],
    );
  }

  ///  set toast position
  static _calculateToastPosition(context) {
    var topPosition;
    switch (_toastWithIconGravity) {
      case ToastWithIconGravity.TOP:
        topPosition = MediaQuery.of(context).size.height * 1 / 4;
        break;
      case ToastWithIconGravity.CENTER:
        topPosition = MediaQuery.of(context).size.height * 1 / 2;
        break;
      case ToastWithIconGravity.BOTTOM:
        topPosition = MediaQuery.of(context).size.height * 3 / 4;
        break;
      default:
        topPosition = MediaQuery.of(context).size.height * 1 / 2;
    }
    return topPosition;
  }
}

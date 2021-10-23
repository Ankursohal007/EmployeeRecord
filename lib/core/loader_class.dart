import 'package:employee_master/utils/centralize_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loader {
  static show({required BuildContext context}) {
    AlertDialog alert = AlertDialog(
      backgroundColor: CentralizeColor.colorTransparent,
      elevation: 0,
      content:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: 100.0,
              width: 100.0,
              decoration: BoxDecoration(
                  color: CentralizeColor.colorBlack.withOpacity(0.4),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              alignment: Alignment.center,
              child: const CupertinoActivityIndicator(
                radius: 20
              ))
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      barrierColor: CentralizeColor.colorTransparent,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

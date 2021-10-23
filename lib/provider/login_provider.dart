

import 'package:employee_master/core/loader_class.dart';
import 'package:employee_master/lang/const_string.dart';
import 'package:employee_master/routname/route_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier{

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isSaveButtonEnable = false;

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  bool get isSaveButtonEnable => _isSaveButtonEnable;

  RegExp emailRegix() {
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    return regExp;
  }

  bool saveButtonEnable({bool showAlert = false, BuildContext? context}) {
    if (_emailController.text.trim().isEmpty) {
      if (showAlert) {
        ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
          padding: EdgeInsets.all(12.0),
          content: Text(ConstString.enterAdminEmail),
          duration: Duration(seconds: 2),
        ));
      }
      notifyListeners();
      return _isSaveButtonEnable = false;
    }else if (!emailRegix().hasMatch(_emailController.text)) {
      if (showAlert) {
        ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
          padding: EdgeInsets.all(12.0),
          content: Text(ConstString.chkEmail),
          duration: Duration(seconds: 2),
        ));
      }
      notifyListeners();
      return _isSaveButtonEnable = false;
    }else if (_passwordController.text.isEmpty) {
      if (showAlert) {
        ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
          padding: EdgeInsets.all(12.0),
          content: Text(ConstString.loginPassword),
          duration: Duration(seconds: 2),
        ));
      }
      notifyListeners();
      return _isSaveButtonEnable = false;
    }else if (_passwordController.text.length < 6) {
      if (showAlert) {
        ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
          padding: EdgeInsets.all(12.0),
          content: Text(ConstString.codeLength),
          duration: Duration(seconds: 2),
        ));
      }
      notifyListeners();
      return _isSaveButtonEnable = false;
    }  else {
      notifyListeners();
      return _isSaveButtonEnable = true;
    }
  }
  clearLoginForm(){
    _emailController.clear();
    _passwordController.clear();
  }

  loginFirebase(BuildContext  context) async{
    Loader.show(context: context);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
      );
      Navigator.pop(context);
      Navigator.pushNamedAndRemoveUntil(context, RouteName.dashboard, (route) => false);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == ConstString.userNotFound) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          padding: EdgeInsets.all(12.0),
          content: Text(ConstString.chkValidUserPass),
          duration: Duration(seconds: 2),
        ));
      } else if (e.code == ConstString.wrongPassword) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          padding: EdgeInsets.all(12.0),
          content: Text(ConstString.chkEmailPass),
          duration: Duration(seconds: 2),
        ));
      }
    }
  }
}
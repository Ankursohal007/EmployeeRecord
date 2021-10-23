import 'dart:ui';
import 'package:employee_master/lang/const_string.dart';
import 'package:employee_master/provider/login_provider.dart';
import 'package:employee_master/utils/adaptive_text_size.dart';
import 'package:employee_master/utils/centralize_color.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/src/provider.dart';

class LogIn extends StatefulWidget {
  @override
  LogInState createState() => LogInState();
}

class LogInState extends State<LogIn> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), fixedSize: const Size(280, 40));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CentralizeColor.orangeBar,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(ConstString.cboEmployeeData,
                style: TextStyle(
                    color: CentralizeColor.colorWhite,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w500)),
            Card(
              margin: const EdgeInsets.only(
                  left: 50.0, right: 50, top: 20, bottom: 40),
              elevation: 6,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20, top: 40, bottom: 40),
                child: Column(
                  children: [
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller:
                          context.watch<LoginProvider>().emailController,
                      cursorColor : CentralizeColor.orangeBar,
                      decoration: InputDecoration(
                        label: const Text(ConstString.login),
                        hintText: ConstString.loginEmail,
                        hintStyle: TextStyle(
                          fontSize:
                              AdaptiveTextSize.getAdaptiveSize(14, context),
                          fontWeight: FontWeight.w500,
                        ),
                        labelStyle: TextStyle(
                          fontSize:
                              AdaptiveTextSize.getAdaptiveSize(14, context),
                          fontWeight: FontWeight.w500,
                            color: CentralizeColor.orangeBar
                        ),
                        fillColor: CentralizeColor.greyTransparent,
                        border: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(
                            borderSide : BorderSide(
                              color: CentralizeColor.orangeBar
                            )
                        ),
                      ),
                      style: TextStyle(
                        fontSize: AdaptiveTextSize.getAdaptiveSize(16, context),
                        fontWeight: FontWeight.w800,
                      ),
                      onChanged: (value) {
                        context.read<LoginProvider>().saveButtonEnable();
                      },
                    ),
                    ConstTextSize.kVerticalSpace(),
                    TextFormField(
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                        cursorColor : CentralizeColor.orangeBar,
                      controller:
                          context.watch<LoginProvider>().passwordController,
                      decoration: InputDecoration(
                        label: const Text(ConstString.password),
                        hintText: ConstString.loginPassword,
                        hintStyle: TextStyle(
                          fontSize:
                              AdaptiveTextSize.getAdaptiveSize(14, context),
                          fontWeight: FontWeight.w500,
                        ),
                        labelStyle: TextStyle(
                          fontSize:
                              AdaptiveTextSize.getAdaptiveSize(14, context),
                          fontWeight: FontWeight.w500,
                            color: CentralizeColor.orangeBar
                        ),
                        fillColor: CentralizeColor.greyTransparent,
                        border: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(
                            borderSide : BorderSide(
                                color: CentralizeColor.orangeBar
                            )
                        ),
                      ),
                      style: TextStyle(
                        fontSize: AdaptiveTextSize.getAdaptiveSize(16, context),
                        fontWeight: FontWeight.w800,
                      ),
                      onChanged: (value) {
                        context.read<LoginProvider>().saveButtonEnable();
                      },
                    ),
                    ConstTextSize.kVerticalSpace(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 20),
                          primary:
                              !context.watch<LoginProvider>().isSaveButtonEnable
                                  ? CentralizeColor.colorGrey
                                  : CentralizeColor.greenHigh),
                      onPressed: () {
                        FocusManager.instance.primaryFocus!.unfocus();
                        if (context.read<LoginProvider>().saveButtonEnable(
                            showAlert: true, context: context)) {
                          context.read<LoginProvider>().loginFirebase(context);
                        }
                      },
                      child: const Text(ConstString.login),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

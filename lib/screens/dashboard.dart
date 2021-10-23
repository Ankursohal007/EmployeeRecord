import 'package:employee_master/routname/route_name.dart';
import 'package:employee_master/utils/adaptive_text_size.dart';
import 'package:employee_master/utils/centralize_color.dart';
import 'package:employee_master/lang/const_string.dart';
import 'package:employee_master/provider/dashboard_provider.dart';
import 'package:employee_master/utils/custom_text_input_formatter.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  @override
  DashBoardState createState() => DashBoardState();
}

class DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: CentralizeColor.orangeBar,
          actions: [
            InkWell(
              child: const Icon(Icons.logout),
              onTap: () {
                context.read<DashBoardProvider>().showAlertDialog(context);
              },
            ),
          ],
          title: const Text(ConstString.empRecord),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, RouteName.employeeList);
          },
          label: const Text(ConstString.empList),
          icon: const Icon(Icons.list),
          backgroundColor: CentralizeColor.orangeBar,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller:
                      context.watch<DashBoardProvider>().empCodeController,
                  decoration: InputDecoration(
                    label: const Text(ConstString.empCode),
                    hintText: ConstString.enterEmpCode,
                    hintStyle: TextStyle(
                      fontSize: AdaptiveTextSize.getAdaptiveSize(14, context),
                      fontWeight: FontWeight.w500,
                    ),
                    labelStyle: TextStyle(
                      fontSize: AdaptiveTextSize.getAdaptiveSize(14, context),
                      fontWeight: FontWeight.w500,
                    ),
                    fillColor: CentralizeColor.greyTransparent,
                    border: const OutlineInputBorder(),
                  ),
                  style: TextStyle(
                    fontSize: AdaptiveTextSize.getAdaptiveSize(16, context),
                    fontWeight: FontWeight.w800,
                  ),
                  inputFormatters: [CustomTextInputFormatter(maximumLimit: 8)],
                  onChanged: (value) {
                    context.read<DashBoardProvider>().saveButtonEnable();
                  },
                ),
                ConstTextSize.kVerticalSpace(),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller:
                      context.watch<DashBoardProvider>().empNameController,
                  decoration: InputDecoration(
                    label: const Text(ConstString.empName),
                    hintText: ConstString.enterEmpName,
                    hintStyle: TextStyle(
                      fontSize: AdaptiveTextSize.getAdaptiveSize(14, context),
                      fontWeight: FontWeight.w500,
                    ),
                    labelStyle: TextStyle(
                      fontSize: AdaptiveTextSize.getAdaptiveSize(14, context),
                      fontWeight: FontWeight.w500,
                    ),
                    fillColor: CentralizeColor.greyTransparent,
                    border: const OutlineInputBorder(),
                  ),
                  style: TextStyle(
                    fontSize: AdaptiveTextSize.getAdaptiveSize(16, context),
                    fontWeight: FontWeight.w800,
                  ),
                  inputFormatters: [CustomTextInputFormatter(maximumLimit: 25)],
                  onChanged: (value) {
                    context.read<DashBoardProvider>().saveButtonEnable();
                  },
                ),
                ConstTextSize.kVerticalSpace(),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller:
                      context.watch<DashBoardProvider>().empAddressController,
                  decoration: InputDecoration(
                    label: const Text(ConstString.empAddress),
                    hintText: ConstString.enterEmpAdd,
                    hintStyle: TextStyle(
                      fontSize: AdaptiveTextSize.getAdaptiveSize(14, context),
                      fontWeight: FontWeight.w500,
                    ),
                    labelStyle: TextStyle(
                      fontSize: AdaptiveTextSize.getAdaptiveSize(14, context),
                      fontWeight: FontWeight.w500,
                    ),
                    fillColor: CentralizeColor.greyTransparent,
                    border: const OutlineInputBorder(),
                  ),
                  style: TextStyle(
                    fontSize: AdaptiveTextSize.getAdaptiveSize(16, context),
                    fontWeight: FontWeight.w800,
                  ),
                  maxLength: 100,
                  onChanged: (value) {
                    context.read<DashBoardProvider>().saveButtonEnable();
                  },
                ),
                ConstTextSize.kVerticalSpace(),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  controller:
                      context.watch<DashBoardProvider>().empMobileController,
                  decoration: InputDecoration(
                    label: const Text(ConstString.empMob),
                    hintText: ConstString.enterEmpMob,
                    hintStyle: TextStyle(
                      fontSize: AdaptiveTextSize.getAdaptiveSize(14, context),
                      fontWeight: FontWeight.w500,
                    ),
                    labelStyle: TextStyle(
                      fontSize: AdaptiveTextSize.getAdaptiveSize(14, context),
                      fontWeight: FontWeight.w500,
                    ),
                    fillColor: CentralizeColor.greyTransparent,
                    border: const OutlineInputBorder(),
                  ),
                  style: TextStyle(
                    fontSize: AdaptiveTextSize.getAdaptiveSize(16, context),
                    fontWeight: FontWeight.w800,
                  ),
                  inputFormatters: [CustomTextInputFormatter(maximumLimit: 10)],
                  onChanged: (value) {
                    context.read<DashBoardProvider>().saveButtonEnable();
                  },
                ),
                ConstTextSize.kVerticalSpace(),
                InkWell(
                  onTap: () {
                    FocusManager.instance.primaryFocus!.unfocus();
                    context.read<DashBoardProvider>().selectDate(context);
                  },
                  child: TextFormField(
                    enabled: false,
                    keyboardType: TextInputType.number,
                    controller:
                        context.watch<DashBoardProvider>().empDobController,
                    decoration: InputDecoration(
                      label: const Text(ConstString.empDOB),
                      hintText: ConstString.enterEmpDob,
                      hintStyle: TextStyle(
                        fontSize: AdaptiveTextSize.getAdaptiveSize(14, context),
                        fontWeight: FontWeight.w500,
                      ),
                      labelStyle: TextStyle(
                        fontSize: AdaptiveTextSize.getAdaptiveSize(14, context),
                        fontWeight: FontWeight.w500,
                      ),
                      fillColor: CentralizeColor.greyTransparent,
                      disabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: CentralizeColor.greyTransparent)),
                    ),
                    style: TextStyle(
                      fontSize: AdaptiveTextSize.getAdaptiveSize(16, context),
                      fontWeight: FontWeight.w800,
                    ),
                    onChanged: (value) {
                      context.read<DashBoardProvider>().saveButtonEnable();
                    },
                    onTap: () {
                      FocusManager.instance.primaryFocus!.unfocus();
                    },
                  ),
                ),
                ConstTextSize.kVerticalSpace(),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller:
                      context.watch<DashBoardProvider>().empRemarkController,
                  decoration: InputDecoration(
                    label: const Text(ConstString.empRemark),
                    hintText: ConstString.enterEmpAdd,
                    hintStyle: TextStyle(
                      fontSize: AdaptiveTextSize.getAdaptiveSize(14, context),
                      fontWeight: FontWeight.w500,
                    ),
                    labelStyle: TextStyle(
                      fontSize: AdaptiveTextSize.getAdaptiveSize(14, context),
                      fontWeight: FontWeight.w500,
                    ),
                    fillColor: CentralizeColor.greyTransparent,
                    border: const OutlineInputBorder(),
                  ),
                  style: TextStyle(
                    fontSize: AdaptiveTextSize.getAdaptiveSize(16, context),
                    fontWeight: FontWeight.w800,
                  ),
                  inputFormatters: [CustomTextInputFormatter(maximumLimit: 50)],
                ),
                ConstTextSize.kVerticalSpace(),
                ConstTextSize.kVerticalSpace(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                      primary:
                          !context.watch<DashBoardProvider>().isSaveButtonEnable
                              ? CentralizeColor.colorGrey
                              : CentralizeColor.greenHigh),
                  onPressed: () {
                    FocusManager.instance.primaryFocus!.unfocus();
                    if (context
                        .read<DashBoardProvider>()
                        .saveButtonEnable(showAlert: true, context: context)) {
                      context.read<DashBoardProvider>().insertData(context);
                    }
                  },
                  child: const Text(ConstString.submitButton),
                ),
              ],
            ),
          ),
        ));
  }
}

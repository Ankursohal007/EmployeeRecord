import 'package:employee_master/lang/const_string.dart';
import 'package:employee_master/provider/dashboard_provider.dart';
import 'package:employee_master/provider/update_provider.dart';
import 'package:employee_master/routname/route_name.dart';
import 'package:employee_master/utils/adaptive_text_size.dart';
import 'package:employee_master/utils/centralize_color.dart';
import 'package:employee_master/utils/custom_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class UpdateEmployee extends StatefulWidget {
  UpdateEmployee({required this.dashboardData});

  final DashboardData dashboardData;

  @override
  UpdateEmployeeState createState() => UpdateEmployeeState();
}

class UpdateEmployeeState extends State<UpdateEmployee> {

  void addData() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    context.read<UpdateProvider>().showData(widget.dashboardData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: CentralizeColor.updateBG,
        appBar: AppBar(
          backgroundColor: CentralizeColor.orange,
          actions: [
            InkWell(
              child: const Icon(Icons.cancel),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
          title: const Text(ConstString.updateEmployee),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                TextFormField(
                  enabled: false,
                  textInputAction: TextInputAction.next,
                  controller:
                      context.watch<UpdateProvider>().updateEmpCodeController,
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
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: CentralizeColor.blueHI)),
                  ),
                  style: TextStyle(
                    fontSize: AdaptiveTextSize.getAdaptiveSize(16, context),
                    fontWeight: FontWeight.w800,
                  ),
                  inputFormatters: [CustomTextInputFormatter(maximumLimit: 8)],
                  onChanged: (value) {
                  },
                ),
                ConstTextSize.kVerticalSpace(),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller:
                      context.watch<UpdateProvider>().updateNameController,
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
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: CentralizeColor.blueHI)),
                  ),
                  style: TextStyle(
                    fontSize: AdaptiveTextSize.getAdaptiveSize(16, context),
                    fontWeight: FontWeight.w800,
                  ),
                  inputFormatters: [CustomTextInputFormatter(maximumLimit: 25)],
                  onChanged: (value) {
                    context.read<UpdateProvider>().saveButtonEnable();
                  },
                ),
                ConstTextSize.kVerticalSpace(),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller:
                      context.watch<UpdateProvider>().updateAddressController,
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
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: CentralizeColor.blueHI)),
                  ),
                  style: TextStyle(
                    fontSize: AdaptiveTextSize.getAdaptiveSize(16, context),
                    fontWeight: FontWeight.w800,
                  ),
                  maxLength: 100,
                  onChanged: (value) {
                    context.read<UpdateProvider>().saveButtonEnable();
                  },
                ),
                ConstTextSize.kVerticalSpace(),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  controller:
                      context.watch<UpdateProvider>().updateMobileController,
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
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: CentralizeColor.blueHI)),
                  ),
                  style: TextStyle(
                    fontSize: AdaptiveTextSize.getAdaptiveSize(16, context),
                    fontWeight: FontWeight.w800,
                  ),
                  inputFormatters: [CustomTextInputFormatter(maximumLimit: 10)],
                  onChanged: (value) {
                    context.read<UpdateProvider>().saveButtonEnable();
                  },
                ),
                ConstTextSize.kVerticalSpace(),
                InkWell(
                  onTap: () {
                    context.read<UpdateProvider>().selectDate(context);
                  },
                  child: TextFormField(
                    enabled: false,
                    keyboardType: TextInputType.number,
                    controller:
                        context.watch<UpdateProvider>().updateDobController,
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
                      context.read<UpdateProvider>().saveButtonEnable();
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
                      context.watch<UpdateProvider>().updateRemarkController,
                  decoration: InputDecoration(
                    label: const Text(ConstString.empRemark),
                    hintText: ConstString.enterEmpRem,
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
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: CentralizeColor.blueHI)),
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
                          !context.watch<UpdateProvider>().isSaveButtonEnable
                              ? CentralizeColor.colorGrey
                              : CentralizeColor.greenHigh),
                  onPressed: () {
                    FocusManager.instance.primaryFocus!.unfocus();
                    if (context
                        .read<UpdateProvider>()
                        .saveButtonEnable(showAlert: true, context: context)) {
                      context.read<UpdateProvider>().updateData(context,
                          callback: () {
                        context.read<DashBoardProvider>().getDataRow(context);
                      });
                    }
                  },
                  child: const Text(ConstString.updateButton),
                ),
              ],
            ),
          ),
        ));
  }
}

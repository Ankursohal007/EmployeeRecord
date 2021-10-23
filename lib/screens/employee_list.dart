import 'package:employee_master/lang/const_string.dart';
import 'package:employee_master/provider/dashboard_provider.dart';
import 'package:employee_master/utils/adaptive_text_size.dart';
import 'package:employee_master/utils/centralize_color.dart';
import 'package:employee_master/utils/custom_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:provider/provider.dart';

class EmployeeList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmployeeList();
}

class _EmployeeList extends State<EmployeeList> {
  //const EmployeeList({Key? key}) : super(key: key);

  static const int numItems = 10;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);

  @override
  void initState() {
    super.initState();
    context.read<DashBoardProvider>().getDataRow(context);
  }

  @override
  Widget build(BuildContext context) {
    const double width = 700.0;

    return Scaffold(
        floatingActionButton: context.watch<DashBoardProvider>().isEditable ||
                context.watch<DashBoardProvider>().dashboardData.isEmpty
            ? Container()
            : FloatingActionButton(
                onPressed: () {
                  context.read<DashBoardProvider>().deleteSelected(context);
                },
                child: const Icon(Icons.delete, color: CentralizeColor.red),
                backgroundColor: CentralizeColor.colorWhite,
              ),
        appBar: AppBar(
          backgroundColor: CentralizeColor.orangeBar,
          leading: !context.watch<DashBoardProvider>().isSearchable
              ? const BackButton()
              : Container(),
          actions: [
            if (!context.watch<DashBoardProvider>().isSearchable)
              Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: InkWell(
                    child: const Icon(Icons.search),
                    onTap: () {
                      context
                          .read<DashBoardProvider>()
                          .updateIsSearchable(context);
                    },
                  ))
            else
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: CentralizeColor.colorWhite,
                      ),
                      suffixIcon: InkWell(
                        child: const Icon(
                          Icons.clear,
                          color: CentralizeColor.colorWhite,
                        ),
                        onTap: () {
                          context
                              .read<DashBoardProvider>()
                              .updateIsSearchable(context);
                        },
                      ),
                      hintText: ConstString.searchHere,
                      hintStyle: TextStyle(
                        fontSize: AdaptiveTextSize.getAdaptiveSize(24, context),
                        fontWeight: FontWeight.w300,
                        color: CentralizeColor.colorWhite,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: CentralizeColor.colorWhite),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: CentralizeColor.colorWhite),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: AdaptiveTextSize.getAdaptiveSize(24, context),
                      fontWeight: FontWeight.w500,
                      color: CentralizeColor.colorWhite,
                    ),
                    inputFormatters: [
                      CustomTextInputFormatter(maximumLimit: 30)
                    ],
                    onChanged: (value) {
                      context
                          .read<DashBoardProvider>()
                          .searchEmployee(context, value);
                    },
                  ),
                ),
              ),
            if (context.watch<DashBoardProvider>().dashboardData.isNotEmpty)
              if (context.watch<DashBoardProvider>().isEditable)
                InkWell(
                  child: const Icon(Icons.clear),
                  onTap: () {
                    context.read<DashBoardProvider>().updateIsEditable(context);
                  },
                )
              else
                InkWell(
                  child: const Icon(Icons.edit),
                  onTap: () {
                    context.read<DashBoardProvider>().updateIsEditable(context);
                  },
                ),
          ],
          title: const Text(ConstString.masterRecord),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          color: CentralizeColor.colorWhite,
          child: context.watch<DashBoardProvider>().dashboardData.isEmpty
              ? const Center(
                  child: Text(ConstString.noRecordFound))
              : DataTable2(
                  columnSpacing: 12,
                  horizontalMargin: 12,
                  showCheckboxColumn: true,
                  border: TableBorder(
                      top: const BorderSide(color: Colors.black),
                      bottom: BorderSide(color: Colors.grey[300]!),
                      left: BorderSide(color: Colors.grey[300]!),
                      right: BorderSide(color: Colors.grey[300]!),
                      verticalInside: BorderSide(color: Colors.grey[300]!),
                      horizontalInside:
                          const BorderSide(color: Colors.grey, width: 1)),
                  dividerThickness: 1,
                  // this one will be ignored if [border] is set above
                  bottomMargin: 10,
                  minWidth: width,
                  columns: [
                    if (context.watch<DashBoardProvider>().isEditable)
                      DataColumn2(
                          size: ColumnSize.S,
                          label: Container(
                              alignment: Alignment.center,
                              child: const Text(ConstString.edit))),
                    DataColumn2(
                        size: ColumnSize.M,
                        label: Container(
                            alignment: Alignment.center,
                            child: const Text(ConstString.empCode))),
                    DataColumn2(
                        size: ColumnSize.L,
                        label: Container(
                            alignment: Alignment.center,
                            child: const Text(ConstString.empName))),
                    DataColumn2(
                        size: ColumnSize.L,
                        label: Container(
                            alignment: Alignment.center,
                            child: const Text(ConstString.empAddress))),
                    DataColumn2(
                        size: ColumnSize.M,
                        label: Container(
                            alignment: Alignment.center,
                            child: const Text(ConstString.empMob))),
                    DataColumn2(
                        size: ColumnSize.M,
                        label: Container(
                            alignment: Alignment.center,
                            child: const Text(ConstString.empMob))),
                    DataColumn2(
                        size: ColumnSize.L,
                        label: Container(
                            alignment: Alignment.center,
                            child: const Text(ConstString.empRemark))),
                  ],
                  rows: context.watch<DashBoardProvider>().dashboardData,
                ),
        ));
  }
}

import 'package:employee_master/db_helper.dart';
import 'package:employee_master/domain/data_class/dashboard_data.dart';
import 'package:employee_master/lang/const_string.dart';
import 'package:employee_master/provider/login_provider.dart';
import 'package:employee_master/routname/route_name.dart';
import 'package:employee_master/utils/centralize_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
export 'package:employee_master/domain/data_class/dashboard_data.dart';

class DashBoardProvider with ChangeNotifier {
  final TextEditingController _empCodeController = TextEditingController();
  final TextEditingController _empNameController = TextEditingController();
  final TextEditingController _empAddressController = TextEditingController();
  final TextEditingController _empMobileController = TextEditingController();
  final TextEditingController _empDobController = TextEditingController();
  final TextEditingController _empRemarkController = TextEditingController();
  bool _isSaveButtonEnable = false;
  List<DataRow> _dashboardData = [];
  List<String> _deletedData = [];
  bool _isEditable = false;
  bool _isSearchable = false;
  List<DashboardData> getData = [];
  List<DashboardData> searchData = <DashboardData>[];
  String queryEnter = "";

  TextEditingController get empCodeController => _empCodeController;
  TextEditingController get empNameController => _empNameController;
  TextEditingController get empAddressController => _empAddressController;
  TextEditingController get empMobileController => _empMobileController;
  TextEditingController get empDobController => _empDobController;
  TextEditingController get empRemarkController => _empRemarkController;

  bool get isSaveButtonEnable => _isSaveButtonEnable;
  bool get isEditable => _isEditable;
  bool get isSearchable => _isSearchable;

  List<DataRow> get dashboardData => _dashboardData;

  final dbHelper = DatabaseHelper.instance;

  TextStyle btnStyle = const TextStyle(
    fontSize: 18.0,
    fontFamily: "Verdana",
  );

  void insertData(BuildContext context) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnID: _empCodeController.text,
      DatabaseHelper.columnName: _empNameController.text,
      DatabaseHelper.columnAddress: _empAddressController.text,
      DatabaseHelper.columnMobile: _empMobileController.text,
      DatabaseHelper.columnDOB: _empDobController.text,
      DatabaseHelper.columnRemark: _empRemarkController.text,
    };

    bool isAlreadyAdded = await dbHelper.checkData(_empCodeController.text);

    if (isAlreadyAdded) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        padding: EdgeInsets.all(12.0),
        content: Text(ConstString.noRecord),
        duration: Duration(seconds: 2),
      ));
    } else {
      final id = await dbHelper.insertData(row);
      if (id == 0) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          padding: EdgeInsets.all(12.0),
          content:
          Text(ConstString.errorInserting),
          duration: Duration(seconds: 2),
        ));
      } else {
        clearForm();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: CentralizeColor.greenLow,
          padding: EdgeInsets.all(12.0),
          content: Text(ConstString.addedSuccessfully),
          duration: Duration(seconds: 2),
        ));
      }
    }
  }


  void deleteData(List<Object?>? id, BuildContext context) async {
    var allRows = await dbHelper.deleteData(id);

    if (allRows == 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        padding: EdgeInsets.all(12.0),
        content: Text(ConstString.noDataSelected),
        duration: Duration(seconds: 2),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: CentralizeColor.orangeBar,
        padding: EdgeInsets.all(12.0),
        content: Text(ConstString.deletedSuccessfully),
        duration: Duration(seconds: 2),
      ));
      getDataRow(context);
    }
  }

  void deleteAllData() async {
    dbHelper.deleteAllData();
  }

  bool saveButtonEnable({bool showAlert = false, BuildContext? context}) {
    if (_empCodeController.text.trim().isEmpty) {
      if (showAlert) {
        ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
          padding: EdgeInsets.all(12.0),
          content: Text(ConstString.pleaseEnterCode),
          duration: Duration(seconds: 2),
        ));
      }
      notifyListeners();
      return _isSaveButtonEnable = false;
    } else if (_empCodeController.text.length < 6) {
      if (showAlert) {
        ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
          padding: EdgeInsets.all(12.0),
          content: Text(ConstString.codeLength),
          duration: Duration(seconds: 2),
        ));
      }
      notifyListeners();
      return _isSaveButtonEnable = false;
    } else if (_empNameController.text.trim().isEmpty) {
      if (showAlert) {
        ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
          padding: EdgeInsets.all(12.0),
          content: Text(ConstString.pleaseName),
          duration: Duration(seconds: 2),
        ));
      }
      notifyListeners();
      return _isSaveButtonEnable = false;
    } else if (_empAddressController.text.trim().isEmpty) {
      if (showAlert) {
        ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
          padding: EdgeInsets.all(12.0),
          content: Text(ConstString.pleaseAddress),
          duration: Duration(seconds: 2),
        ));
      }
      notifyListeners();
      return _isSaveButtonEnable = false;
    } else if (_empMobileController.text.trim().isEmpty) {
      if (showAlert) {
        ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
          padding: EdgeInsets.all(12.0),
          content: Text(ConstString.pleaseNumber),
          duration: Duration(seconds: 2),
        ));
      }
      notifyListeners();
      return _isSaveButtonEnable = false;
    } else if (_empMobileController.text.length != 10) {
      if (showAlert) {
        ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
          padding: EdgeInsets.all(12.0),
          content: Text(ConstString.pleaseChk),
          duration: Duration(seconds: 2),
        ));
      }
      notifyListeners();
      return _isSaveButtonEnable = false;
    } else if (_empDobController.text.trim().isEmpty) {
      if (showAlert) {
        ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
          padding: EdgeInsets.all(12.0),
          content: Text(ConstString.pleaseDOB),
          duration: Duration(seconds: 2),
        ));
      }
      notifyListeners();
      return _isSaveButtonEnable = false;
    } else {
      notifyListeners();
      return _isSaveButtonEnable = true;
    }
  }

  DateTime selectedDate = DateTime.now();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1990, 1),
        lastDate: DateTime.now());

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      _empDobController.text = "${selectedDate.toLocal()}".split(' ')[0];
      saveButtonEnable();
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      child: const Text(ConstString.cancel, style:  TextStyle(color: CentralizeColor.blueHI)),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = ElevatedButton(
      child: const Text(ConstString.logout, style: TextStyle(color: CentralizeColor.orange)),
      onPressed: () {
        Navigator.pushNamedAndRemoveUntil(context, RouteName.initialRoute, (route) => false);
        context.read<LoginProvider>().clearLoginForm();

      },
    );
    AlertDialog alert = AlertDialog(
      backgroundColor: CentralizeColor.updateBG,
      title:
      const Text(ConstString.loggingOut, style: TextStyle(color: CentralizeColor.blueHI)),
      content: const Text(ConstString.areYouSure,
          style: TextStyle(color: CentralizeColor.blueHI)),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }



  getDataRow(BuildContext context, {refreshData = true}) async {
    if (refreshData) {
      getData = [];
      var allRows = await dbHelper.queryAllRow();

      if (allRows.isEmpty) {
        getData = [];
      } else {
        getData = List<DashboardData>.from(
            allRows.map((i) => DashboardData.fromJson(i)));
      }
    }
    _dashboardData = [];

    if(refreshData && (searchData.isNotEmpty || queryEnter.isNotEmpty)){
      List<DashboardData> dummySearchList = <DashboardData>[];
      dummySearchList.addAll(getData);
      searchData = [];
      if(queryEnter.isNotEmpty && queryEnter != "") {
        for (var item in dummySearchList) {
          if(item.columnID.toLowerCase().contains(queryEnter.toLowerCase())
              || item.columnName.toLowerCase().contains(queryEnter.toLowerCase())) {
            searchData.add(item);
          }
        }
      } else{
      }
    }
    if(searchData.isNotEmpty || queryEnter.isNotEmpty){
      for (int i = 0; i < searchData.length; i++) {
        DashboardData dashboardData = searchData[i];
        _dashboardData.add(DataRow(
          cells: [
            if (_isEditable)
              DataCell(
                  Container(
                      alignment: Alignment.center,
                      child: const Icon(Icons.edit)), onTap: () {
                Navigator.pushNamed(context, RouteName.updateEmployee,
                    arguments: dashboardData);
              }),
            DataCell(Text(dashboardData.columnID)),
            DataCell(Text(dashboardData.columnName)),
            DataCell(Text(dashboardData.columnAddress)),
            DataCell(Text(dashboardData.columnMobile)),
            DataCell(Text(dashboardData.columnDOB)),
            DataCell(Text(dashboardData.columnRemark)),
          ],
          selected: dashboardData.isSelected,

          onSelectChanged: _isEditable
              ? null
              : (val) {
            dashboardData.isSelected = !dashboardData.isSelected;
            getDataRow(context, refreshData: false);
          },
        ));
      }
    }else {
      for (int i = 0; i < getData.length; i++) {
        DashboardData dashboardData = getData[i];
        _dashboardData.add(DataRow(
          cells: [
            if (_isEditable)
              DataCell(
                  Container(
                      alignment: Alignment.center,
                      child: const Icon(Icons.edit)), onTap: () {
                Navigator.pushNamed(context, RouteName.updateEmployee,
                    arguments: dashboardData);
              }),
            DataCell(Text(dashboardData.columnID)),
            DataCell(Text(dashboardData.columnName)),
            DataCell(Text(dashboardData.columnAddress)),
            DataCell(Text(dashboardData.columnMobile)),
            DataCell(Text(dashboardData.columnDOB)),
            DataCell(Text(dashboardData.columnRemark)),
          ],
          selected: dashboardData.isSelected,
          onSelectChanged: _isEditable
              ? null
              : (val) {
            dashboardData.isSelected = !dashboardData.isSelected;
            getDataRow(context, refreshData: false);
          },
        ));
      }
    }
    notifyListeners();
  }

  clearForm() {
    _empCodeController.clear();
    _empNameController.clear();
    _empAddressController.clear();
    _empMobileController.clear();
    _empDobController.clear();
    _empRemarkController.clear();
    saveButtonEnable();
    notifyListeners();
  }


  deleteSelected(BuildContext context) {
    _deletedData = [];
    getData.where((element) => element.isSelected).forEach((element) {
      _deletedData.add(element.columnID);
    });
    deleteData(_deletedData, context);
  }

  updateIsEditable(BuildContext context){
    _isEditable =  !_isEditable;
    getDataRow(context);
  }

  updateIsSearchable(BuildContext context){
    _isSearchable =  !_isSearchable;
    if(!_isSearchable){
      queryEnter = "";
      searchData = [];
      getDataRow(context, refreshData:  false);
    }else{
      notifyListeners();
    }

  }

  searchEmployee(BuildContext context, String query){
    if(getData.isNotEmpty){
      List<DashboardData> dummySearchList = <DashboardData>[];
      dummySearchList.addAll(getData);
      searchData = [];
      queryEnter = query;
      if(query.isNotEmpty && query != "") {
        for (var item in dummySearchList) {
          if(item.columnID.toLowerCase().contains(query.toLowerCase())
              || item.columnName.toLowerCase().contains(query.toLowerCase())) {
            searchData.add(item);
          }
        }
        getDataRow(context, refreshData:  false);
      } else{
        getDataRow(context, refreshData:  false);
      }
    }
  }

}

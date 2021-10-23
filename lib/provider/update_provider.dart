import 'package:employee_master/db_helper.dart';
import 'package:employee_master/provider/dashboard_provider.dart';
import 'package:employee_master/routname/route_name.dart';
import 'package:employee_master/utils/centralize_color.dart';
import 'package:flutter/material.dart';

class UpdateProvider with ChangeNotifier {

  TextEditingController _updateEmpCodeController = TextEditingController();
  TextEditingController _updateNameController = TextEditingController();
  TextEditingController _updateAddressController = TextEditingController();
  TextEditingController _updateMobileController = TextEditingController();
  TextEditingController _updateDobController = TextEditingController();
  TextEditingController _updateRemarkController = TextEditingController();
  bool _isSaveButtonEnable = false;
  List<DataRow> _dashboardData = [];
  List<String> _deletedData = [];
  bool _isEditable = true;

  TextEditingController get updateEmpCodeController => _updateEmpCodeController;
  TextEditingController get updateNameController => _updateNameController;
  TextEditingController get updateAddressController => _updateAddressController;
  TextEditingController get updateMobileController => _updateMobileController;
  TextEditingController get updateDobController => _updateDobController;
  TextEditingController get updateRemarkController => _updateRemarkController;
  bool get isSaveButtonEnable => _isSaveButtonEnable;
  bool get isEditable => _isEditable;

  List<DataRow> get dashboardData => _dashboardData;
  final dbhelper = DatabaseHelper.instance;


  bool saveButtonEnable({bool showAlert=false,BuildContext? context }){
    if(_updateEmpCodeController.text.trim().isEmpty){
      if(showAlert) {
        ScaffoldMessenger.of(context!).showSnackBar(
            const SnackBar(
              padding: EdgeInsets.all(12.0),
              content: Text('Please enter your Employee Code'),
              duration: Duration(seconds: 2),
            )
        );
      }
      notifyListeners();
      return _isSaveButtonEnable = false;
    }
    else if(_updateEmpCodeController.text.length < 6){
      if(showAlert) {
        ScaffoldMessenger.of(context!).showSnackBar(
            const SnackBar(
              padding: EdgeInsets.all(12.0),
              content: Text('Employee Code Length must be 6 or Greater'),
              duration: Duration(seconds: 2),
            )
        );
      }
      notifyListeners();
      return _isSaveButtonEnable = false;
    }
     if(_updateNameController.text.trim().isEmpty){
      if(showAlert) {
        ScaffoldMessenger.of(context!).showSnackBar(
            const SnackBar(
              padding: EdgeInsets.all(12.0),
              content: Text('Please enter your Name'),
              duration: Duration(seconds: 2),
            )
        );
      }
      notifyListeners();
      return _isSaveButtonEnable = false;
    }
    else if(_updateAddressController.text.trim().isEmpty){
      if(showAlert) {
        ScaffoldMessenger.of(context!).showSnackBar(
            const SnackBar(
              padding: EdgeInsets.all(12.0),
              content: Text('Please enter Address'),
              duration: Duration(seconds: 2),
            )
        );
      }
      notifyListeners();
      return _isSaveButtonEnable = false;
    }
    else if(_updateMobileController.text.trim().isEmpty){
      if(showAlert) {
        ScaffoldMessenger.of(context!).showSnackBar(
            const SnackBar(
              padding: EdgeInsets.all(12.0),
              content: Text('Please enter Contact Number'),
              duration: Duration(seconds: 2),
            )
        );
      }
      notifyListeners();
      return _isSaveButtonEnable = false;
    }
    else if(_updateMobileController.text.length != 10 ){
      if(showAlert) {
        ScaffoldMessenger.of(context!).showSnackBar(
            const SnackBar(
              padding: EdgeInsets.all(12.0),
              content: Text('Please Check your Number'),
              duration: Duration(seconds: 2),
            )
        );
      }
      notifyListeners();
      return _isSaveButtonEnable = false;
    }
    else if(_updateDobController.text.trim().isEmpty){
      if(showAlert) {
        ScaffoldMessenger.of(context!).showSnackBar(
            const SnackBar(
              padding: EdgeInsets.all(12.0),
              content: Text('Please enter Date of Birth'),
              duration: Duration(seconds: 2),
            )
        );
      }
      notifyListeners();
      return _isSaveButtonEnable = false;
    }
    else{
      notifyListeners();
      return _isSaveButtonEnable = true;
    }
  }


  showData(DashboardData dashboardData){
     _updateEmpCodeController = TextEditingController(text: dashboardData.columnID);
     _updateNameController = TextEditingController(text:dashboardData.columnName);
     _updateAddressController = TextEditingController(text:dashboardData.columnAddress);
     _updateMobileController = TextEditingController(text:dashboardData.columnMobile);
     _updateDobController = TextEditingController(text:dashboardData.columnDOB);
     _updateRemarkController = TextEditingController(text:dashboardData.columnRemark);
     WidgetsBinding.instance!.addPostFrameCallback((_) {
       notifyListeners();
     });
  }

  clearUpdatedForm(){
    _updateEmpCodeController.clear();
    _updateNameController.clear();
    _updateAddressController.clear();
    _updateMobileController.clear();
    _updateDobController.clear();
    _updateRemarkController.clear();
    saveButtonEnable();
    notifyListeners();
  }

  updateData(BuildContext context, {callback}) async{
    Map<String, dynamic> row = {
      DatabaseHelper.columnID: _updateEmpCodeController.text,
      DatabaseHelper.columnName: _updateNameController.text,
      DatabaseHelper.columnAddress: _updateAddressController.text,
      DatabaseHelper.columnMobile: _updateMobileController.text,
      DatabaseHelper.columnDOB: _updateDobController.text,
      DatabaseHelper.columnRemark: _updateRemarkController.text,
    };

    final id = await dbhelper.update(row, _updateEmpCodeController.text);
    if (id == 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        padding: EdgeInsets.all(12.0),
        content:
        Text('Error in updating records. Please try after sometime'),
        duration: Duration(seconds: 2),
      ));
    } else {
      clearUpdatedForm();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: CentralizeColor.greenLow,
        padding: EdgeInsets.all(12.0),
        content: Text('Employee updated successfully'),
        duration: Duration(seconds: 2),
      ));
      if(callback != null) {
        callback();
      }
      Navigator.pop(context);
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
      _updateDobController.text = "${selectedDate.toLocal()}".split(' ')[0];
      saveButtonEnable();
    }
  }
}
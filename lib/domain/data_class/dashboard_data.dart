

class DashboardData {
  final String columnID,columnName,columnAddress,columnMobile,columnDOB,columnRemark;
  bool isSelected;

  DashboardData({required this.columnID, required this.columnName, required this.columnAddress
    , required this.columnMobile, required this.columnDOB, required this.columnRemark,
  required this.isSelected});

  DashboardData.fromJson(Map<String, dynamic> json):
        columnID =  json['EmpCode'].toString(),
        columnName = json['EmpName'].toString(),
        columnAddress =  json['EmpAddress'].toString(),
        columnMobile =  json['EmpMobile'].toString(),
        columnDOB =  json['EmpAge'].toString(),
        columnRemark = json['EmpRemark'] == null  ? "" : json['EmpRemark'].toString(),
        isSelected = false;


}

class DashboardDataID {
  final String columnID;

  DashboardDataID({required this.columnID});

  DashboardDataID.fromJson(DashboardData json):
        columnID =  json.columnID;

  Map<String, dynamic> toJson() => {
    'columnID': columnID,
  };

}
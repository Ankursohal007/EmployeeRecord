import 'package:employee_master/domain/data_class/dashboard_data.dart';
import 'package:employee_master/routname/route_name.dart';
import 'package:employee_master/screens/dashboard.dart';
import 'package:employee_master/screens/employee_list.dart';
import 'package:employee_master/screens/log_in.dart';
import 'package:employee_master/screens/update_employee.dart';
import 'package:flutter/material.dart';
class CentralizeRoute {
  static Map<String, WidgetBuilder> getRoute(RouteSettings settings){
    return {
      RouteName.initialRoute : (context) =>  LogIn(),
      RouteName.dashboard : (context) =>  DashBoard(),
      RouteName.employeeList  : (context) =>  EmployeeList(),
    };
  }

  static Widget makeRoute(
      {required BuildContext context,
        String? routeName,
        Object? arguments}) {
    final Widget child =
    buildRoute(context: context, routeName: routeName, arguments: arguments);
    return child;
  }

  static Widget buildRoute({required BuildContext context,  String? routeName, Object? arguments}) {
    switch (routeName) {

      case RouteName.initialRoute:
        return LogIn();

      case RouteName.dashboard:
        return DashBoard();

      case RouteName.employeeList:
        return EmployeeList();

      case RouteName.updateEmployee:
        DashboardData dashboardData = arguments as DashboardData;
        return UpdateEmployee(dashboardData: dashboardData);

      default:
        throw 'Route $routeName is not defined';
    }
  }

}






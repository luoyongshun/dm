import '../IModel.dart';

class Nav extends IModel{
  String navName;
  String navType;
  String navId;

  Nav({this.navName, this.navType, this.navId});

  Nav.fromJson(Map<String, dynamic> json) {
    navName = json['nav_name'];
    navType = json['nav_type'];
    navId = json['nav_id'];
  }
}
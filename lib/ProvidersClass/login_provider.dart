import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  bool _isLogin = true;
  bool _isHidden = true;
  bool _isLoading = false;
  bool _adminKeyField = false;
  bool _adminKeyToggle = true;
  bool _infoSaved = false;

  bool get isLogin => _isLogin;
  bool get isHidden => _isHidden;
  bool get isLoading => _isLoading;
  bool get adminKeyField => _adminKeyField;
  bool get adminKeyToggle => _adminKeyToggle;
  bool get infoSaved => _infoSaved;

  void showAdminKeyField() {
    _adminKeyField = !_adminKeyField;
    notifyListeners();
  }

  void toggleAdminKey() {
    _adminKeyToggle = !_adminKeyToggle;
    notifyListeners();
  }

  void toggleLogin() {
    _isLogin = !_isLogin;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _isHidden = !_isHidden;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setInfoSaved(bool value) {
    _infoSaved = value;
    notifyListeners();
  }

  bool matchAdminKey(String val) {
    if (val.trim().contains("AIzaSyDmMFQTwPlSsz95sUodtFPHvB3A7NiRPrc")) {
      return true;
    }
    return false;
  }
}

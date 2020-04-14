import 'package:cyoga/models/user_entity.dart';
import 'package:flutter/material.dart';
class UserProviderModel extends ChangeNotifier {

	UserModel _userModel = new UserModel();
	UserModel get userModel => _userModel;

	void set(UserModel userModel) {
		_userModel = userModel;
		notifyListeners();
	}
}

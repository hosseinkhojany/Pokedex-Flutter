    import 'dart:async' show Future;
    import 'package:shared_preferences/shared_preferences.dart';

    const USER_TOKEN = "USER_TOKEN";

    class SharedStore {
      static SharedPreferences? _prefsInstance;

      // call this method from iniState() function of mainApp().
      static Future<SharedPreferences> init() async {
        if(_prefsInstance != null){
          return _prefsInstance!;
        }else{
          _prefsInstance = await SharedPreferences.getInstance();
          return _prefsInstance!;
        }
      }

      static String getString(String key, [String defValue = ""]) {
        return _prefsInstance!.getString(key) ?? defValue;
      }

      static Future<bool> setString(String key, String value) async {
        return await _prefsInstance!.setString(key, value);
      }

      static String getUserToken([String defValue = ""]) {
        return _prefsInstance!.getString(USER_TOKEN) ?? defValue;
      }

      static Future<bool> setUserToken(String value) async {
        return _prefsInstance!.setString(USER_TOKEN, value);
      }
    }
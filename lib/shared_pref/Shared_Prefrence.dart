import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService extends GetxService {

  late SharedPreferences _prefService ;


  /// key constant
  static const String keyProfileImage = "user_profile_image";

  /// initial the Shared preference
  Future<SharedPrefService> init()async {
    _prefService = await  SharedPreferences.getInstance();
    return this ;
  }

  /// Save image  path
  Future<bool> saveImagePath(String path)async{
    return await _prefService.setString(keyProfileImage , path);
  }

  /// Get image path
  String getImagePath(){
    return _prefService.getString(keyProfileImage) ?? '';
  }

  ///Close a specific key
Future<bool> remover (String key)async {
 return await _prefService.remove(key);
 }
 /// Clear all storage
 Future<bool> clearAll ()async {
    return await _prefService.clear();
 }
}
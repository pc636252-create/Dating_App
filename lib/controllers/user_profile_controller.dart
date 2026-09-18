import 'package:get/get.dart';
import '../models/user_model.dart';

class UserDetailController extends GetxController {
  late UserModel user;
  final RxBool aboutExpanded = false.obs;
  final RxInt selectedPhotoIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    user = Get.arguments as UserModel;
  }

  void toggleAbout() => aboutExpanded.value = !aboutExpanded.value;

  void selectPhoto(int index) => selectedPhotoIndex.value = index;
}

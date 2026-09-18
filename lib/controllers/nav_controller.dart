import 'package:get/get.dart';

class NavController extends GetxController {
  final RxInt tabIndex = 0.obs;

  void changeTab(int index) => tabIndex.value = index;
}

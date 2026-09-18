import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LoginController extends GetxController {
  final RxInt currentIndex = 0.obs;

  final List<Map<String, String>> carouselData = [
    {
      'image': 'assets/images/g1.png',
      'title': 'Algorithm',
      'description': 'Users going through a vetting process to ensure you never match with bots.',
    },
    {
      'image': 'assets/images/g2.png',
      'title': 'Matches',
      'description': 'We help you find meaningful connections with people who share your interests.',
    },
    {
      'image': 'assets/images/g3.png',
      'title': 'Premium',
      'description': 'Enjoy a better experience with personalized features designed for you.',
    },
  ];

  void changePage(int index) {
    currentIndex.value = index;
  }
}
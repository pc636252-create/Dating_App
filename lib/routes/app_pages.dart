import 'package:dating_app/auth/authcontrollers/VerificationController.dart';
import 'package:dating_app/auth/authcontrollers/profileController.dart';
import 'package:dating_app/auth/login_page/login_page.dart';
import 'package:dating_app/auth/sign_up/sign_up.dart';
import 'package:get/get.dart';
import '../auth/InterestsScreen/InterestsScreen.dart';
import '../auth/SearchFriends/SearchFriends.dart';
import '../auth/code/code.dart';
import '../auth/authcontrollers/loginController.dart';
import '../auth/i_am/i_am.dart';
import '../auth/notification/notification.dart';
import '../auth/phone_number/phone_number.dart';
import '../auth/profile_screen/profile.dart';
import '../main.dart';
import '../screens/profile/own_profile_screen.dart';
import 'app_routes.dart';
import '../controllers/chat_controller.dart';
import '../controllers/user_profile_controller.dart';
import '../screens/home_Screen.dart';
import '../screens/filters/filters_screen.dart';
import '../screens/chat/chat_screen.dart';
import '../screens/user_detail/user_detail_screen.dart';
import '../screens/photo_viewer/photo_viewer_screen.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.login,
      page: () =>  LoginPage(),
      binding: BindingsBuilder((){
        Get.put(LoginController());
      })
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => sign_up(),
    ),
    GetPage(
      name: AppRoutes.number,
      page: () => PhoneNumber(),
    ),
    GetPage(
      name: AppRoutes.code,
      page: () => VerificationPage(),
      binding: BindingsBuilder((){
        Get.put(VerificationController());
      })
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => ProfileView(),
      binding: BindingsBuilder((){
        Get.put(ProfileController());
      })
    ),
    GetPage(
      name: AppRoutes.iam,
      page: () => GenderScreen(),
      binding: BindingsBuilder((){
        Get.put(ProfileController());
      })
    ),
    GetPage(
      name: AppRoutes.interest,
      page: () => InterestsScreen(),
      binding: BindingsBuilder((){
        Get.put(ProfileController());
      })
    ),
    GetPage(
      name: AppRoutes.searchfriends,
      page: () => SearchFriends(),
      binding: BindingsBuilder((){
        Get.put(ProfileController());
      })
    ),
    GetPage(
      name: AppRoutes.notification,
      page: () => NotificationsView(),
      binding: BindingsBuilder((){
        Get.put(ProfileController());
      })
    ),

/// Home page
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.filters,
      page: () => const FiltersScreen(),
    ),
    GetPage(
      name: AppRoutes.chat,
      page: () => const ChatScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ChatController>(() => ChatController());
      }),
    ),
    GetPage(
      name: AppRoutes.userdetaile,
      page: () => const UserDetailScreen(),
      binding: BindingsBuilder(() {
        Get.put(UserDetailController());
      }),
    ),
    GetPage(
      name: AppRoutes.photoViewer,
      page: () => const PhotoViewerScreen(),
    ),
    GetPage(
      name: AppRoutes.ownprofile,
      page: () => const OwnProfileScreen(),
    ),
  ];
}

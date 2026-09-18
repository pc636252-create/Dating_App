import 'package:dating_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class sign_up extends StatelessWidget {
  const sign_up({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 1),
                 SvgPicture.asset(
                  'assets/icons/trademark.svg',
                  width: 120.0,
                  height: 120.0,
                ),
              SizedBox(height: 40),
              Text(
                'Sign up to continue',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                width: Get.width*0.6,
                height: Get.height*0.07,
                child: ElevatedButton(
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE94057),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Continue with email',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.number);
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade100, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Use phone number',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.black, thickness: 1)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'or sign up with',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.black, thickness: 1)),
                ],
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Container(
                  width: 64,
                   height: 64,
                   decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(16),
                ),
                child: GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(
                    'assets/icons/1 FB.svg',
                    width: 120.0,
                    height: 120.0,
                  ),
                )
              ),
                  SizedBox(width: 16),
                  Container(
               width: 64,
                height: 64,
                 decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(16),
                ),
                child:  GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(
                    'assets/icons/2 Google.svg',
                    width: 120.0,
                    height: 120.0,
                  ),
                )
              ),
                  SizedBox(width: 16),
                  Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(16),
                ),
                child:  GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(
                    'assets/icons/3 Apple.svg',
                    width: 120.0,
                    height: 120.0,
                  ),
                )
                 ),
                ],
              ),
              const Spacer(flex: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Terms of use',
                      style: TextStyle(color: const Color(0xEFE4455F), fontSize: 15),
                    ),
                  ),
                  SizedBox(width: 16),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Privacy Policy',
                      style: TextStyle(color: const Color(0xEFE4455F), fontSize: 15),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/collection.dart';
import 'package:my_app/home.dart';



class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        ()=> NavigationBar(
          height: 50,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>controller.selectedIndex.value=index ,
          destinations: const [
              NavigationDestination(icon: Icon(Icons.home_max_rounded), label: "Home"),
              NavigationDestination(icon: Icon(Icons.save_alt_rounded), label: "Saved"),
              // NavigationDestination(icon: Icon(CupertinoIcons.profile_circled), label: "Profile"),
              
        ],),
      ),
      body: Obx(()=> controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const FullScreen(),
    const Collection()
  ];
}

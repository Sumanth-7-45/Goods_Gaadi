import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:self/Login%20info/profile.dart';
import 'package:self/upload.dart';
import 'Display/display_data_ui.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: true,
        title: const Text(
          "Goods Gaadi.Com",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontFamily: 'FontMain',
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets1/logo.png', width: 24, height: 24,),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      // Navigation Bar
      bottomNavigationBar: Obx(() => NavigationBar(height: 70, elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.add), label: 'Upload'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      // Reactive Body Content
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}
class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  // Tab Screens
  final List<Widget> screens = [
    // Home Screen with Search and several function
    Container(
      color: Colors.white,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [TextField(decoration: InputDecoration(hintText: 'Search...',
                prefixIcon: const Icon(Icons.search), filled: true, fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,),
              ),
            ),
            const UploadedImagesScreen(),
          ],
        ),
      ),
    ),
    // Upload Screen
    Container(
      padding: const EdgeInsets.all(0),
        child:MultiImageUploadScreen1(),
    ),
    // Profile Screen
    Container(
      color: Colors.blue,
      child: const logout(),

    ),
  ];
}
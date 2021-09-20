import 'package:get/get.dart';
import 'package:strive_benifits_assignment/app/screens/controller/home_controller.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }

}
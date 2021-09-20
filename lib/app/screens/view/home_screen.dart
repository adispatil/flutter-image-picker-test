import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:strive_benifits_assignment/app/screens/controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final HomeController _mController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: SpeedDial(
        child: const Icon(Icons.add),
        speedDialChildren: <SpeedDialChild>[
          SpeedDialChild(
            child: const Icon(Icons.image_rounded),
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
            label: 'Gallery',
            onPressed: () {
              _mController.getImage(ImageSource.gallery);
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.camera_alt_rounded),
            foregroundColor: Colors.black,
            backgroundColor: Colors.yellow,
            label: 'Camera',
            onPressed: () {
              _mController.getImage(ImageSource.camera);
            },
          ),
        ],
        closedForegroundColor: Colors.black,
        openForegroundColor: Colors.white,
        closedBackgroundColor: Colors.white,
        openBackgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Container(
          width: Get.width,
          height: Get.height,
          margin: const EdgeInsets.all(5.0),
          child: Obx(() {
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                ),
                itemCount: _mController.selectedImagesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    color: Colors.red,
                    child: Stack(
                        children: [
                    Expanded(
                      child: Image.file(
                      File(_mController.selectedImagesList[index]),
                        fit: BoxFit.fill,
                      width: double.infinity,
                      height: double.infinity,),
                    ),

                          Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                  onTap: (){
                                    Get.defaultDialog(
                                        title: 'Are you sure?',
                                        middleText: 'Are you sure you want to delete this image ?',
                                        actions: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              MaterialButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: const Text(
                                                  "Cancel",
                                                ),
                                              ),
                                              MaterialButton(
                                                onPressed: () {
                                                  Get.back();
                                                  _mController.deleteFile(index);
                                                },
                                                child: const Text(
                                                  "Delete",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                        radius: 5.0

                                    );
                                  },
                                  child: Icon(Icons.delete_forever_rounded, color: Colors.white,)))
                        ]
                    ));
                });
          }),
        ),
      ),
    );
  }
}

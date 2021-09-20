import 'package:add_to_gallery/add_to_gallery.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io' as io;

class HomeController extends GetxController {
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;
  var selectedImagesList = [].obs;

  @override
  void onInit() {
    super.onInit();
    getPreSavedImages();
  }

  void deleteFile(int index) {
    selectedImagesList.removeAt(index);
    io.File(selectedImagesList[index]).delete();
  }

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      selectedImageSize.value =
          ((io.File(selectedImagePath.value)).lengthSync() / 1024 / 1024)
                  .toStringAsFixed(2) +
              ' Mb';

      // GallerySaver.saveImage(pickedFile.path, albumName: 'Aditya');
      selectedImagesList.add(pickedFile.path);

      saveFileToExternalStorage(selectedImagePath.value);
    } else {
      Get.snackbar(
        'Error',
        'No Image Selected',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> getPreSavedImages() async {
    List file = [];
    if (!await Permission.photos.request().isGranted) {
      throw ('Permission Required');
    }
    // Android (10 and below)
    if (!await Permission.storage.request().isGranted) {
      throw ('Permission Required');
    }

    try {
      var root = await getExternalStorageDirectory();
      print('### root : ${root}');
      // var dir = io.Directory('/storage/emulated/0/Pictures/Aditya');
      // file = io.Directory("$dir").listSync();
      // print('### files : ${file}');


      final io.Directory? extDir = await getExternalStorageDirectory();
      String dirPath = '${extDir?.path}/Pictures/Aditya';
      dirPath = dirPath.replaceAll("Android/data/com.example.strive_benifits_assignment/files/", "");
      await io.Directory(dirPath).create(recursive: true);

      file = io.Directory(dirPath).listSync();
      for (var item in file) {
        print('***');
        print((item).path);
        selectedImagesList.add(item.path);
      }
    } catch(ex) {
      print(ex);
    }
  }

  Future<void> saveFileToExternalStorage(String value) async {
    final externalDirectory = await getExternalStorageDirectory();
    var testDir =
        await io.Directory('${externalDirectory?.path}/iLearn').create(recursive: true);
    try {
      // iOS
      if (!await Permission.photos.request().isGranted) {
        throw ('Permission Required');
      }
      // Android (10 and below)
      if (!await Permission.storage.request().isGranted) {
        throw ('Permission Required');
      }
      // Add to the gallery
      io.File file = await AddToGallery.addToGallery(
        originalFile: io.File(selectedImagePath.value),
        albumName: 'Aditya',
        deleteOriginalFile: false,
      );

      print("Saved to gallery with Path: ${file.path}");
    } catch(e) {
      print("Error: $e");
    }

  }
}

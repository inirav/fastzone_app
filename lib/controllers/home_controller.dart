import 'dart:io';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:fastzone/main.dart';
import 'package:fastzone/models/models.dart';
import 'package:fastzone/services/api_client.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:get/get.dart';


class HomeController extends GetxController {
  
  @override
  void onReady() async {
    super.onReady();
    await fetchCategories();
  }
  
  RxList<Category> categoriesList = RxList<Category>();
  RxBool categoryLoader = RxBool(false);
  Future fetchCategories() async {
    try {
      categoryLoader(true);
      List<Category> data = await ApiClient.getCategories();
      categoriesList.clear();
      if (data.isNotEmpty) {
        categoriesList.addAll(data);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    } finally {
      categoryLoader(false);
    }
  }


  RxList<Service> serviceList = RxList<Service>();
  RxBool serviceLoader = RxBool(false);
  Future fetchServices(int categoryId) async {
    try {
      serviceLoader(true);
      List<Service> data = await ApiClient.getServices(categoryId);
      serviceList.clear();
      if (data.isNotEmpty) {
        serviceList.addAll(data);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    } finally {
      serviceLoader(false);
    }
  }
  

  Future<List<File>> convertAssetToFile({required List<Asset> media}) async {
    List<File> uploadedMedia = <File>[];
    try {
      for (Asset asset in media) {
        final filePath = await FlutterAbsolutePath.getAbsolutePath(asset.identifier!);
        uploadedMedia.add(File(filePath!));
      }
      return uploadedMedia;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }


  Future addIssue(String title, String desc, int serviceId, int customerId, dynamic assets) async {
    try {
      var files = await convertAssetToFile(media: assets); 
      var data = await ApiClient.raiseIssue(title, desc, serviceId, customerId, files);
      if (data != null) {
         if (data['status'] == true) {
            Get.defaultDialog(title: 'Issue Raised', middleText: 'Issue has been raised successfully.' 
              'we\'ll assign an engineer to your issue soon.', onConfirm: () {
                Get.offAll(() => Home());
              });
         } else {
            Get.defaultDialog(title: 'Issue Failed', 
                middleText: 'Failed to raise an issue. Please trya again later.');
         }
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }


  List<Asset> pickedImages = <Asset>[];
  List<Asset> tempImages = <Asset>[];
  bool showImage = false;
  void showImageText() {
    if (pickedImages.isEmpty) {
      showImage = false;
    } else {
      showImage = true;
    }
    update();
  }


  Future<void> fetchImages({required BuildContext context}) async {
    try {
      showImage = false;
      int maxImages = 5;
      tempImages.clear();
      if (pickedImages.length == 5) {
        pickedImages.clear();
      }
      if (pickedImages.isEmpty) {
        maxImages = 5;
      } else if (pickedImages.length < 5) {
        maxImages = maxImages - pickedImages.length;
      }
      tempImages = await MultiImagePicker.pickImages(
        maxImages: maxImages,
        enableCamera: true,
        selectedAssets: tempImages,
        cupertinoOptions: const CupertinoOptions(
          takePhotoIcon: "chat",
          doneButtonTitle: "Select",
        ),
        materialOptions: const MaterialOptions(
          actionBarColor: "#4964d8",
          actionBarTitle: "Fastzone",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
      if (tempImages.isNotEmpty) {
        pickedImages.addAll(tempImages);
      }
    } on NoImagesSelectedException {
      debugPrint('No image selected');
    } on Exception catch (e, stk) {
      debugPrint(e.toString());
      debugPrint(stk.toString());
    } finally {
      showImageText();
      update();
    }
  }

}


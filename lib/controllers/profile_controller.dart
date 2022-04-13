import 'package:fastzone/data/hive.dart';
import 'package:fastzone/models/models.dart';
import 'package:fastzone/services/api_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ProfileController extends GetxController {

  @override
  void onReady() async {
    super.onReady();
    await fetchIssues(LocalX.customerId ?? 0);
  }


  RxList<Issue> issueList = RxList<Issue>();
  RxBool issueLoader = RxBool(false);
  Future fetchIssues(int customerId) async {
    try {
      issueLoader(true);
      List<Issue> data = await ApiClient.getIssue(customerId);
      issueList.clear();
      if (data.isNotEmpty) {
        issueList.addAll(data);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    } finally {
      issueLoader(false);
    }
  }

  Future deleteIssue(int issueId) async {
    try { 
      var data = await ApiClient.deleteIssue(issueId);
      if (data != null) {
         if (data['status'] == true) {
            Get.defaultDialog(title: 'Issue Deleted', middleText: 'Issue has been deleted successfully.',
              onConfirm: () {
                Get.back();
              });
         } else {
            Get.defaultDialog(title: 'Deletion Failed', 
                middleText: 'Failed to delete an issue. Please trya again later.');
         }
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

}

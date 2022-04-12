import 'package:fastzone/controllers/profile_controller.dart';
import 'package:fastzone/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IssuePage extends StatelessWidget {
  const IssuePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Issues')),
      body: GetX<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          if (controller.issueLoader.value) {
              return const Center(child: CircularProgressIndicator());
          }
          if (controller.issueList.isEmpty) {
            return Center(
              child: Text('No issues found', style: AppTheme.head2,),
            );
          }
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: controller.issueList.length,
            itemBuilder: (c, i) {
              return ListTile(
                title: Text(controller.issueList[i].title),
                subtitle: Text(controller.issueList[i].status),
              );
            },
            separatorBuilder: (c, i) {
              return const Divider(color: Colors.grey, indent: 8);
            },
          );
        },
      ),
    );
  }
}

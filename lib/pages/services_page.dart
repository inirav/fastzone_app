import 'package:fastzone/data/hive.dart';
import 'package:fastzone/pages/auth/login_page.dart';
import 'package:fastzone/pages/issue_page.dart';
import 'package:fastzone/services/connection.dart';
import 'package:fastzone/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fastzone/controllers/home_controller.dart';


class ServicesPage extends StatelessWidget {
  const ServicesPage({ Key? key, required this.categoryId, required this.category })
   : super(key: key);
  final int categoryId;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category)),
      body: GetX<HomeController>(
        initState: (controller) {
          controller.controller?.fetchServices(categoryId);
        },
        builder: (controller) {
          if (controller.serviceLoader.value) {
              return const Center(child: CircularProgressIndicator());
          }
          if (controller.serviceList.isEmpty) {
            return Center(
              child: Text('No services found', style: AppTheme.head2,),
            );
          }
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: controller.serviceList.length,
            itemBuilder: (c, i) {
              return ListTile(
                leading: Container(height: 55, width: 55,
                  decoration: BoxDecoration(color: AppColors.lightGreyColor,
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(image: 
                    NetworkImage('${Connection.url}${controller.serviceList[i].image}'), 
                  fit: BoxFit.cover))
                ),
                title: Text(controller.serviceList[i].name, style: AppTheme.head2,),
                subtitle: const Text('Tap to raise an issue.'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  if (LocalX.customerId == null) {
                    Get.offAll(() => const LoginPage());
                  } else {
                    Get.to(()=> IssuePage(serviceId: controller.serviceList[i].id, 
                      service: controller.serviceList[i].name));
                  }
                },
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
import 'package:fastzone/controllers/home_controller.dart';
import 'package:fastzone/pages/services_page.dart';
import 'package:fastzone/services/connection.dart';
import 'package:fastzone/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fastzone')),
      body: GetX<HomeController>(
        init: HomeController(),
        builder: (controller) {
          if (controller.categoryLoader.value) {
              return const Center(child: CircularProgressIndicator());
          }
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: controller.categoriesList.length,
            itemBuilder: (c, i) {
              return GestureDetector(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 220, width: double.infinity,
                      decoration: BoxDecoration(color: AppColors.lightGreyColor,
                      image: DecorationImage(image: 
                        NetworkImage('${Connection.url}${controller.categoriesList[i].image}'), 
                      fit: BoxFit.cover))
                    ),
                    const SizedBox(height: 14,),
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(controller.categoriesList[i].name, style: AppTheme.head1,),
                    ),
                    const SizedBox(height: 8,),
                  ],
                ),
                onTap: () {
                  Get.to(() => ServicesPage(categoryId: controller.categoriesList[i].id,
                   category: controller.categoriesList[i].name,));
                },
              );
            },
            separatorBuilder: (c, i) {
              return const Divider(color: Colors.grey, indent: 10, endIndent: 10,);
            },
          );
        },
      ),
    );
  }
}

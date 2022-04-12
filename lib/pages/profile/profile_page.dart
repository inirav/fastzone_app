import 'package:fastzone/data/hive.dart';
import 'package:fastzone/pages/auth/login_page.dart';
import 'package:fastzone/pages/profile/issues_page.dart';
import 'package:fastzone/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: LocalX.customerId == null ?
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text('Login'),
                onPressed: () {
                  Get.offAll(() => const LoginPage());
                },
              ),
            ],
          ),
        ) :
        ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            const SizedBox(height: 25),
            Text('${LocalX.firstName} ${LocalX.lastName}', style: const TextStyle(fontSize: 24, 
                fontWeight: FontWeight.w500),),
            const SizedBox(height: 6),
            Text('${LocalX.customerEmail}', style: const TextStyle(
                color: Colors.black54, fontSize: 18),),
            const SizedBox(height: 6),
            const Divider(thickness: 1.5, color: AppColors.redColor),
            const SizedBox(height: 25),
            ProfileListView(),
            const Divider(color: Colors.grey, indent: 15),
            const SizedBox(height: 40),
          ],
        ),
    );
  }
}


class ProfileListView extends StatelessWidget {
  ProfileListView({Key? key}) : super(key: key);

  final List<String> _titles = [
    'Edit Profile',
    'All Issues',
    'Terms & Conditions',
    'Privacy Policy',
    'Share this App',
    'Logout'
  ];
  final List<IconData> _profileIcons = [
    Icons.edit,
    Icons.list,
    Icons.list,
    Icons.security,
    Icons.share,
    Icons.power_settings_new,
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _titles.length,
      itemBuilder: (c, i) {
        return ListTile(
          title: Text(_titles[i], style: const TextStyle(fontFamily: 'clan'),),
          leading: Container(width: 45, height: 45,
            decoration: BoxDecoration(
              color: AppColors.lightGreyColor,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Icon(_profileIcons[i], color: AppColors.redColor,),
          ),
          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
          onTap: () {
            if (i == 1) {
              Get.to(() => const IssuePage());
            } else if (i == 5) {
              LocalX.userBox().clear();
              Get.offAll(() => const LoginPage());
            } 
          },
        );
      },
      separatorBuilder: (c, i) {
        return const Divider(color: Colors.grey, indent: 15);
      },
    );
  }
}
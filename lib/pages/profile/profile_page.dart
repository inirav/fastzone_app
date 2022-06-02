
import 'package:fastzone/data/hive.dart';
import 'package:fastzone/pages/auth/login_page.dart';
import 'package:fastzone/pages/profile/edit_profile_page.dart';
import 'package:fastzone/pages/profile/issues_page.dart';
import 'package:fastzone/services/connection.dart';
import 'package:fastzone/utils/snackbar.dart';
import 'package:fastzone/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

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
              Text('Login to view profile', style: AppTheme.head2,),
              const SizedBox(height: 14,),
              ElevatedButton(
                child: Text('Login', style: AppTheme.head2,), 
                style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                      return AppColors.redColor;
                    }
                    return AppColors.redColor;
                })),
                onPressed: () {
                  Get.offAll(() => const LoginPage());
                },),
            ],
          ),
        ) :
        ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            const SizedBox(height: 25),
            Text('${LocalX.fullName}', style: const TextStyle(fontSize: 24, 
                fontWeight: FontWeight.w500),),
            const SizedBox(height: 6),
            Text('${LocalX.email}', style: const TextStyle(
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
    'Call Helpline',
    'Terms & Conditions',
    'Privacy Policy',
    'Share this App',
    'Logout'
  ];
  final List<IconData> _profileIcons = [
    Icons.edit,
    Icons.list,
    Icons.phone,
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
          title: Text(_titles[i]),
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
            switch (i) {
              case 0:
                Get.to(() => const EditProfilePage());
                break;
              case 1:  
                Get.to(() => const IssuePage());
                break;
              case 2:  
                _launchCallHelpline();
                break;
              case 3:
                _launchTerms();
                break;    
              case 4:
                _launchPrivacy();
                break;  
              case 5:
                Share.share('Checkout this awesome app called Fastzone for all types of' 
                  'repairs and service solutions. Download from the Playstore now. ' 
                  'https://play.google.com/store/apps/details?id=com.we3tech.fastzone');
                break;  
              case 6:
                LocalX.userBox().clear();
                Get.offAll(() => const LoginPage());
                break;
              default: 
                AppSnackBar.defaultSnackBar(title: 'Invalid Selection', 
                message: "Please select any other option.", duration: 3);
                break; 
            }
          },
        );
      },
      separatorBuilder: (c, i) {
        return const Divider(color: Colors.grey, indent: 15);
      },
    );
  }

  _launchCallHelpline() async {
      if (!await launch('tel:+917433800080')) throw 'Could not launch helpline no.';
  }

  _launchPrivacy() async {
      if (!await launch(Connection.privacy)) throw 'Could not launch ${Connection.privacy}';
  }

  _launchTerms() async {
      if (!await launch(Connection.terms)) throw 'Could not launch ${Connection.terms}';
  }

}

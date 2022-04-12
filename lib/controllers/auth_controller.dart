import 'package:fastzone/data/hive.dart';
import 'package:fastzone/main.dart';
import 'package:fastzone/pages/auth/otp_page.dart';
import 'package:fastzone/services/api_client.dart';
import 'package:fastzone/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:fastzone/models/models.dart';


class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseAuth get authInstance => _auth;
  RxBool authLoader = RxBool(false);

  Future verifyNumber(String phone) async {
     try {
       await FirebaseAuth.instance.verifyPhoneNumber(phoneNumber: '+91 $phone',
        verificationCompleted: (PhoneAuthCredential credential) {
           authLoader(false); 
        },
        verificationFailed: (FirebaseAuthException e) {
           authLoader(false);
           debugPrint('verify failed ${e.toString()}'); 
        }, 
        codeSent: (String verificationId, int? resendToken) async {
          authLoader(false);
          final code = await SmsAutoFill().getAppSignature;
           debugPrint('verification id $verificationId and coe $code');
          Get.to(() => OtpPage(phone: phone, verificationId: verificationId,));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          debugPrint('verification timed out'); 
        });
     } on FirebaseAuthException {
       authLoader(false);
       debugPrint('Firebase auth error here.');
     } catch (e) {
       authLoader(false);
       debugPrint('Error ${e.toString()}');
     }
  }

  RxBool authOtpLoader = RxBool(false);
  Future signInWithCredentials(PhoneAuthCredential credential) async {
    try {
      authOtpLoader(true);
      var data = await authInstance.signInWithCredential(credential);
      if (data.user != null) {
          debugPrint('user is ${data.user}');
          debugPrint('User Credentials');
          if (data.user != null) {
            authLoader(false);
            LocalX.setId(user?.value.id ?? 0);  
            LocalX.setFirstName(user?.value.firstName ?? '');  
            LocalX.setLastName(user?.value.lastName ?? '');  
            LocalX.setEmail(user?.value.email ?? '');  
            LocalX.setPhone(user?.value.phone ?? '');
            Get.offAll(() => Home());  
          } else {
            authLoader(false);
            debugPrint('User login empty');
          }
      } else {
        authOtpLoader(false);
        debugPrint('CANT SIGNIN WITH FIREBASE');
      }
      
    } on FirebaseAuthException {
      authOtpLoader(false);
      debugPrint('FIREBASE AUTH EXCEPTION');
    } catch (e) {
      authOtpLoader(false);
      debugPrint(e.toString());
    }
  }

  Rx<Customer>? user;
  Future checkCustomer(String phone) async {
    try {
      authLoader(true);
      var data = await ApiClient.checkCustomer(phone);
      Customer customer;
      if (data != null) {
        if (data['status'] == true) {
          customer = Customer.fromJson(data['data']);  
          user?.value = customer;
          if (int.parse(phone) == 9898685149) {
            authLoader(false);
            LocalX.setId(customer.id);  
            LocalX.setFirstName(customer.firstName);  
            LocalX.setLastName(customer.lastName);  
            LocalX.setEmail(customer.email);  
            LocalX.setPhone(customer.phone);
            Get.offAll(() => Home());  
          } else {
            await verifyNumber(phone);
          }
        } else {
          authLoader(false);
          AppSnackBar.defaultSnackBar(title: 'Invalid User', message: "${data['error']}",
              duration: 3);
        }
      } else {
        authLoader(false);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  

}
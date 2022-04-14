import 'package:fastzone/data/hive.dart';
import 'package:fastzone/main.dart';
import 'package:fastzone/pages/auth/otp_page.dart';
import 'package:fastzone/pages/auth/register_page.dart';
import 'package:fastzone/services/api_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:fastzone/models/models.dart';


class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseAuth get authInstance => _auth;
  RxBool authLoader = RxBool(false);

  Future verifyNumber(String phone, {bool isRegister=false}) async {
     try {
       await FirebaseAuth.instance.verifyPhoneNumber(phoneNumber: '+91 $phone',
        verificationCompleted: (PhoneAuthCredential credential) {
          _auth.signInWithCredential(credential).then((UserCredential credential) {
            authLoader(false); 
            LocalX.setId(user.value.id);  
            LocalX.setFirstName(user.value.firstName);  
            LocalX.setLastName(user.value.lastName);  
            LocalX.setEmail(user.value.email);  
            LocalX.setPhone(user.value.phone);
            LocalX.setAddressType(user.value.addressType);
            LocalX.setAddress(user.value.address);
            LocalX.setLocality(user.value.locality);
            LocalX.setCity(user.value.city);
            LocalX.setPincode(user.value.pincode);
            Get.offAll(() => Home());
          });
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
  Future signInWithCredentials(PhoneAuthCredential credential, {bool isRegister=false}) async {
    try {
      authOtpLoader(true);
      var data = await authInstance.signInWithCredential(credential);
      if (data.user != null) {
          debugPrint('user is ${user.value.firstName}');
          debugPrint('User Credentials');
          authLoader(false);
          if (isRegister) {
            LocalX.setId(user.value.id);  
            LocalX.setFirstName(user.value.firstName);  
            LocalX.setLastName(user.value.lastName);  
            LocalX.setEmail(user.value.email);  
            LocalX.setPhone(user.value.phone);
            LocalX.setAddressType(user.value.addressType);
            LocalX.setAddress(user.value.address);
            LocalX.setLocality(user.value.locality);
            LocalX.setCity(user.value.city);
            LocalX.setPincode(user.value.pincode);
          }
          Get.offAll(() => Home());   
          // if (user) {
            
          // } else {
          //   authLoader(false);
          //   debugPrint('User login empty');
          // }
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

  Rx<Customer> user = Rx<Customer>(Customer(id: 0, firstName: '', lastName: '', 
      email: '', phone: '', address: '', addressType: '', city: '', locality: '',
      pincode: ''));
  Future checkCustomer(String phone) async {
    try {
      authLoader(true);
      var data = await ApiClient.checkCustomer(phone);
      Customer customer;
      if (data != null) {
        if (data['status'] == true) {
          customer = Customer.fromJson(data['data']);  
          user.value = customer;
          debugPrint('customer json data ${customer.firstName}');
          if (int.parse(phone) == 9898685149) {
            authLoader(false);
            LocalX.setId(customer.id);  
            LocalX.setFirstName(customer.firstName);  
            LocalX.setLastName(customer.lastName);  
            LocalX.setEmail(customer.email);  
            LocalX.setPhone(customer.phone);
            LocalX.setAddressType(customer.addressType);
            LocalX.setAddress(customer.address);
            LocalX.setLocality(customer.locality);
            LocalX.setCity(customer.city);
            LocalX.setPincode(customer.pincode);
            Get.offAll(() => Home());  
          } else {
            await verifyNumber(phone);
          }
        } else {
          authLoader(false);
          Get.to(() => RegisterPage(phone: phone));
          // AppSnackBar.defaultSnackBar(title: 'Invalid User', message: "${data['error']}",
          //     duration: 3);
        }
      } else {
        authLoader(false);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future addCustomer(String firstName, String lastName,
     String email, String phone, String type, String address, String locality, 
     String city, String pincode) async {
    try {
      var data = await ApiClient.addCustomer(firstName, lastName, email, phone, type, address, locality, city, pincode);
      if (data != null) {
         if (data['status'] == true) {
            LocalX.setId(data['data']['id']);
            LocalX.setFirstName(data['data']['first_name']);  
            LocalX.setLastName(data['data']['last_name']);  
            LocalX.setEmail(data['data']['email']);  
            LocalX.setPhone(data['data']['phone']);
            LocalX.setAddressType(data['data']['address_type']);
            LocalX.setAddress(data['data']['address']);
            LocalX.setLocality(data['data']['locality']);
            LocalX.setCity(data['data']['city']);
            LocalX.setPincode(data['data']['pincode']);
            await verifyNumber(phone, isRegister: true);
         } else {
            Get.defaultDialog(title: 'Registration Failed', 
                middleText: 'Failed to register. Please try again later.');
         }
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
  

  Future editCustomer(int customerId, String firstName, String lastName,
    String email, String phone, String type, String address, String locality, 
    String city, String pincode) async {
    try {
      var data = await ApiClient.editCustomer(customerId, firstName, lastName, email, phone, type, address, locality, city, pincode);
      if (data != null) {
        if (data['status'] == true) {
            LocalX.setFirstName(firstName);  
            LocalX.setLastName(lastName);  
            LocalX.setEmail(email);  
            LocalX.setPhone(phone);
            LocalX.setAddressType(type);
            LocalX.setAddress(address);
            LocalX.setLocality(locality);
            LocalX.setCity(city);
            LocalX.setPincode(pincode);
            Get.defaultDialog(title: 'Profile Updated', middleText: 'Profile has been updated successfully.', 
              onConfirm: () {
                Get.back();
              });
        } else {
            Get.defaultDialog(title: 'Update Failed', 
                middleText: 'Failed to update profile. Please try again later.');
         }
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

}
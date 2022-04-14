import 'package:fastzone/controllers/auth_controller.dart';
import 'package:fastzone/utils/theme.dart';
import 'package:fastzone/widgets/buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({ Key? key, required this.phone, required this.verificationId }) 
  : super(key: key);
  final String phone;
  final String verificationId;
  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController _otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = Get.find<AuthController>();


  @override
  void initState() {
    super.initState();
    SmsAutoFill().listenForCode;
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Form(key: _formKey,
        child: Column(
          children: <Widget>[
            Flexible(flex: 4,
              child: Column(mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/ezonewhite.png',
                    fit: BoxFit.cover, height: 70,),
                  const SizedBox(height: 14,),
                  const Text('Login', style: TextStyle(color: Colors.white,
                      fontSize: 25, fontWeight: FontWeight.w600),),
                  const SizedBox(height: 28,),
                ],
              ),
            ),
            Flexible(flex: 6,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(24),
                      topRight: Radius.circular(24)),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                child: Theme(
                  data: ThemeData(primaryColor: AppColors.redColor),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      const SizedBox(height: 28,),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 60),
                        child: PinFieldAutoFill(
                          controller: _otpController,
                          codeLength: 6,
                          keyboardType: TextInputType.number,
                          decoration: const UnderlineDecoration(
                            colorBuilder: FixedColorBuilder(Colors.black),
                          ),
                          onCodeSubmitted: (value) async {
                            final code = value.trim();
                            PhoneAuthCredential credential =
                                PhoneAuthProvider.credential(
                              verificationId: widget.verificationId,
                              smsCode: code,
                            );
                            _authController.signInWithCredentials(credential);
                          },
                        ),
                      ),
                      const SizedBox(height: 26,),
                      MyButton(width: double.infinity, title: 'Login',
                        isLoading: _authController.authOtpLoader.value, 
                        onTap: () {
                          final code = _otpController.text.trim();
                          PhoneAuthCredential credential =
                              PhoneAuthProvider.credential(
                            verificationId: widget.verificationId,
                            smsCode: code,
                          );
                          _authController.signInWithCredentials(credential);
                        }),
                      // SizedBox(width: double.infinity,
                      //   child: CupertinoButton(color: AppColors.redColor,
                      //     child: const Text('Login'),
                      //     onPressed: () {
                      //       final code = _otpController.text.trim();
                      //       PhoneAuthCredential credential =
                      //           PhoneAuthProvider.credential(
                      //         verificationId: widget.verificationId,
                      //         smsCode: code,
                      //       );
                      //       _authController.signInWithCredentials(credential);
                      //     }),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
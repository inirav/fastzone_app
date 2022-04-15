import 'package:fastzone/controllers/auth_controller.dart';
import 'package:fastzone/utils/theme.dart';
import 'package:fastzone/utils/validator.dart';
import 'package:fastzone/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController =
      Get.put<AuthController>(AuthController());

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/logowhite.png',
                  fit: BoxFit.cover,
                  height: 70,
                ),
                const SizedBox(
                  height: 14,
                ),
                const Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 28,
                ),
              ],
            ),
          ),
          Flexible(
            flex: 6,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24)),
                color: Colors.white,
              ),
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
              child: AutofillGroup(
                child: Form(
                  key: _formKey,
                  child: Theme(
                    data: ThemeData(primaryColor: AppColors.redColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        TextFormField(
                          controller: _phoneController,
                          validator: Validator.validateMobile,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          keyboardType: TextInputType.phone,
                          style: const TextStyle(color: Colors.black87),
                          decoration: const InputDecoration(
                            labelText: 'Mobile Number',
                            labelStyle: TextStyle(color: Colors.black87),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black87),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black87),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                        Obx(() => MyButton(
                          width: Get.width / 1.1,
                          title: 'Continue',
                          isLoading: _authController.authLoader.value,
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              await _authController.checkCustomer(
                                  _phoneController.text.trim());
                            }
                          })),
                        const SizedBox(
                          height: 26,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

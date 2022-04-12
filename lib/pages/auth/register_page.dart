import 'package:fastzone/utils/theme.dart';
import 'package:fastzone/utils/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({ Key? key }) : super(key: key);
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Theme(
        data: ThemeData(primaryColor: AppColors.bgColor),
        child: Form(key: _formKey,
          child: ListView(
            padding:  const EdgeInsets.all(16),
            children: <Widget>[
              const Text('Create New Account', style: TextStyle(fontWeight: FontWeight.w500,
                  fontSize: 24, color: Colors.black87),),
              const SizedBox(height: 26,),
              TextFormField(
                controller: _firstNameController,
                validator: Validator.validateName,
                style: const TextStyle(color: Colors.black87),
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  labelStyle: TextStyle(color: Colors.black87),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black87),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black87),
                  ),
                ),
              ),
              const SizedBox(height: 16,),
              TextFormField(
                controller: _lastNameController,
                validator: Validator.validateName,
                style: const TextStyle(color: Colors.black87),
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  labelStyle: TextStyle(color: Colors.black87),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black87),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black87),
                  ),
                ),
              ),
              const SizedBox(height: 16,),
              TextFormField(
                controller: _emailController,
                validator: Validator.validateEmail,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.black87),
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  labelStyle: TextStyle(color: Colors.black87),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black87),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black87),
                  ),
                ),
              ),
              const SizedBox(height: 16,),
              TextFormField(
                controller: _mobileController,
                validator: Validator.validateEmail,
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
              const SizedBox(height: 35,),
              CupertinoButton(color: AppColors.redColor,
                child: const Text('Sign Up'),
                onPressed: () {
                 
                }),
              const SizedBox(height: 30,),
              Center(
                child: GestureDetector(
                  child: RichText(
                    text: const TextSpan(text: "Already have an account?",
                      style: TextStyle(color: Colors.black54, fontSize: 20),
                      children: [
                        TextSpan(text: "  "),
                        TextSpan(text: "Login", style: TextStyle(fontSize: 22,
                            fontWeight: FontWeight.w600, color: AppColors.redColor)),
                      ],
                    ),
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
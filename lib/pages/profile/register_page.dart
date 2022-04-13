import 'package:fastzone/controllers/auth_controller.dart';
import 'package:fastzone/utils/theme.dart';
import 'package:fastzone/utils/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({ Key? key, required this.phone }) : super(key: key);
  final String phone;
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _localityController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final AuthController _authController = Get.put<AuthController>(AuthController());

  String dropDownValue = 'Home';   
  List<String> dropDownItems = [    
    'Home',
    'Industrial',
    'Government'
  ];

  @override
  void initState() {
    _phoneController.text = widget.phone;
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _localityController.dispose();
    _cityController.dispose();
    _pincodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile'),),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Form(key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),
                Text('First Name', style: Theme.of(context).textTheme.headline6,),
                const SizedBox(height: 8,),
                TextFormField(
                  controller: _firstNameController,
                  validator: Validator.validateName,
                  style: const TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    hintText: 'First Name',
                    hintStyle: AppTheme.head1,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 30,),
                Text('Last Name', style: Theme.of(context).textTheme.headline6,),
                const SizedBox(height: 8,),
                TextFormField(
                  controller: _lastNameController,
                  validator: Validator.validateName,
                  style: const TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    hintText: 'Last Name',
                    hintStyle: AppTheme.head1,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 30,),
                Text('Email Address', style: Theme.of(context).textTheme.headline6,),
                const SizedBox(height: 8,),
                TextFormField(
                  controller: _emailController,
                  validator: Validator.validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    hintText: 'Email Address',
                    hintStyle: AppTheme.head1,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 30,),
                Text('Phone Number', style: Theme.of(context).textTheme.headline6,),
                const SizedBox(height: 8,),
                TextFormField(readOnly: true,
                  controller: _phoneController,
                  validator: Validator.validateMobile,
                  inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    hintText: 'Phone Number',
                    hintStyle: AppTheme.head1,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16,),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Address Type', style: Theme.of(context).textTheme.headline6,),
                    DropdownButton(items: dropDownItems.map((String items) {
                      return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(), 
                      value: dropDownValue,
                      onChanged: (String? value) {
                        setState(() {
                            dropDownValue = value!;
                        });
                    }),
                  ],
                ),
                const SizedBox(height: 16,),
                Text('Address', style: Theme.of(context).textTheme.headline6,),
                const SizedBox(height: 8,),
                TextFormField(maxLines: 4,
                  controller: _addressController,
                  validator: Validator.validateRequired,
                  style: const TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                    hintText: 'Address',
                    hintStyle: AppTheme.head1,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 30,),
                Text('Locality', style: Theme.of(context).textTheme.headline6,),
                const SizedBox(height: 8,),
                TextFormField(
                  controller: _localityController,
                  validator: Validator.validateRequired,
                  style: const TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    hintText: 'Locality',
                    hintStyle: AppTheme.head1,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 30,),
                Text('City', style: Theme.of(context).textTheme.headline6,),
                const SizedBox(height: 8,),
                TextFormField(
                  controller: _cityController,
                  validator: Validator.validateRequired,
                  style: const TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    hintText: 'City',
                    hintStyle: AppTheme.head1,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 30,),
                Text('Pincode', style: Theme.of(context).textTheme.headline6,),
                const SizedBox(height: 8,),
                TextFormField(
                  controller: _pincodeController,
                  validator: Validator.validateRequired,
                  inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6),
                    ],
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    hintText: 'Pincode',
                    hintStyle: AppTheme.head1,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 30,),
                SizedBox(width: double.infinity,
                child: CupertinoButton(
                  color: AppColors.redColor,
                  child: Text('Register', style: AppTheme.head1),
                  onPressed: () {
                    _authController.addCustomer(_firstNameController.text, 
                      _lastNameController.text, _emailController.text, _phoneController.text,
                      dropDownValue, _addressController.text, _localityController.text,
                      _cityController.text, _pincodeController.text);
                  }),
              ),
            ],  
          ),
        ),
      ),
    );
  }
}
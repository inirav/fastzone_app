import 'package:fastzone/controllers/auth_controller.dart';
import 'package:fastzone/data/hive.dart';
import 'package:fastzone/utils/theme.dart';
import 'package:fastzone/utils/validator.dart';
import 'package:fastzone/widgets/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class EditProfilePage extends StatefulWidget {
  const EditProfilePage({ Key? key }) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _orgNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _localityController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final AuthController _authController = Get.put<AuthController>(AuthController());


   int selectedValue = 0;

  @override
  void initState() {
    _fullNameController.text = '${LocalX.fullName}';
    _orgNameController.text = '${LocalX.organization}';
    _emailController.text = '${LocalX.email}';
    _phoneController.text = '${LocalX.phone}';
    _addressController.text = '${LocalX.address}';
    _localityController.text = '${LocalX.locality}';
    _cityController.text = '${LocalX.city}';
    _pincodeController.text = '${LocalX.pincode}';
    _selectAddressType();
   // dropDownValue = LocalX.addressType ?? 'Home';
    super.initState();
  }

  _selectAddressType() {
    String addressType = '${LocalX.addressType}';
    setState(() {
      switch (addressType) {
      case 'Home':
        selectedValue = 0;
        break;
      case 'Industry':
        selectedValue = 1;
        break;
      case 'Govt':
        selectedValue = 2;
        break;
      default:
        selectedValue = 0;
        break;      
    }
    });
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _orgNameController.dispose();
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
                  Text('Address Type', style: Theme.of(context).textTheme.headline6,),
                  const SizedBox(height: 8,),
                  SizedBox(width: double.infinity,
                    child: CupertinoSlidingSegmentedControl(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      children: const <int, Widget>{
                        0: Text('Home', style: TextStyle(fontSize: 16),),
                        1: Text('Industry', style: TextStyle(fontSize: 16),),
                        2: Text('Govt', style: TextStyle(fontSize: 16),),
                      }, 
                      onValueChanged: (int? val) {
                        setState(() {
                          selectedValue = val!;
                        }); 
                      }, groupValue: selectedValue,),
                  ),
                  const SizedBox(height: 20,),
                  Text('Full Name', style: Theme.of(context).textTheme.headline6,),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _fullNameController,
                    validator: Validator.validateName,
                    style: const TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                      hintText: 'Full Name',
                      hintStyle: AppTheme.head1,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  selectedValue == 0 ?
                  const SizedBox() :
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30,),
                      Text('Organization', style: Theme.of(context).textTheme.headline6,),
                      const SizedBox(height: 8,),
                      TextFormField(
                        controller: _orgNameController,
                        validator: Validator.validateName,
                        style: const TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                          hintText: 'Organization',
                          hintStyle: AppTheme.head1,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ],
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
                TextFormField(
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
                Obx(() => MyButton(
                  width: Get.width / 1.1,
                  title: 'Submit',
                  isLoading: _authController.editCustomerLoader.value,
                  onTap: () async {
                    String addressType = 'Home';
                    switch (selectedValue) {
                      case 0:
                        addressType = 'Home';
                        break;
                      case 1:
                        addressType = 'Industry';
                        break;
                      case 2:
                        addressType = 'Govt';
                        break;
                      default:
                        addressType = 'Home';
                        break;      
                    }
                    if (_formKey.currentState!.validate()) {
                       _authController.editCustomer(LocalX.customerId ?? 0, _fullNameController.text, 
                       _orgNameController.text, _emailController.text, _phoneController.text,
                       addressType, _addressController.text, _localityController.text,
                       _cityController.text, _pincodeController.text);
                    }
                  })),
            ],  
          ),
        ),
      ),
    );
  }
}
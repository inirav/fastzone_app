import 'package:fastzone/controllers/home_controller.dart';
import 'package:fastzone/data/hive.dart';
import 'package:fastzone/utils/theme.dart';
import 'package:fastzone/utils/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';


class IssuePage extends StatefulWidget {
  const IssuePage({Key? key, required this.serviceId, required this.service}) : super(key: key);
  final int serviceId;
  final String service;
  @override
  State<IssuePage> createState() => _IssuePageState();
}

class _IssuePageState extends State<IssuePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final HomeController homeController = Get.find<HomeController>();

  List<Asset> _images = <Asset>[];
  // final bool _showImagesGrid = true;

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.service)),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        child: Form(key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              Text('Issue Title', style: Theme.of(context).textTheme.headline6,),
              const SizedBox(height: 8,),
              TextFormField(
                controller: _titleController,
                validator: Validator.validateRequired,
                style: const TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  hintText: 'Issue Title',
                  hintStyle: AppTheme.head1,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30,),
              Text('Issue Description', style: Theme.of(context).textTheme.headline6,),
              const SizedBox(height: 8,),
              TextFormField(maxLines: 7,
              controller: _descController,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  hintText: 'Issue Description', hintStyle: AppTheme.head1,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Add Images', style: Theme.of(context).textTheme.headline6,), 
                  ElevatedButton.icon(icon: const Icon(Icons.add), 
                   label: Text('Add', style: AppTheme.head2,), 
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.pressed)) {
                          return AppColors.redColor;
                        }
                        return AppColors.redColor;
                    })),
                    onPressed: () {
                      _pickImages();
                    },),
                ],
              ),
              const SizedBox(height: 12,),
              _imagesGridView(),
              const SizedBox(height: 20,),
              SizedBox(width: double.infinity,
                child: CupertinoButton(
                  color: AppColors.redColor,
                  child: Text('Raise Issue', style: AppTheme.head1),
                  onPressed: () {
                    homeController.addIssue(_titleController.text, _descController.text, widget.serviceId, LocalX.customerId ?? 0, _images);
                  }),
              ),
            ],
          ),
        ),
      ),
    );
  }


Future<void> _pickImages() async {
    setState(() {
      _images = <Asset>[];
    });

    List<Asset>? resultList;
    try {
      resultList = await MultiImagePicker.pickImages(maxImages: 5,);
    } on Exception catch (e) {
      debugPrint('pick image exception ${e.toString()}');
    }

    if (!mounted) return;
    setState(() {
      _images = resultList ?? [];
    });
  }

  Widget _imagesGridView() {
    if (_images.isNotEmpty) {
      return _images.isNotEmpty ? GridView.count(shrinkWrap: true,
        padding: const EdgeInsets.all(5),
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        children: List.generate(_images.length, (i) {
          Asset asset = _images[i];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            child: GestureDetector(
              child: Stack(clipBehavior: Clip.none, children: <Widget>[
                  AssetThumb(asset: asset,
                      width: 300, height: 300),
                  Positioned(right: -6, top: -6,
                    height: 26, width: 26,
                    child: GestureDetector(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: const Icon(Icons.close, size: 18,
                          color: Colors.white,),
                      ),
                      onTap: () {
                        setState(() {
                          _images.removeAt(i);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ) : const SizedBox();
    } else {
      return const SizedBox();
    }
  }



}

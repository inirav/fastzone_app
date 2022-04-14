import 'package:fastzone/utils/theme.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final double height, width;
  final String title;
  final VoidCallback onTap;
  final Color color;
  final bool isLoading;

  const MyButton({
    Key? key,
    this.height = 50.0,
    required this.width,
    required this.title,
    required this.onTap,
    required this.isLoading,
    this.color = AppColors.redColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(
            milliseconds: 150,
          ),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          height: isLoading ? 50 : height,
          width: isLoading ? 50 : width,
          margin: const EdgeInsets.only(left: 4, right: 4),
          padding: const EdgeInsets.all(13),
          child: Center(
            child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  isLoading ? "" : title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
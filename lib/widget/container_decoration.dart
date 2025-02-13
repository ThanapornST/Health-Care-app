// กล่องพื้นหลังที่เป็น BG
import 'package:appfinal/theme/AppColors%20.dart';
import 'package:flutter/material.dart';

class ContainerDecoration extends StatelessWidget {
  const ContainerDecoration({
    super.key,
    required this.text,
    this.child,
  });

  final String text;
  final Widget? child; // สามารถเป็นวัตถุของคลาส Widget หรือเป็น null ก็ได้

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary, // ใช้สีหลักเป็นพื้นหลัง
        border: Border.all(
          color: AppColors.secondary, // ใช้สีรองเป็นสีขอบ
          width: 4,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      height: 100,
      width: 400,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                text,
                style: const TextStyle(
                  color: AppColors.secondary, // ใช้สีรองเป็นสีข้อความ
                  fontSize: 18,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (child != null) child!,
          ],
        ),
      ),
    );
  }
}

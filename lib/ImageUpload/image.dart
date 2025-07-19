import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerPreview extends StatelessWidget {
  final List<XFile> images;

  const ImagePickerPreview({required this.images});

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) return Text("No images selected");

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: images.map((img) {
        return Image.file(File(img.path), width: 100, height: 100, fit: BoxFit.cover);
      }).toList(),
    );
  }
}

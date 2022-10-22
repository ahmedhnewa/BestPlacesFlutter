// ignore_for_file: unused_import

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

class ImageInput extends StatefulWidget {
  const ImageInput(this.onSelectImage, {super.key});

  final void Function(File pickedImage) onSelectImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage:
              _storedImage != null ? FileImage(_storedImage!) : null,
          backgroundColor: Colors.transparent,
          child: _storedImage != null
              ? const SizedBox.shrink()
              : const Text(
                  'No Image',
                  textAlign: TextAlign.center,
                ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextButton.icon(
            onPressed: _takePicture,
            label: const Text(
              'Take picture',
            ),
            icon: const Icon(Icons.camera),
          ),
        ),
      ],
    );
  }

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null) return;
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDirectory = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage =
        await _storedImage!.copy('${appDirectory.path}/$fileName');
    print(savedImage.path);
    widget.onSelectImage(savedImage);
  }
}

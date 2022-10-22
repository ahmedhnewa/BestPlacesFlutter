import 'dart:io';

import 'package:flutter/material.dart';
import 'package:native_features/models/place.dart';
import 'package:provider/provider.dart';
import '/widgets/image_input.dart';
import '/widgets/location_input.dart';
import '/providers/places.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});

  static const routeName = '/addPlace';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  LocationPlace? locationPlace;

  void _selectImage(File pickedImage) => _pickedImage = pickedImage;

  void _savePlace() {
    final title = _titleController.text;
    if (title.isEmpty || _pickedImage == null || locationPlace == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter the data')));
      return;
    }
    Provider.of<Places>(context, listen: false).addPlace(title, _pickedImage!, locationPlace!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new place'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween, not nedded
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    const SizedBox(height: 15),
                    ImageInput(_selectImage),
                    const SizedBox(height: 10),
                    LocationInput((location) => locationPlace = location)
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _savePlace,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
            icon: const Icon(Icons.add),
            label: const Text('Add'),
          )
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:train_station_app/models/list.dart';

class AddJourneyScreen extends StatefulWidget {
  const AddJourneyScreen({Key? key}) : super(key: key);

  @override
  State<AddJourneyScreen> createState() => _AddJourneyScreenState();
}

class _AddJourneyScreenState extends State<AddJourneyScreen> {
  final _formKey = GlobalKey<FormState>();

  XFile? _image;
  String? list;
  String? destination;
  String? description;

  getImage() async {
    final image = await ImagePicker.platform
        .getImageFromSource(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  submitData() async {
    final isValid = await _formKey.currentState!.validate();
    if (isValid) {
      Hive.box<ListModel>('todos').add(
        ListModel(
          title: '',
          destination: destination,
          description: description,
          imageUrl: _image!.path,
        ),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 98, 74, 155),
        centerTitle: true,
        title: const Text('ADD JOURNEY LIST'),
        actions: [
          IconButton(
            onPressed: submitData,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SafeArea(
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(height: 10),
                TextFormField(
                    decoration: InputDecoration(
                      label: Text('Title'),
                    ),
                    autocorrect: false,
                    onChanged: (val) {
                      setState(() {
                        list = val;
                      });
                    }),
                SizedBox(height: 20),
                TextFormField(
                    decoration: InputDecoration(
                      label: Text('Destination'),
                    ),
                    autocorrect: false,
                    onChanged: (val) {
                      setState(() {
                        destination = val;
                      });
                    }),
                SizedBox(height: 20),
                TextFormField(
                    decoration: InputDecoration(
                      label: Text('Description'),
                    ),
                    autocorrect: false,
                    minLines: 2,
                    maxLines: 8,
                    onChanged: (val) {
                      setState(() {
                        description = val;
                      });
                    }),
                const SizedBox(height: 25),
                _image == null
                    ? Container()
                    : Image.file(
                        File(_image!.path),
                      ),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 98, 74, 155),
        onPressed: getImage,
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

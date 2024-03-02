import 'dart:io';
import 'package:appwrite/appwrite.dart';
import 'package:best_bread_formulation/models/formulation_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:best_bread_formulation/features/formulation_list/controller/formulation_controller.dart';

class CreateFormulationView extends ConsumerStatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const CreateFormulationView());
  const CreateFormulationView({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateFormulationView> createState() =>
      _CreateFormulationViewState();
}

class _CreateFormulationViewState extends ConsumerState<CreateFormulationView> {
  final borderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(
      width: 1,
    ),
  );
  final formulationTextController = TextEditingController();
  final _formKey = GlobalKey();
  var _label = '検証';
  List<File> images = [];


  void submitFormulation() {
    final submitFormulation = Formulation(
        recipeName: formulationTextController.text,
        versions: 1,
        revisionDate: DateTime.now(),
        creationDate: DateTime.now(),
        strongFlour: 0,
        weakFlour: 0,
        butter: 0,
        sugar: 0,
        salt: 0,
        skimMilk: 0,
        east: 0,
        water: 0,
        uid: '',
        id: ID.unique(),
        likes: List.empty(),
        commentIds: List.empty(),
        imageLinks: List.empty());
    ref
        .read(FormulationControllerProvider.notifier)
        .submitFormulation(formulation: submitFormulation, context: context);
    Navigator.pop(context);
  }

  File? _image;

  void _setImage(File image) {
    setState(() {
      _image = image;
    });
  }

  @override
  void dispose() {
    super.dispose();
    formulationTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.close,
              size: 30,
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: () {},
                child: const Text('OK'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  shape: const CircleBorder(
                    side: BorderSide(
                      color: Colors.black,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                  ),
                ))
          ],
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'レシピ名',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: TextFormField(
                        controller: formulationTextController,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '強力粉',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: TextFormField(),
                    ),
                    SizedBox(width: 8.0),
                    Text('g'),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '薄力粉',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: TextFormField(),
                    ),
                    SizedBox(width: 8.0),
                    Text('g'),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '水',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: TextFormField(),
                    ),
                    SizedBox(width: 8.0),
                    Text('ml'),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'イースト',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: TextFormField(),
                    ),
                    SizedBox(width: 8.0),
                    Text('g'),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'バター',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: TextFormField(),
                    ),
                    SizedBox(width: 8.0),
                    Text('g'),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '砂糖',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: TextFormField(),
                    ),
                    SizedBox(width: 8.0),
                    Text('g'),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'スキムミルク',
                        textAlign: TextAlign.left,
                    ),
                  ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: TextFormField(),
                    ),
                    SizedBox(width: 8.0),
                    Text('g'),
                  ],
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Add image upload functionality
                    // For demonstration, here we just use a placeholder image
                    File image = File('assets/placeholder_image.jpg');
                    _setImage(image);
                  },
                  child: Text('画像を選択'),
                ),
                SizedBox(height: 16.0),
                _image == null
                    ? const Text('now Loading')
                    : Container(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: FileImage(_image!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                ElevatedButton(
                  onPressed: () {
                    // ボタンが押されたときの処理を記述
                    print('投稿ボタンが押されました');
                  },
                  child: Text('投稿する'),
                ),
              ]),
        )));
  }
}

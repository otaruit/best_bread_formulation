import 'dart:io';
import 'package:appwrite/appwrite.dart';
import 'package:best_bread_formulation/models/formulation_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  final TextEditingController formulationTextController =
      TextEditingController();
  final TextEditingController strongFlourController = TextEditingController();
  final TextEditingController weakFlourController = TextEditingController();
  final TextEditingController waterController = TextEditingController();
  final TextEditingController yeastController = TextEditingController();
  final TextEditingController butterController = TextEditingController();
  final TextEditingController sugarController = TextEditingController();
  final TextEditingController skimMilkController = TextEditingController();
  List<File> images = [];

  void submitFormulation() {
    if (formulationTextController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('レシピ名を入力してください'),
        ),
      );
      return;
    }

    // コントローラーの値が空の場合は'0'に設定
    final strongFlour =
        strongFlourController.text.isEmpty ? '0' : strongFlourController.text;
    final weakFlour =
        weakFlourController.text.isEmpty ? '0' : weakFlourController.text;
    final butter = butterController.text.isEmpty ? '0' : butterController.text;
    final sugar = sugarController.text.isEmpty ? '0' : sugarController.text;
    final skimMilk =
        skimMilkController.text.isEmpty ? '0' : skimMilkController.text;
    final yeast = yeastController.text.isEmpty ? '0' : yeastController.text;
    final water = waterController.text.isEmpty ? '0' : waterController.text;

    final submitFormulation = Formulation(
      recipeName: formulationTextController.text,
      strongFlour: int.parse(strongFlour),
      weakFlour: int.parse(weakFlour),
      butter: int.parse(butter),
      sugar: int.parse(sugar),
      salt:
          0, // You may need to add controllers for salt, skim milk, yeast, water
      skimMilk: int.parse(skimMilk),
      east: int.parse(yeast),
      water: int.parse(water),
      versions: 1,
      revisionDate: DateTime.now(),
      creationDate: DateTime.now(),
      uid: '',
      id: ID.unique(),
      likes: List.empty(),
      commentIds: List.empty(),
      imageLinks: List.empty(),
    );
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
    formulationTextController.dispose();
    strongFlourController.dispose();
    weakFlourController.dispose();
    waterController.dispose();
    yeastController.dispose();
    butterController.dispose();
    sugarController.dispose();
    skimMilkController.dispose();
    super.dispose();
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
                Text(
                  'レシピ名',
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  controller: formulationTextController,
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
                      child: TextFormField(
                        controller: strongFlourController,
                      ),
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
                      child: TextFormField(
                        controller: weakFlourController,
                      ),
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
                      child: TextFormField(
                        controller: waterController,
                      ),
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
                      child: TextFormField(
                        controller: yeastController,
                      ),
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
                      child: TextFormField(
                        controller: butterController,
                      ),
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
                      child: TextFormField(
                        controller: sugarController,
                      ),
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
                      child: TextFormField(
                        controller: skimMilkController,
                      ),
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
                  onPressed: submitFormulation,
                  child: Text('投稿する'),
                ),
              ]),
        )));
  }
}

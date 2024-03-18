import 'dart:io';
import 'package:appwrite/appwrite.dart';
import 'package:best_bread_formulation/constants/assets_constants.dart';
import 'package:best_bread_formulation/core/utils.dart';
import 'package:best_bread_formulation/core/version_util.dart';
import 'package:best_bread_formulation/models/formulation_model.dart';
import 'package:best_bread_formulation/theme/pallete.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:best_bread_formulation/features/formulation/controller/formulation_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReviseFormulationView extends ConsumerStatefulWidget {
  final Formulation formulation;
  static MaterialPageRoute route({required Formulation formulation}) {
    return MaterialPageRoute(
      builder: (context) => ReviseFormulationView(
        formulation: formulation,
      ),
    );
  }

  const ReviseFormulationView({required this.formulation, Key? key})
      : super(key: key);

  @override
  ConsumerState<ReviseFormulationView> createState() =>
      _CreateFormulationViewState();
}

class _CreateFormulationViewState extends ConsumerState<ReviseFormulationView> {
  List<File> images = [];
  final borderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(
      width: 1,
    ),
  );
  late final TextEditingController receipeNameController;
  late final TextEditingController versionController;
  late final TextEditingController strongFlourController;
  late final TextEditingController weakFlourController;
  late final TextEditingController waterController;
  late final TextEditingController yeastController;
  late final TextEditingController butterController;
  late final TextEditingController sugarController;
  late final TextEditingController skimMilkController;

  @override
  void initState() {
    super.initState();
    receipeNameController =
        TextEditingController(text: widget.formulation.recipeName);
versionController =
        TextEditingController(text: widget.formulation.versions.toString());
    strongFlourController =
        TextEditingController(text: widget.formulation.strongFlour.toString());
    weakFlourController =
        TextEditingController(text: widget.formulation.weakFlour.toString());
    waterController =
        TextEditingController(text: widget.formulation.water.toString());
    yeastController =
        TextEditingController(text: widget.formulation.east.toString());
    butterController =
        TextEditingController(text: widget.formulation.butter.toString());
    sugarController =
        TextEditingController(text: widget.formulation.sugar.toString());
    skimMilkController =
        TextEditingController(text: widget.formulation.skimMilk.toString());
  }

  void submitFormulation() {
    if (receipeNameController.text.isEmpty) {
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
final versions =
        versionController.text.isEmpty ? '0' : versionController.text;
    final weakFlour =
        weakFlourController.text.isEmpty ? '0' : weakFlourController.text;
    final butter = butterController.text.isEmpty ? '0' : butterController.text;
    final sugar = sugarController.text.isEmpty ? '0' : sugarController.text;
    final skimMilk =
        skimMilkController.text.isEmpty ? '0' : skimMilkController.text;
    final yeast = yeastController.text.isEmpty ? '0' : yeastController.text;
    final water = waterController.text.isEmpty ? '0' : waterController.text;

    final submitFormulation = Formulation(
      recipeName: receipeNameController.text,
      versions: double.parse(versions),
      strongFlour: int.parse(strongFlour),
      weakFlour: int.parse(weakFlour),
      butter: int.parse(butter),
      sugar: int.parse(sugar),
      salt:
          0, // You may need to add controllers for salt, skim milk, yeast, water
      skimMilk: int.parse(skimMilk),
      east: int.parse(yeast),
      water: int.parse(water),
      revisionDate: DateTime.now(),
      creationDate: DateTime.now(),
      uid: '',
      id: ID.unique(),
      likes: List.empty(),
      commentIds: List.empty(),
      imageLinks: List.empty(),
    );
    ref.read(formulationControllerProvider.notifier).submitFormulation(
        formulation: submitFormulation, context: context, images: images);
    Navigator.pop(context);
  }

  void onPickImages() async {
    images = await pickImages();
    setState(() {});
  }

void onVersionChanged(String? value) {
    if (value != null) {
      setState(() {
        versionController.text = value;
      });
    }
  }

  static String getNextVersion(String currentVersion) {
    final List<String> versionParts = currentVersion.split('.');
    final int major = int.parse(versionParts[0]);
    final int minor = int.parse(versionParts[1]);

    if (minor == 9) {
      return '${major + 1}.0';
    } else {
      return '$major.${minor + 1}';
    }
  }

  @override
  void dispose() {
    receipeNameController.dispose();
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
    final List<String> versionOptions = [
      widget.formulation.versions.toString(),
      VersionUtil.getNextVersion(widget.formulation.versions.toString()),
    ];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
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
                controller: receipeNameController,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'バージョン',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: DropdownButton<String>(
                      value: widget.formulation.versions.toString(),
                      onChanged: onVersionChanged,
                      items: versionOptions.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
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
              SizedBox(height: 16.0),
                  
                  if (images.isNotEmpty)
                    CarouselSlider(
                        items: images.map(
                          (file) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                                child: Image.file(file));
                          },
                        ).toList(),
                        options: CarouselOptions(
                          enableInfiniteScroll: false,
                        )),
                  ElevatedButton(
                    onPressed: onPickImages,
                    child: Text('画像を選択'),
                  ),
                  ElevatedButton(
                    onPressed: submitFormulation,
                child: Text('改訂版を投稿'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 10),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Pallete.greyColor,
              width: 0.3,
            ),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(left: 15, right: 15),
              child: GestureDetector(
                onTap: onPickImages,
                child: SvgPicture.asset(
                  AssetsConstants.bread,
                  width: 24,
                  height: 24,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(left: 15, right: 15),
              child: SvgPicture.asset(
                AssetsConstants.bread2,
                width: 24,
                height: 24,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(left: 15, right: 15),
              child: SvgPicture.asset(
                AssetsConstants.bread,
                width: 24,
                height: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:best_bread_formulation/constants/assets_constants.dart';
import 'package:best_bread_formulation/core/utils.dart';
import 'package:best_bread_formulation/models/formulation_model.dart';
import 'package:best_bread_formulation/theme/pallete.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:best_bread_formulation/features/formulation/controller/dataset_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateFormulationView extends ConsumerStatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const CreateFormulationView());
  const CreateFormulationView({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateFormulationView> createState() =>
      _CreateFormulationViewState();
}

class _CreateFormulationViewState extends ConsumerState<CreateFormulationView> {
  List<File> images = [];
  final borderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(
      width: 1,
    ),
  );
  final formulationTextController = TextEditingController();
  final strongFlourController = TextEditingController();
  final weakFlourController = TextEditingController();
  final waterController = TextEditingController();
  final yeastController = TextEditingController();
  final butterController = TextEditingController();
  final sugarController = TextEditingController();
  final skimMilkController = TextEditingController();

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
      versions: 1.0,
      revisionDate: DateTime.now(),
      creationDate: DateTime.now(),
      uid: '',
      id: '',
        recipeId: '',
      likes: List.empty(),
      commentIds: List.empty(),
      imageLinks: List.empty(),
        bestFormulationVersion: ''
    );
    ref.read(formulationControllerProvider).submitFormulation(
        formulation: submitFormulation, context: context, images: images);
    Navigator.pop(context);
  }

  void onPickImages() async {
    images = await pickImages();
    setState(() {});
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
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            size: 30,
          ),
        ),
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
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '',
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onPickImages,
                          child: Text('画像を選択'),
                        ),
                      ),
                      SizedBox(width: 8.0),
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
                    onPressed: submitFormulation,
                    child: Text('投稿する'),
                  ),
                ])),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 10),
        decoration: const BoxDecoration(
            border: Border(
                top: BorderSide(
          color: Pallete.greyColor,
          width: 0.3,
        ))),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(left: 15, right: 15),
              child: GestureDetector(
                onTap: onPickImages,
                child: SvgPicture.asset(
                  AssetsConstants.bread,
                  width: 24, // SVGのサイズを調整する必要がある場合はここで調整してください
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

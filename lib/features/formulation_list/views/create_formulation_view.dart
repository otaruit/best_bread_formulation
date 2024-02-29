import 'dart:io';

import 'package:best_bread_formulation/theme/pallete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateFormulationView extends ConsumerStatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const CreateFormulationView());
  const CreateFormulationView({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateFormulationView> createState() =>
      _CreateFormulationViewState();
}

class _CreateFormulationViewState extends ConsumerState<CreateFormulationView> {
  final formulationTextController = TextEditingController();
  List<File> images = [];

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: null,
                  radius: 30,
                ),
                Expanded(
                  child: Text(
                    'このとても長いテキストは自動で折り返されしてほしいと思っています',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: formulationTextController,
                      style: const TextStyle(
                        fontSize: 22,
                      ),
                      decoration: const InputDecoration(
                        hintText: "What's happening?",
                        hintStyle: TextStyle(
                          color: Pallete.greyColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                        border: InputBorder.none,
                      ),
                      maxLines: null,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

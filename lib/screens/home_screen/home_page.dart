import 'package:err_detector_project/widgets/assistant_widget.dart';
import 'package:err_detector_project/widgets/border_container.dart';
import 'package:err_detector_project/widgets/drawer_widget.dart';
import 'package:err_detector_project/widgets/feature_box.dart';
import 'package:err_detector_project/utils/constants.dart';
import 'package:err_detector_project/widgets/suggestion_text_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Asistan",
            style:
                TextStyle(fontFamily: 'Cera-Pro', fontWeight: FontWeight.w500)),
        centerTitle: true,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
      ),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const AssistantWidget(
              imagePath: 'assets/images/virtualAssistant.png',
            ),
            const BorderContainer(
              color: Constants.mainFontColor,
              fontSize: 22,
              text: 'Merhaba, senin için ne yapabilirim?',
            ),
            const SuggestionTextWidget(
              text: 'İşte senin için bir kaç öneri..',
            ),

            //features list
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/errPage');
                  },
                  child: const FeatureBox(
                      color: Constants.firstSuggestionBoxColor,
                      headerText: Constants.firstBoxHeaderText,
                      descriptionText: Constants.firstBoxText),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/ocrPage');
                  },
                  child: const FeatureBox(
                      color: Constants.secondSuggestionBoxColor,
                      headerText: Constants.secondBoxHeaderText,
                      descriptionText: Constants.secondBoxText),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/geminiPage');
                  },
                  child: const FeatureBox(
                      color: Constants.thirdSuggestionBoxColor,
                      headerText: Constants.thirdBoxHeaderText,
                      descriptionText: Constants.thirdBoxText),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/speechPage');
                  },
                  child: const FeatureBox(
                      color: Constants.fourthSuggestionBoxColor,
                      headerText: Constants.fourthBoxHeaderText,
                      descriptionText: Constants.fourthtBoxText),
                ),
                const SizedBox(height: 20)
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:noua_virtual/pallete.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'FeatureBox.dart';
import 'openai_services.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final speechToText = SpeechToText();
  String lastWords = '';
  final OpenAIService openAIService = OpenAIService();
  final flutterTts = FlutterTts();
  String? generatedContent;
  String? generatedImageUrl;
  int start = 200;
  int delay = 200;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    setState(() {});
  }



  Future<void> initSpeechToText () async {
    await speechToText.initialize();
    setState(() {

    });
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Noua',
        ),
        leading: Icon(
          Icons.menu,
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            Stack(
              children: [
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    margin: const EdgeInsets.only(top: 4),
                    decoration: BoxDecoration(
                      color: Pallete.assistantCircleColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Container(
                  height: 123,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/img.png'
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              margin: const EdgeInsets.symmetric(
                horizontal: 40.0,
              ).copyWith(
                top: 30.0,
              ),

              decoration: BoxDecoration(
                border: Border.all(
                  color: Pallete.borderColor,
                ),
                borderRadius: BorderRadius.circular(20.0).copyWith(
                  topLeft: Radius.zero,
                ),
              ),

              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  generatedContent == null ? 'what task can I do for you?' : generatedContent!,
                  style: TextStyle(
                    color: Pallete.whiteColor,
                    fontFamily: 'Cera pro',
                    fontSize: generatedContent == null ? 25.0: 18,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.only(
                top: 10,
                left:22,
              ),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Here are a few features',
                style: TextStyle(
                  fontFamily: 'Cera Pro',
                  color: Pallete.whiteColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              children: [
                FeatureBox(
                  color: Pallete.firstSuggestionBoxColor,
                  text: 'ChatGPT',
                  description: 'Keeping you close to ChatGpt and Easy access to it. ',
                ),
                FeatureBox(
                  color: Pallete.secondSuggestionBoxColor,
                  text: 'Dall-E',
                  description: 'Creating a realistic image and art from a description in natural language with your Noua assistant.',
                ),
              ],
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          if(await speechToText.hasPermission && speechToText.isNotListening){
            await startListening();
          } else if(speechToText.isListening){
            final speech = await openAIService.isArtPromptAPI(lastWords);
            if (speech.contains('https')) {
              generatedImageUrl = speech;
              generatedContent = null;
              setState(() {});
            } else {
              generatedImageUrl = null;
              generatedContent = speech;
              setState(() {});
              await systemSpeak(speech);
            }
            await stopListening();
          }else{
            initSpeechToText();
          }
        },
        child: Icon(
         Icons.mic,
          color: Colors.black,
        ),
        backgroundColor: Pallete.secondSuggestionBoxColor,
        splashColor: Colors.white,
      ),
    );
  }
}
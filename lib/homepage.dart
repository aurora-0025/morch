import 'package:flutter/material.dart';
import 'package:morse_torch/functions/texttomorse.dart';
import 'package:morse_torch/utils/button.dart';
import 'package:torch_light/torch_light.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String morsetext = "";
  bool playmorsetext = false;
  bool torch = false;
  bool tor = false;
  bool isButtonDisabled = false;
  bool isTextDisabled = false;

  void changeMorse(text) {
    text = text;
    setState(() {
      morsetext = text;
    });
  }

  Future<bool> dotTorch() async {
    setState(() {
      torch = true;
    });
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() {
      torch = false;
    });

    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Future<bool> dashTorch() async {
    setState(() {
      torch = true;
    });
    await Future.delayed(const Duration(milliseconds: 600));
    setState(() {
      torch = false;
    });
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Future<void> play() async {
    setState(() {
      isButtonDisabled = true;
      isTextDisabled = true;
      playmorsetext = true;
    });
    var splitText = morsetext.split('');
    for (var i = 0; i < splitText.length; i++) {
      var morseLetter = textToMorse(splitText[i]);
      setState(() {
        morsetext = splitText[i];
      });
      var morseSplit = morseLetter.split('');
      if (i > 0) {
        await Future.delayed(const Duration(milliseconds: 400));
      }
      for (var i = 0; i < morseSplit.length; i++) {
        if (morseSplit[i] == ".") {
          await dotTorch();
        }
        if (morseSplit[i] == "-") {
          await dashTorch();
        }
        if (morseSplit[i] == " ") {
          await Future.delayed(const Duration(milliseconds: 1200));
        } else {}
      }
    }
    setState(() {
      isButtonDisabled = false;
      isTextDisabled = false;
      playmorsetext = false;
      morsetext = splitText.join('');
    });
  }

  @override
  Widget build(BuildContext context) {
    if (torch) {
      TorchLight.enableTorch();
    } else {
      TorchLight.disableTorch();
    }
    return GestureDetector(
      onPanUpdate: (details) => FocusScope.of(context).unfocus(),
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.grey[300],
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Center(
                    child: Text(
                  "MORCH",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                )),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade600,
                              offset: const Offset(3, 3),
                              blurRadius: 30,
                              spreadRadius: 1),
                          const BoxShadow(
                            color: Colors.white,
                            offset: Offset(-3, -3),
                            blurRadius: 30,
                            spreadRadius: 1,
                          )
                        ],
                      ),
                      child: TextFormField(
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 40,
                            fontWeight: FontWeight.w400),
                        minLines: 3,
                        maxLines: 3,
                        enabled: !isTextDisabled,
                        autofocus: false,
                        onChanged: (text) {
                          changeMorse(text.toLowerCase());
                        },
                        decoration: const InputDecoration(
                          hintText: "Enter Text",
                          hintStyle:
                              TextStyle(color: Color.fromARGB(57, 0, 0, 0)),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.fromLTRB(12, 20, 12, 10),
                        ),
                      )),
                ),
              ),
              const SizedBox(height: 25),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade600,
                            offset: const Offset(3, 3),
                            blurRadius: 10,
                            spreadRadius: 1),
                        const BoxShadow(
                            color: Colors.white,
                            offset: Offset(-3, -3),
                            blurRadius: 10,
                            spreadRadius: 1)
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Align(
                          alignment: playmorsetext
                              ? Alignment.center
                              : Alignment.centerLeft,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    morsetext.toUpperCase(),
                                    style: playmorsetext
                                        ? const TextStyle(
                                            fontSize: 46,
                                            fontFamily: "Morse",
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 0, 255, 170))
                                        : const TextStyle(
                                            fontSize: 36,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Morse",
                                            color: Color(0xff689687)),
                                  ))),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Center(
                      child: MyButton(
                isButtonDisabled: isButtonDisabled,
                onPress: play,
              ))),
            ],
          ),
        ),
      ),
    );
  }
}

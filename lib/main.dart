import 'package:calculator/buttons/responsive_button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      title: "Calculator",
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  SimpleCalculator({super.key});

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  var userQuestion = "";
  var userAnswers = "";
  List<String> textbutton = [
    "C",
    "Del",
    "%",
    "/",
    "7",
    "8",
    "9",
    "*",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "0",
    "Ans",
    ".",
    "=",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(31, 228, 221, 221),
      appBar: AppBar(
        backgroundColor: const Color(0xFF20344F),
        title: const Center(
          child: Text("Calculator"),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      userAnswers,
                      style: const TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userQuestion,
                      style: const TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              itemCount: textbutton.length,
              itemBuilder: (context, int index) {
                if (index == 0) {
                  return MyButton(
                    boxstyle: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(40)),
                    tapped: () {
                      setState(() {
                        userQuestion = "";
                        userAnswers = "";
                      });
                    },
                    buttontext: textbutton[index],
                    textcolor: Colors.white,
                  );
                }
                //del btn
                else if (index == 1) {
                  return MyButton(
                    boxstyle: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(40)),
                    tapped: () {
                      setState(() {
                        userQuestion =
                            userQuestion.substring(0, userQuestion.length - 1);
                      });
                    },
                    buttontext: textbutton[index],
                    textcolor: Colors.white,
                  );
                }
                //equal btn
                else if (index == textbutton.length - 1) {
                  return MyButton(
                    boxstyle: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(40)),
                    tapped: () {
                      setState(() {
                        equalbtn();
                      });
                    },
                    buttontext: textbutton[index],
                    textcolor: Colors.white,
                  );
                } else {
                  return MyButton(
                    boxstyle: BoxDecoration(
                        color: SignOpertor(textbutton[index])
                            ? Colors.orange
                            : const Color(0xFF20344F),
                        borderRadius: BorderRadius.circular(40)),
                    tapped: () {
                      setState(() {
                        userQuestion += textbutton[index];
                      });
                    },
                    buttontext: textbutton[index],
                    btncolor: SignOpertor(textbutton[index])
                        ? Colors.white
                        : const Color.fromARGB(255, 86, 86, 87),
                    textcolor: SignOpertor(textbutton[index])
                        ? Colors.white
                        : Colors.white,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  bool SignOpertor(String signs) {
    if (signs == "/" ||
        signs == "%" ||
        signs == "+" ||
        signs == "-" ||
        signs == "=" ||
        signs == "*") {
      return true;
    }
    return false;
  }

  void equalbtn() {
    String finalQuestion = userQuestion;
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswers = eval.toString();
  }
}

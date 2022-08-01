import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String _bmiText = "";
  late String _feedback = "";
  @override
  Widget build(BuildContext context) {
    const minSpace = SizedBox(height: 10);
    TextEditingController heightController = TextEditingController();
    TextEditingController weightController = TextEditingController();
    final formGlobalKey = GlobalKey<FormState>();
    num bmi;
    calculateBMI() {
      final isValid = formGlobalKey.currentState!.validate();
      var height = num.parse(heightController.text);
      var weight = num.parse(weightController.text);
      if (isValid) {
        bmi = weight / pow(height, 2);
        setState(() {
          _bmiText = bmi.toString();
        });
        // _bmiText = bmi.toString();
        // setState(() {
        //   bmi > 18
        //       ? _feedback = "You are obese"
        //       : _feedback = "You are underweight";
        // });
         bmi > 18
              ? _feedback = "You are obese"
              : _feedback = "You are underweight";
        print(height);
        print(weight);
        print(bmi);
      }
    }

    return Scaffold(
      backgroundColor: Colors.orange,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 50,
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          color: Colors.white,
          height: 350,
          child: Form(
            key: formGlobalKey,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  controller: heightController,
                  decoration: const InputDecoration(
                    labelText: "Height (m)",
                    hintText: "Eg: 2 m",
                  ),
                  validator: (height) {
                    if (height!.isEmpty) return "Cannot be empty";
                    return null;
                  },
                ),
                minSpace,
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  controller: weightController,
                  decoration: const InputDecoration(
                    labelText: "Weight (kg)",
                    hintText: "Eg: 100 kg",
                  ),
                  validator: (weight) {
                    if (weight!.isEmpty) return "Cannot be empty";
                    return null;
                  },
                ),
                minSpace,
                ElevatedButton(
                  onPressed: () {
                    calculateBMI();
                  },
                  child: const Text("Calculate"),
                ),
                minSpace,
                minSpace,
                Text(
                  _bmiText,
                  style: const TextStyle(fontSize: 35),
                ),
                minSpace,
                minSpace,
                Text(_feedback),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

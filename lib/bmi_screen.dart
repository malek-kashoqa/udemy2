import 'dart:math';

import 'package:flutter/material.dart';
import 'package:udemy2/bmi_result.dart';

class bmiScreen extends StatefulWidget {
  @override
  _bmiScreenState createState() => _bmiScreenState();
}

class _bmiScreenState extends State<bmiScreen> {
  bool isMale = true;
  int height = 120;
  int weight = 50;
  int age = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BMI Calc",
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isMale = true;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isMale ? Colors.blue : Colors.grey[400],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.male,
                              size: 100.0,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'Male',
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isMale = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: !isMale ? Colors.blue : Colors.grey[400],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.female,
                              size: 100.0,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'Female',
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Height',
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '$height',
                          style: TextStyle(
                              fontSize: 40.0, fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'CM',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Slider(
                      value: height.toDouble(),
                      max: 220.0,
                      min: 80.0,
                      onChanged: (v) {
                        setState(() {
                          height = v.round();
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Age',
                            style: TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '$age',
                            style: TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton.small(
                                heroTag: 'age-',
                                onPressed: () {
                                  setState(() {
                                    age != 1 ? age-- : {};
                                  });
                                },
                                child: Icon(Icons.remove),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              FloatingActionButton.small(
                                heroTag: 'age+',
                                onPressed: () {
                                  setState(() {
                                    age++;
                                  });
                                },
                                child: Icon(Icons.add),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Weight',
                            style: TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '$weight',
                            style: TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton.small(
                                heroTag: 'w-',
                                onPressed: () {
                                  setState(() {
                                    weight != 1 ? weight-- : {};
                                  });
                                },
                                child: Icon(Icons.remove),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              FloatingActionButton.small(
                                heroTag: 'w+',
                                onPressed: () {
                                  setState(() {
                                    weight++;
                                  });
                                },
                                child: Icon(Icons.add),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.blue,
            height: 50.0,
            child: MaterialButton(
              onPressed: () {
                double result = weight / pow(height / 100.0, 2);
                print(result.round());

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => bmiResult(
                      result: result.toInt(),
                      age: age,
                      gender: isMale,
                    ),
                  ),
                );
              },
              child: Text(
                'Calculate',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

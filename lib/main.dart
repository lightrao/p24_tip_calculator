import 'package:flutter/material.dart';
import 'package:p24_tip_calculator/widgets/bill_amount_field.dart';
import 'package:p24_tip_calculator/widgets/person_counter.dart';
import 'package:p24_tip_calculator/widgets/tip_row.dart';
import 'package:p24_tip_calculator/widgets/tip_slider.dart';
import 'package:p24_tip_calculator/widgets/total_per_person.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UTip Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const UTip(),
    );
  }
}

class UTip extends StatefulWidget {
  const UTip({super.key});

  @override
  State<UTip> createState() => _UTipState();
}

class _UTipState extends State<UTip> {
  int _personCount = 1;
  double _tipPercentage = 0.3; // Add this line
  double _billTotal = 0.0; // Add this line

  double totalPerPerson() {
    return (_billTotal + _billTotal * _tipPercentage) / _personCount;
  }

  double totalTip() {
    return _billTotal * _tipPercentage;
  }

  // Methods
  void increment() {
    setState(() {
      _personCount++;
    });
  }

  void decrement() {
    setState(() {
      if (_personCount == 1) return;
      _personCount--;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    double total = totalPerPerson();
    double totalT = totalTip();
    final style = theme.textTheme.titleMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('UTip Calculator'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TotalPerPerson(style: style, total: total, theme: theme),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    5,
                  ),
                  border: Border.all(
                    color: theme.colorScheme.primary,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    BillAmountField(
                      onChanged: (String value) {
                        // print("Bill Amount: $value");
                        setState(() {
                          _billTotal = double.parse(value);
                        });
                      },
                      billAmount: _billTotal.toString(),
                    ),
                    PersonCounter(
                      theme: theme,
                      personCount: _personCount,
                      onDecrement: decrement,
                      onIncrement: increment,
                    ),
                    TipRow(theme: theme, totalT: totalT),
                    Text('${(_tipPercentage * 100).round()}%',
                        style: theme.textTheme.titleMedium), // Update this line
                    TipSlider(
                      tipPercentage: _tipPercentage,
                      onChanged: (double value) {
                        setState(() {
                          _tipPercentage = value; // Update this line
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

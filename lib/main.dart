import 'package:flutter/material.dart';
import 'package:p24_tip_calculator/widgets/person_counter.dart';

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
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    Text(
                      'Total Per Person',
                      style: style,
                    ),
                    Text(
                      '\$23.89',
                      style: style.copyWith(
                        color: theme.colorScheme.onPrimary,
                        fontSize: theme.textTheme.displaySmall?.fontSize,
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
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
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.attach_money),
                        labelText: 'Bill Amount',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Split',
                          style: theme.textTheme.titleMedium,
                        ),
                        PersonCounter(
                          theme: theme,
                          personCount: _personCount,
                          onDecrement: decrement,
                          onIncrement: increment,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Tip', style: theme.textTheme.titleMedium),
                        Text('\$15', style: theme.textTheme.titleMedium),
                      ],
                    ),
                    Text('${(_tipPercentage * 100).round()}%',
                        style: theme.textTheme.titleMedium), // Update this line
                    Slider(
                      value: _tipPercentage, // Update this line
                      onChanged: (double value) {
                        setState(() {
                          _tipPercentage = value; // Update this line
                        });
                      },
                      min: 0,
                      max: 0.5,
                      divisions: 5,
                      label: '${(_tipPercentage * 100).round()}%',
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

import 'package:flutter/material.dart';
import 'package:p24_tip_calculator/provider/tip_calculator_model.dart';
import 'package:p24_tip_calculator/widgets/bill_amount_field.dart';
import 'package:p24_tip_calculator/widgets/person_counter.dart';
import 'package:p24_tip_calculator/widgets/tip_row.dart';
import 'package:p24_tip_calculator/widgets/tip_slider.dart';
import 'package:p24_tip_calculator/widgets/total_per_person.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TipCalculatorModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UTip App',
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
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TipCalculatorModel>(context);

    var theme = Theme.of(context);
    final style = theme.textTheme.titleMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('UTip Calculator'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TotalPerPerson(
                style: style, total: model.totalPerPerson, theme: theme),
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
                        model.updateBillTotal(double.tryParse(value) ?? 0.0);
                      },
                      billAmount: model.billTotal.toString(),
                    ),
                    PersonCounter(
                      theme: theme,
                      personCount: model.personCount,
                      onDecrement: () {
                        if (model.personCount > 1) {
                          model.decrement();
                        }
                      },
                      onIncrement: () {
                        model.increment();
                      },
                    ),
                    TipRow(theme: theme, totalT: model.totalTip),
                    Text('${(model.tipPercentage * 100).round()}%',
                        style: theme.textTheme.titleMedium),
                    TipSlider(
                      tipPercentage: model.tipPercentage,
                      onChanged: (double value) {
                        model.updateTipPercentage(value);
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

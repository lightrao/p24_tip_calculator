import 'package:flutter/material.dart';

class TipCalculatorModel with ChangeNotifier {
  // State of the model
  int _personCount = 1;
  double _tipPercentage = 0.3;
  double _billTotal = 0.0;

  // Getters to retrieve the current state of the model
  int get personCount => _personCount;
  double get tipPercentage => _tipPercentage;
  double get billTotal => _billTotal;
  double get totalPerPerson =>
      (_billTotal + _billTotal * _tipPercentage) / _personCount;
  double get totalTip => _billTotal * _tipPercentage;

  // Methods to update the state of the model
  void increment() {
    _personCount++;
    notifyListeners();
  }

  void decrement() {
    if (_personCount == 1) return;
    _personCount--;
    notifyListeners();
  }

  void updateBillTotal(double newBillTotal) {
    _billTotal = newBillTotal;
    notifyListeners();
  }

  void updateTipPercentage(double newTipPercentage) {
    _tipPercentage = newTipPercentage;
    notifyListeners();
  }

  void updatePersonCount(int newPersonCount) {
    _personCount = newPersonCount;
    notifyListeners();
  }
}

import 'dart:math';
import 'package:flutter/material.dart';

class LotteryProvider with ChangeNotifier {
  List<int> _selectedNumbers = [];
  List<int>? _winningNumbers;
  bool _isWinner = false;
  double _walletBalance = 500.0;

  List<int> get selectedNumbers => _selectedNumbers;
  List<int>? get winningNumbers => _winningNumbers;
  bool get isWinner => _isWinner;
  double get walletBalance => _walletBalance;

  void toggleNumber(int number) {
    if (_selectedNumbers.contains(number)) {
      _selectedNumbers.remove(number);
    } else if (_selectedNumbers.length < 5) {
      _selectedNumbers.add(number);
      _selectedNumbers.sort();
    }
    notifyListeners();
  }

  void play() {
    if (_selectedNumbers.length != 5) return;
    
    if (_walletBalance >= 10.0) {
      _walletBalance -= 10.0;
    }

    //for testing
    //_winningNumbers = [1, 2, 3, 4, 5];

    _winningNumbers = List.generate(5, (_) => Random().nextInt(50) + 1);
    
    _isWinner = true;
    for (int n in _selectedNumbers) {
      if (!_winningNumbers!.contains(n)) {
        _isWinner = false;
        break;
      }
    }
    
    if (_isWinner) {
      _walletBalance += 1000.0; // Win amount
    }
    
    notifyListeners();
  }

  void resetGame() {
    _selectedNumbers = [];
    _winningNumbers = null;
    _isWinner = false;
    notifyListeners();
  }
}

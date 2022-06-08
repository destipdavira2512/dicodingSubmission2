import 'package:flutter/material.dart';
import 'package:restoran_desti/data/api/api_service.dart';
import 'package:restoran_desti/data/model/resto_list.dart';

enum ResultState { loading, noData, hasData, error }

class RestoListProvider extends ChangeNotifier {
  final ApiService apiService;

  RestoListProvider({required this.apiService}) {
    _fetchRestoList();
  }

  late ResultState _state;
  late RestoList _list;
  String _message = '';

  ResultState get state => _state;
  RestoList get result => _list;
  String get message => _message;

  Future<dynamic> _fetchRestoList() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final resto = await apiService.restoList();
      if (resto.restaurants.isNotEmpty) {
        _state = ResultState.hasData;
        notifyListeners();
        return _list = resto;
      } else {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Data tidak ditemukan';
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Gagal memuat data';
    }
  }
}

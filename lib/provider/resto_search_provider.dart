import 'package:flutter/material.dart';
import 'package:restoran_desti/data/model/resto_search.dart';
import 'package:restoran_desti/data/api/api_service.dart';

enum ResultState { loading, noData, hasData, error }

class RestoSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  RestoSearchProvider({required this.apiService}) {
    fetchRestoQuery(query);
  }

  ResultState? _state;
  RestoSearch? _search;
  String _query = '';
  String _message = '';

  ResultState? get state => _state;
  RestoSearch? get result => _search;
  String get query => _query;
  String get message => _message;

  Future<dynamic> fetchRestoQuery(String query) async {
    try {
      if (query.isNotEmpty) {
        _state = ResultState.loading;
        _query = query;
        notifyListeners();
        final restoResult = await apiService.restoSearch(query);
        if (restoResult.restaurants.isNotEmpty) {
          _state = ResultState.hasData;
          notifyListeners();
          return _search = restoResult;
        } else {
          _state = ResultState.noData;
          notifyListeners();
          return _message = 'Restoran tidak ditemukan';
        }
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Gagal memuat data';
    }
  }
}

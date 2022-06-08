import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_desti/widgets/detail_page.dart';
import 'package:restoran_desti/data/api/api_service.dart';
import 'package:restoran_desti/provider/resto_detail_provider.dart';

class RestoDetailScreen extends StatelessWidget {
  static const routeName = '/resto-detail';
  final String id;

  const RestoDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestoDetailProvider(apiService: ApiService(), id: id),
      child: Consumer<RestoDetailProvider>(
        builder: (context, state, _) {
          switch (state.state) {
            case ResultState.loading:
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.brown,
                  backgroundColor: Colors.grey,
                ),
              );
            case ResultState.hasData:
              return DetailPage(restaurant: state.result.restaurant);
            case ResultState.error:
              return Center(
                child: Text(state.message),
              );
            default:
              return const Center(
                child: Text(
                  'Gagal memuat',
                  style: TextStyle(fontSize: 24),
                ),
              );
          }
        },
      ),
    );
  }
}

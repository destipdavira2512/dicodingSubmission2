import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_desti/data/api/api_service.dart';
import 'package:restoran_desti/provider/resto_list_provider.dart';
import 'package:restoran_desti/ui/resto_search_screen.dart';
import 'package:restoran_desti/widgets/list_page.dart';

class RestoListScreen extends StatelessWidget {
  static const routeName = '/resto-list';

  const RestoListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restoran Cepat Saji'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RestoSearchScreen.routeName);
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: _buildRestoList(context),
    );
  }
}

Widget _buildRestoList(BuildContext context) {
  return ChangeNotifierProvider(
    create: (_) => RestoListProvider(apiService: ApiService()),
    child: Consumer<RestoListProvider>(
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
            return ListView.builder(
              itemBuilder: (context, index) {
                var resto = state.result.restaurants[index];
                return ListPage(restaurant: resto);
              },
              itemCount: state.result.restaurants.length,
            );
          case ResultState.noData:
            return Center(
              child: Text(state.message),
            );
          case ResultState.error:
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.signal_wifi_off_rounded,
                      color: Colors.grey, size: 90),
                  SizedBox(height: 24),
                  Text(
                    'Harap cek koneksi Anda',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
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

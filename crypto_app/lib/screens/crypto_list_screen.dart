import 'package:flutter/material.dart';
import 'dart:async';
import '../../services/crypto_api_service.dart';
import '../models/cryptocurrency.dart';
import 'crypto_detail_screen.dart';
import 'liked_crypto_screen.dart';

class CryptoListScreen extends StatefulWidget {
  @override
  _CryptoListScreenState createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  Timer? _timer;
  final CryptoAPIService apiService = CryptoAPIService();
  List<Cryptocurrency> cryptos = [];

  @override
  void initState() {
    super.initState();
    _getCryptocurrencies();
    _timer = Timer.periodic(
        Duration(seconds: 10), (Timer t) => _getCryptocurrencies());
  }

  void _getCryptocurrencies() async {
    try {
      var fetchedCryptos = await apiService.fetchCryptocurrencies();
      var newCryptos = fetchedCryptos
          .map((crypto) => Cryptocurrency.fromJson(crypto))
          .toList();

      // Load the liked status for each cryptocurrency
      for (var crypto in newCryptos) {
        await crypto.loadLikedStatus();
      }

      setState(() {
        cryptos = newCryptos;
      });
    } catch (e) {
      // Handle error (e.g., show a snackbar)
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var likedCryptos = cryptos.where((crypto) => crypto.isLiked).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Cryptocurrencies'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      LikedCryptoScreen(likedCryptos: likedCryptos),
                ),
              );
            },
          ),
        ],
      ),
      body: cryptos.isNotEmpty
          ? ListView.builder(
              itemCount: cryptos.length,
              itemBuilder: (context, index) {
                var crypto = cryptos[index];
                return ListTile(
                  title: Text(crypto.name),
                  subtitle: Text('\$${crypto.priceUsd.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: Icon(crypto.isLiked
                        ? Icons.favorite
                        : Icons.favorite_border),
                    onPressed: () async {
                      setState(() {
                        crypto.isLiked = !crypto.isLiked;
                      });
                      await crypto.saveLikedStatus();
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CryptoDetailScreen(cryptocurrency: crypto),
                      ),
                    );
                  },
                );
              },
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

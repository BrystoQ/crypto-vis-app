import 'package:flutter/material.dart';
import 'dart:async';
import '../../services/crypto_api_service.dart';
import '../models/cryptocurrency.dart';
import 'crypto_detail_screen.dart';
import 'package:flutter/foundation.dart';

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
    return Scaffold(
      appBar: AppBar(title: Text('Cryptocurrencies')),
      body: cryptos.isNotEmpty
          ? ListView.builder(
              itemCount: cryptos.length,
              itemBuilder: (context, index) {
                var crypto = cryptos[index];
                return ListTile(
                  title: Text(crypto.name),
                  subtitle: Text('\$${crypto.priceUsd.toStringAsFixed(2)}'),
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

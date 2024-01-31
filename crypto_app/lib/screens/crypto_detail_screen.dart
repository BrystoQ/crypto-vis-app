import 'package:flutter/material.dart';
import 'package:cryptofont/cryptofont.dart';
import '../models/cryptocurrency.dart';

class CryptoDetailScreen extends StatelessWidget {
  final Cryptocurrency cryptocurrency;

  CryptoDetailScreen({Key? key, required this.cryptocurrency})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var symbolLowercase = cryptocurrency.symbol.toLowerCase();
    var cryptoIcon = CryptoFontIcons.fromSymbol(symbolLowercase);

    return Scaffold(
      appBar: AppBar(title: Text(cryptocurrency.name)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Card(
                child: ListTile(
                  title: Text(
                    'Price: \$${cryptocurrency.priceUsd.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Card(
                child: ListTile(
                  title: Text(
                    'Market Cap: \$${cryptocurrency.marketCapUsd.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Card(
                child: ListTile(
                  leading: cryptoIcon != null ? Icon(cryptoIcon) : null,
                  title: Text(
                    'Symbol: ${cryptocurrency.symbol}',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Card(
                child: ListTile(
                  title: Text(
                    'Rank: ${cryptocurrency.rank}',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              // Continue with existing code...
            ],
          ),
        ),
      ),
    );
  }
}

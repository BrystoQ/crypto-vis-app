import 'package:flutter/material.dart';
import '../models/cryptocurrency.dart';

class CryptoDetailScreen extends StatelessWidget {
  final Cryptocurrency cryptocurrency;

  CryptoDetailScreen({Key? key, required this.cryptocurrency})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(cryptocurrency.name)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Price: \$${cryptocurrency.priceUsd.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              'Market Cap: \$${cryptocurrency.marketCapUsd.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Symbol: ${cryptocurrency.symbol}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Rank: ${cryptocurrency.rank}',
              style: TextStyle(fontSize: 20),
            ),
            // Continue with existing code...
          ],
        ),
      ),
    );
  }
}

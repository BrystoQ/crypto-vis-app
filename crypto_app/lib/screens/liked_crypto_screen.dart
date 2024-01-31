import '../models/cryptocurrency.dart';
import 'package:flutter/material.dart';

class LikedCryptoScreen extends StatelessWidget {
  final List<Cryptocurrency> likedCryptos;

  LikedCryptoScreen({required this.likedCryptos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Liked Cryptocurrencies')),
      body: ListView.builder(
        itemCount: likedCryptos.length,
        itemBuilder: (context, index) {
          var crypto = likedCryptos[index];
          return ListTile(
            title: Text(crypto.name),
            subtitle: Text('\$${crypto.priceUsd.toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }
}

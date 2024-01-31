import 'package:shared_preferences/shared_preferences.dart';

class Cryptocurrency {
  final String id;
  final String name;
  final double priceUsd;
  final double marketCapUsd;
  final String symbol;
  final String rank;
  bool isLiked;

  Cryptocurrency({
    required this.id,
    required this.name,
    required this.priceUsd,
    required this.marketCapUsd,
    required this.symbol,
    required this.rank,
    this.isLiked = false,
  });

  factory Cryptocurrency.fromJson(Map<String, dynamic> json) {
    return Cryptocurrency(
      id: json['id'],
      name: json['name'],
      priceUsd: double.parse(json['priceUsd']),
      marketCapUsd: double.parse(json['marketCapUsd']),
      symbol: json['symbol'],
      rank: json['rank'],
      isLiked: json['isLiked'] ?? false,
    );
  }

  Future<void> saveLikedStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(id, isLiked);
  }

  Future<void> loadLikedStatus() async {
    final prefs = await SharedPreferences.getInstance();
    isLiked = prefs.getBool(id) ?? false;
  }
}

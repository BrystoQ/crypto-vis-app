class Cryptocurrency {
  final String id;
  final String name;
  final double priceUsd;
  final double marketCapUsd;
  final String symbol;
  final String rank;

  Cryptocurrency({
    required this.id,
    required this.name,
    required this.priceUsd,
    required this.marketCapUsd,
    required this.symbol,
    required this.rank,
  });

  factory Cryptocurrency.fromJson(Map<String, dynamic> json) {
    return Cryptocurrency(
      id: json['id'],
      name: json['name'],
      priceUsd: double.parse(json['priceUsd']),
      marketCapUsd: double.parse(json['marketCapUsd']),
      symbol: json['symbol'],
      rank: json['rank'],
    );
  }
}

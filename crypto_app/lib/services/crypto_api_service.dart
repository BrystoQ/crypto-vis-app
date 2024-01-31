import 'package:http/http.dart' as http;
import 'dart:convert';

class CryptoAPIService {
  final String apiUrl = 'https://api.coincap.io/v2';

  Future<List<dynamic>> fetchCryptocurrencies() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/assets'));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body)['data'];
        return jsonData;
      } else {
        throw Exception('Failed to load cryptocurrencies');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

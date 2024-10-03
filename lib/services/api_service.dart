import 'dart:convert';

import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();
  final String _apiUrl = "http://10.0.2.2:8000/api/reservation";

  Future<Map<String, dynamic>> makeReservation({
    required String firstName,
    required String lastName,
    required String email,
    required String notes,
    required String venue,
    required String date,
    required String time,
  }) async {
    try {
      var response = await _dio.post(_apiUrl,
          data: json.encode({
            'first_name': firstName,
            'last_name': lastName,
            'email': email,
            'notes': notes,
            'venue': venue,
            'date': date,
            'time': time,
          }));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data; // returns the reservation info with ID
      } else {
        throw Exception(
            'Failed to make reservation: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

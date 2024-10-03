import 'package:booking_app/components/button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessBooked extends StatelessWidget {
  final Map<String, dynamic> reservationData;

  const SuccessBooked({super.key, required this.reservationData});

  @override
  Widget build(BuildContext context) {
    // Extract the actual reservation data
    final Map<String, dynamic> data = reservationData['data'];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Lottie.asset('assets/success.json'),
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  'Your Reservation ID is: ${data['reservation_id'] ?? 'N/A'}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Button(
                  width: double.infinity,
                  title: 'Back to Home Page',
                  disable: false,
                  onPressed: () => Navigator.of(context).pushNamed('/'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

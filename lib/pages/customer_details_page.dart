import 'package:booking_app/components/button.dart';
import 'package:booking_app/components/custom_textfield.dart';
import 'package:booking_app/pages/success_booked.dart';
import 'package:booking_app/providers/booking_provider.dart';
import 'package:booking_app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerDetailsPage extends StatefulWidget {
  const CustomerDetailsPage({super.key});

  @override
  State<CustomerDetailsPage> createState() => _CustomerDetailsPageState();
}

class _CustomerDetailsPageState extends State<CustomerDetailsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<BookingProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Book Appointment',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Form(
          key: _formKey, // Form key to manage validation
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select a Venue',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: bookingProvider.selectedVenue,
                      decoration: InputDecoration(
                        labelText: 'Venue',
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      items: bookingProvider.venues.map((String venue) {
                        return DropdownMenuItem<String>(
                          value: venue,
                          child: Text(venue),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        bookingProvider.setVenue(newValue!);
                      },
                      validator: (value) => value == null
                          ? 'Please select a venue' // Venue validation
                          : null,
                    ),
                    const SizedBox(height: 23),

                    const Text(
                      'Information Detail',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),

                    CustomTextfield(
                      label: 'First Name',
                      controller: bookingProvider.firstNameController,
                      validator: (value) =>
                          value!.isEmpty ? '*First Name is required' : null,
                    ),
                    const SizedBox(height: 20),

                    CustomTextfield(
                      label: 'Last Name',
                      controller: bookingProvider.lastNameController,
                      validator: (value) =>
                          value!.isEmpty ? '*Last Name is required' : null,
                    ),
                    const SizedBox(height: 20),

                    CustomTextfield(
                      label: 'Email',
                      controller: bookingProvider.emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '*Email is required';
                        }
                        // Email validation using a RegExp pattern
                        String emailPattern =
                            r'^[a-zA-Z0-9]+(?:\.[a-zA-Z0-9]+)*@[a-zA-Z0-9]+\.[a-zA-Z]{2,}$';
                        RegExp regex = RegExp(emailPattern);
                        if (!regex.hasMatch(value)) {
                          return '*Please enter a valid email address'; // If email doesn't match the pattern
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    CustomTextfield(
                      label: 'Notes',
                      controller: bookingProvider.notesController,
                      validator: (value) =>
                          value!.isEmpty ? '*Notes are required' : null,
                    ),
                    const SizedBox(height: 50),

                    Button(
                      width: double.infinity,
                      title: 'Make a Reservation',
                      disable: false,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // Form is valid, try to make the reservation
                          try {
                            var reservationData =
                                await ApiService().makeReservation(
                              date: bookingProvider.dateController.text,
                              time: bookingProvider.timeController.text,
                              venue: bookingProvider.selectedVenue!,
                              firstName: bookingProvider.firstNameController.text,
                              lastName: bookingProvider.lastNameController.text,
                              email: bookingProvider.emailController.text,
                              notes: bookingProvider.notesController.text,
                            );

                            bookingProvider.clearFields();

                            // Navigate to SuccessBooked page after successful booking
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SuccessBooked(
                                  reservationData: reservationData,
                                ),
                              ),
                            );
                          } catch (e) {
                            // Show an error message if something goes wrong
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: $e')),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

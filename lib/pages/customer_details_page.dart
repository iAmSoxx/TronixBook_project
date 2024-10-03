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
  // final List<String> _venues = ['Seminar Room']; // Venue dropdown
  // final TextEditingController _firstNameController = TextEditingController();
  // final TextEditingController _lastNameController = TextEditingController();
  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _notesController = TextEditingController();
  //final maxLines = 5;

  //String? _selectedVenue;

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
                  const SizedBox(
                      height: 20), // A little space between label and dropdown
                  DropdownButtonFormField<String>(
                    value: bookingProvider.selectedVenue,
                    decoration: InputDecoration(
                      labelText: 'Venue', // Add label text inside the dropdown
                      labelStyle: TextStyle(
                          color: Colors.grey[700]), // Label text color
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal:
                              10.0), // Adjusts padding for the dropdown content
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Rounded corners
                        borderSide: const BorderSide(
                          color: Colors.grey, // Border color when not focused
                          width: 1.0, // Border thickness
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors
                              .grey, // Border color when enabled but not focused
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.deepPurple, // Border color when focused
                          width: 1.0,
                        ),
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
                  ),
                  const SizedBox(height: 23),

                  const Text(
                    'Information Detail',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  CustomTextfield(
                    label: 'First Name',
                    controller: bookingProvider.firstNameController,
                  ),
                  const SizedBox(height: 20),

                  CustomTextfield(
                    label: 'Last Name',
                    controller: bookingProvider.lastNameController,
                  ),
                  const SizedBox(height: 20),

                  CustomTextfield(
                    label: 'Email',
                    controller: bookingProvider.emailController,
                  ),
                  const SizedBox(height: 20),

                  CustomTextfield(
                    label: 'Notes',
                    controller: bookingProvider.notesController,
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 50),

                  Button(
                    width: double.infinity,
                    title: 'Make a Reservation',
                    disable: false,
                    onPressed: () async {
                      try {
                        // Make the reservation and get the response data
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

                        // Navigate to the ReservationDetailsPage after successful booking
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
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

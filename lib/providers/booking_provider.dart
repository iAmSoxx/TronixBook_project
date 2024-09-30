import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingProvider with ChangeNotifier {
   
  // Controllers
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  // Selected values
  String? selectedVenue;
  DateTime? selectedDate;
  String? selectedTime;

  List<String> availableTimes = [
    "9:00",
    "10:00",
    "11:00",
    "12:00",
    "13:00",
    "14:00",
    "15:00",
    "16:00",
  ];

  // Venue list
  List<String> venues = ['Seminar Room'];

  // Set the date
  void setDate(DateTime date) {
    selectedDate = date;
    dateController.text = DateFormat('yyyy-MM-dd').format(date);
    notifyListeners();
  }

  // Set the time
  void setTime(String time) {
    selectedTime = time;
    timeController.text = time;
    notifyListeners();
  }

  // Set the venue
  void setVenue(String venue) {
    selectedVenue = venue;
    notifyListeners();
  }

  // Clear all fields (optional)
  void clearFields() {
    dateController.clear();
    timeController.clear();
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    notesController.clear();
    selectedVenue = null;
    selectedDate = null;
    selectedTime = null;
    notifyListeners();
  }
}


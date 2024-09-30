import 'package:booking_app/components/button.dart';
import 'package:booking_app/providers/booking_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  // declaration
  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;

  // TextEditingController _dateController = TextEditingController();
  // TextEditingController _timeController = TextEditingController();

  // List of available times
  

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
        padding: const EdgeInsets.symmetric(
          horizontal: 35,
        ),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Column(
                children: <Widget>[
                  _tableCalendar(),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                    child: Center(
                      child: Text(
                        'Select a Time',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _isWeekend
                ? SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 30),
                      alignment: Alignment.center,
                      child: const Text(
                        'Weekend is not available, please select another date',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ),
                  )
                : SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return InkWell(
                          splashColor: Colors.transparent,
                          onTap: () {
                            // when selected, update current index and set time selected to true
                            setState(() {
                              _currentIndex = index;
                              _timeSelected = true;

                              bookingProvider.setTime(bookingProvider.availableTimes[index]);
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: _currentIndex == index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              color: _currentIndex == index
                                  ? Colors.deepPurple
                                  : null,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              bookingProvider.availableTimes[index],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _currentIndex == index
                                    ? Colors.white
                                    : null,
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: bookingProvider.availableTimes.length,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 5,
                    ),
                  ),
            SliverToBoxAdapter(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 80),
                child: Button(
                  width: double.infinity,
                  title: 'Continue',
                  disable: _timeSelected && _dateSelected ? false : true,
                  onPressed: () {
                    Navigator.pushNamed(context, '/customerDetailsPage');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // table calendar
  Widget _tableCalendar() {
    final bookingProvider = Provider.of<BookingProvider>(context);
    return TableCalendar(
      focusedDay: _focusDay,
      firstDay: DateTime.now(),
      lastDay: DateTime(2025, 12, 31),
      calendarFormat: _format,
      currentDay: _currentDay,
      rowHeight: 48,
      calendarStyle: const CalendarStyle(
        todayDecoration:
            BoxDecoration(color: Colors.deepPurple, shape: BoxShape.circle),
      ),
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      onFormatChanged: (format) {
        setState(() {
          _format = format;
        });
      },
      onDaySelected: ((selectedDay, focusedDay) {
        setState(() {
          _currentDay = selectedDay;
          _focusDay = focusedDay;
          _dateSelected = true;

          bookingProvider.setDate(selectedDay);

          // check if weekend is selected
          if (selectedDay.weekday == 6 || selectedDay.weekday == 7) {
            _isWeekend = true;
            _timeSelected = false;
            _currentIndex = null;
          } else {
            _isWeekend = false;
          }
        });
      }),
    );
  }
}

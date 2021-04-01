import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() => runApp(AppointmentDetails());

class AppointmentDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TapAppointmentDetails(),
    );
  }
}

class TapAppointmentDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScheduleExample();
}

List<String> colors = <String>[
  'Pink',
  'Blue',
  'Wall Brown',
  'Yellow',
  'Default'
];

List<String> views = <String>[
  'Day',
  'Week',
  'WorkWeek',
  'Month',
  'Timeline Day',
  'Timeline Week',
  'Timeline WorkWeek'
];

class ScheduleExample extends State<TapAppointmentDetails> {
  CalendarView _calendarView=CalendarView.week;
  String? _subjectText, _startTimeText, _endTimeText,
      _dateText, _timeDetails;
  Color? headerColor, viewHeaderColor, calendarColor, defaultColor;

  @override
  void initState() {

    _subjectText = '';
    _startTimeText = '';
    _endTimeText = '';
    _dateText = '';
    _timeDetails = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            PopupMenuButton<String>(
              icon: Icon(Icons.color_lens),
              itemBuilder: (BuildContext context) {
                return colors.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
              onSelected: (String value) {
                setState(() {
                  if (value == 'Pink') {
                    headerColor = const Color(0xFF09e8189);
                    viewHeaderColor = const Color(0xFF0f3acb6);
                    calendarColor = const Color(0xFF0ffe5d8);
                  } else if (value == 'Blue') {
                    headerColor = const Color(0xFF0007eff);
                    viewHeaderColor = const Color(0xFF03aa4f6);
                    calendarColor = const Color(0xFF0bae5ff);
                  } else if (value == 'Wall Brown') {
                    headerColor = const Color(0xFF0937c5d);
                    viewHeaderColor = const Color(0xFF0e6d9b1);
                    calendarColor = const Color(0xFF0d1d2d6);
                  } else if (value == 'Yellow') {
                    headerColor = const Color(0xFF0f7ed53);
                    viewHeaderColor = const Color(0xFF0fff77f);
                    calendarColor = const Color(0xFF0f7f2cc);
                  } else if (value == 'Default') {
                    headerColor = null;
                    viewHeaderColor = null;
                    calendarColor = null;
                  }
                });
              },
            ),
          ],
          backgroundColor: headerColor,
          centerTitle: true,
          titleSpacing: 60,
          leading: PopupMenuButton<String>(
            icon: Icon(Icons.calendar_today),
            itemBuilder: (BuildContext context) => views.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList(),
            onSelected: (String value) {
              setState(() {
                if (value == 'Day') {
                  _calendarView = CalendarView.day;
                } else if (value == 'Week') {
                  _calendarView = CalendarView.week;
                } else if (value == 'WorkWeek') {
                  _calendarView = CalendarView.workWeek;
                } else if (value == 'Month') {
                  _calendarView = CalendarView.month;
                } else if (value == 'Timeline Day') {
                  _calendarView = CalendarView.timelineDay;
                } else if (value == 'Timeline Week') {
                  _calendarView = CalendarView.timelineWeek;
                } else if (value == 'Timeline WorkWeek') {
                  _calendarView = CalendarView.timelineWorkWeek;
                }
              });
            },
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: SfCalendar(
                viewHeaderStyle:
                ViewHeaderStyle(backgroundColor: viewHeaderColor),
                backgroundColor: calendarColor,
                view: _calendarView,
                monthViewSettings: MonthViewSettings(showAgenda: true),
                dataSource: getCalendarDataSource(),
                onTap: calendarTapped,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void calendarTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment ||
        details.targetElement == CalendarElement.agenda) {
      final Appointment appointmentDetails = details.appointments![0];
      _subjectText = appointmentDetails.subject;
      _dateText = DateFormat('MMMM dd, yyyy')
          .format(appointmentDetails.startTime)
          .toString();
      _startTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.startTime).toString();
      _endTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.endTime).toString();
      if (appointmentDetails.isAllDay) {
        _timeDetails = 'All day';
      } else {
        _timeDetails = '$_startTimeText - $_endTimeText';
      }
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Container(child: new Text('$_subjectText')),
              content: Container(
                height: 80,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          '$_dateText',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(''),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(_timeDetails!,
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 15)),
                      ],
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: new Text('close'))
              ],
            );
          });
    }
  }

  _DataSource getCalendarDataSource() {
    final List<Appointment> appointments = <Appointment>[];
    appointments.add(Appointment(
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 1)),
      subject: 'Meeting',
      color: Colors.pink,
      isAllDay: true,
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(hours: 4, days: -1)),
      endTime: DateTime.now().add(const Duration(hours: 5, days: -1)),
      subject: 'Release Meeting',
      color: Colors.lightBlueAccent,
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(hours: 2, days: -2)),
      endTime: DateTime.now().add(const Duration(hours: 4, days: -2)),
      subject: 'Performance check',
      color: Colors.amber,
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(hours: 6, days: -3)),
      endTime: DateTime.now().add(const Duration(hours: 7, days: -3)),
      subject: 'Support',
      color: Colors.green,
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(hours: 6, days: 2)),
      endTime: DateTime.now().add(const Duration(hours: 7, days: 2)),
      subject: 'Retrospective',
      color: Colors.purple,
    ));

    return _DataSource(appointments);
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(this.source);

  List<Appointment> source;

  @override
  List<dynamic> get appointments => source;
}

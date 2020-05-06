
# Getting appointment details from the OnTap event of the flutter calendar.
In the flutter event calendar, you can get the tapped appointment details using the `OnTap` event.

## Step 1:
In initState(), set the default values such as view, alert dialog texts.

```xml
CalendarView _calendarView;
String _subjectText, _startTimeText, _endTimeText,
       _dateText, _timeDetails;
 
@override
void initState() {
  _calendarView = CalendarView.week;
  _subjectText = '';
  _startTimeText = '';
  _endTimeText = '';
  _dateText = '';
  _timeDetails = '';
  super.initState();
}
```
 

# Step 2:
Trigger the `OnTap` callback of the flutter calendar. Please find the following code for the calendar.
```xml
Expanded(
  child: SfCalendar(
    view: _calendarView,
    monthViewSettings: MonthViewSettings(
      showAgenda: true
    ),
    dataSource: getCalendarDataSource(),
    onTap: calendarTapped,
  ),
),
```
 

## Step 3:
Using the `OnTap` event, you can get the tapped appointment details such as Subject, StartTime, and EndTime from the callback and assign it to the content of the alert dialog widget as per the following code snippet.
```xml
void calendarTapped(CalendarTapDetails details) {
  if (details.targetElement == CalendarElement.appointment ||
      details.targetElement == CalendarElement.agenda) {
    final Appointment appointmentDetails = details.appointments[0];
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
                      Text(_timeDetails,
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
```
**[View document in Syncfusion Flutter Knowledge base](https://www.syncfusion.com/kb/10999/how-to-get-appointment-details-from-the-ontap-event-of-the-flutter-event-calendar)**

**Screenshots**

<img alt="Agenda appointment details"  src="http://www.syncfusion.com/uploads/user/kb/flut/flut-669/flut-669_img2.jpeg" width="250" height="500" />|
<img alt="All day appointment details"  src="http://www.syncfusion.com/uploads/user/kb/flut/flut-669/flut-669_img3.jpeg" width="250" height="500" />|
<img alt="Appointment details"  src="http://www.syncfusion.com/uploads/user/kb/flut/flut-669/flut-669_img4.jpeg" width="250" height="500" />|

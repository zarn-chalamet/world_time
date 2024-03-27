import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String? location;
  String? time;
  String? flag;
  String? url;
  bool? isDaytime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      // http.Response response = await http
      //     .get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      // Map data = jsonDecode(response.body);
      // String datetime = data['datetime'];
      // String offset = data['utc_offset'].substring(1, 3);

      // DateTime now = DateTime.parse(datetime);
      // now = now.add(Duration(hours: int.parse(offset)));

      // isDaytime = now.hour > 6 && now.hour < 18 ? true : false;
      // time = DateFormat.jm().format(now);

      DateTime utcTime = DateTime.now().toUtc();

      // Fetch time data from API
      http.Response response = await http
          .get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      // Extract offset from API response
      String offsetString = data['utc_offset'];
      int hoursOffset = int.parse(offsetString.substring(1, 3));
      int minutesOffset = int.parse(offsetString.substring(4));
      Duration offset = Duration(hours: hoursOffset, minutes: minutesOffset);

      // Calculate local time by applying offset to UTC time
      DateTime localTime = utcTime.add(offset);

      // Set time properties
      isDaytime = localTime.hour > 6 && localTime.hour < 18;
      time = DateFormat.jm().format(localTime);
    } catch (e) {
      print('caught error: $e');
      time = 'could not get time data';
    }
  }
}

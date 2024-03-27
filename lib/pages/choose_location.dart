import 'package:flutter/material.dart';
import 'package:worldtime/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldTime> locations = [
    WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(url: 'Europe/Berlin', location: 'Berlin', flag: 'germany.png'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
    WorldTime(url: 'Asia/Bangkok', location: 'Bangkok', flag: 'thailand.jpg'),
    WorldTime(url: 'Asia/Rangoon', location: 'Yangon', flag: 'myanmar.jpg'),
    WorldTime(url: 'Asia/Tokyo', location: 'Tokyo', flag: 'japan.jpg'),
  ];

  void updateTime(BuildContext context, int index) async {
    WorldTime instance = locations[index];
    await instance.getTime();
    // print(
    //     '====================================================================================================');
    // print(instance.getTime());
    // print(
    //     '====================================================================================================');
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDaytime': instance.isDaytime,
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Build function ran');
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('choose a location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
            onTap: () {
              updateTime(context, index);
            },
            title: Text('${locations[index].location}'),
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/${locations[index].flag}'),
            ),
          ));
        },
      ),
    );
  }
}

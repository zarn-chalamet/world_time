import 'package:flutter/material.dart';
import 'package:worldtime/services/world_time.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Map<String, dynamic> data;

  @override
  void initState() {
    super.initState();
    data = {}; // Initialize with empty data
    updateTime(); // Fetch initial data
  }

  // Function to update time data
  Future<void> updateTime() async {
    WorldTime instance = WorldTime(
        location: 'Bangkok', flag: 'thailand.jpg', url: 'Asia/Bangkok');
    await instance.getTime();
    setState(() {
      data = {
        'time': instance.time,
        'location': instance.location,
        'isDaytime': instance.isDaytime,
        'flag': instance.flag,
      };
    });
  }

  // Function to handle navigation to choose location screen
  Future<void> _navigateToChooseLocation() async {
    dynamic result = await Navigator.pushNamed(context, '/location');
    if (result != null) {
      setState(() {
        data = {
          'time': result['time'],
          'location': result['location'],
          'isDaytime': result['isDaytime'],
          'flag': result['flag']
        };
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final data = ModalRoute.of(context)?.settings.arguments;

    // final routeArgs =
    //     ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
    //         {};
    // data = routeArgs.isNotEmpty ? routeArgs : data;

    String bgImage = data['isDaytime'] ? 'day.png' : 'night.png';
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Column(
              children: [
                TextButton.icon(
                  onPressed: () async {
                    // dynamic result =
                    //     await Navigator.pushNamed(context, '/location');
                    // setState(() {
                    //   data = {
                    //     'time': result['time'],
                    //     'location': result['location'],
                    //     'isDaytime': result['isDaytime'],
                    //     'flag': result['flag']
                    //   };
                    // });
                    await _navigateToChooseLocation();
                  },
                  icon: Icon(Icons.edit_location),
                  label: Text('Edit Location!'),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['location'],
                      style: TextStyle(fontSize: 28.0, letterSpacing: 2.0),
                    )
                  ],
                ),
                SizedBox(height: 20.0),
                Text(
                  data['time'],
                  style: TextStyle(fontSize: 66.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

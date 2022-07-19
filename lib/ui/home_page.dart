import 'dart:math';

import 'package:alarm_manager_latihan/utils/background_service.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _backgroundService = BackgroundService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    port.listen((_) async => await _backgroundService.someTask());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alarm Manager'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                await AndroidAlarmManager.oneShot(
                  const Duration(seconds: 5),
                  _randomId(),
                  BackgroundService.callBack,
                  exact: true,
                  wakeup: true,
                );
              },
              child: const Text('Alarm with delay (once)'),
            ),
            ElevatedButton(
              onPressed: () async {
                await AndroidAlarmManager.oneShotAt(
                  DateTime.now().add(const Duration(seconds: 5)),
                  _randomId(),
                  BackgroundService.callBack,
                  exact: true,
                  wakeup: true,
                );
              },
              child: const Text('Alarm with datetime'),
            ),
            ElevatedButton(
              onPressed: () async {
                await AndroidAlarmManager.periodic(
                  const Duration(minutes: 1),
                  _randomId(),
                  BackgroundService.callBack,
                  exact: true,
                  wakeup: true,
                  startAt: DateTime.now(),
                );
              },
              child: const Text('Alarm with delay (once)'),
            ),
          ],
        ),
      ),
    );
  }

  int _randomId() {
    final random = Random();

    return random.nextInt(10);
  }
}

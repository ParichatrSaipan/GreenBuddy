// lib/screen/alarm_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:app/structure/background_container.dart';
import 'package:app/screen/sugges2_screen.dart';
import 'package:app/screen/edit_alarm_screen.dart';  // <-- import ไฟล์ใหม่ที่มี EditAlarmScreen

/// โมเดลเก็บข้อมูลแจ้งเตือน
class Alarm {
  TimeOfDay time;
  String label;
  bool enabled;
  bool soundOn;
  bool snoozeOn;

  Alarm({
    required this.time,
    this.label = 'Alarm everyday',
    this.enabled = true,
    this.soundOn = true,
    this.snoozeOn = false,
  });
}

/// หน้ารายการแจ้งเตือน (Alarm List)
class AlarmScreen extends StatefulWidget {
  final Color plantColor;

  const AlarmScreen({Key? key, required this.plantColor}) : super(key: key);

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  final List<Alarm> alarms = [
    Alarm(time: const TimeOfDay(hour: 7, minute: 30), enabled: false),
    Alarm(time: const TimeOfDay(hour: 18, minute: 0)),
    Alarm(time: const TimeOfDay(hour: 9, minute: 0)),
  ];

  @override
  Widget build(BuildContext context) {
    return BackgroundContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(200),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  widget.plantColor.withOpacity(0.9),
                  widget.plantColor.withOpacity(0.7),
                  widget.plantColor.withOpacity(0.6),
                ],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    // ปุ่มย้อนกลับ
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(18),
                        onTap: () => Navigator.of(context).pop(),
                        child: const SizedBox(
                          width: 45,
                          height: 45,
                          child: Icon(Icons.arrow_back, color: Colors.white),
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        "ตั้งเวลาแจ้งเตือนแง้วๆ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // ปุ่มเพิ่มแจ้งเตือน
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(18),
                        onTap: _onAddAlarm,
                        child: const SizedBox(
                          width: 45,
                          height: 45,
                          child: Icon(Icons.add, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: alarms.length,
          separatorBuilder: (_, __) => const Divider(height: 1, indent: 16, endIndent: 16),
          itemBuilder: (context, index) {
            final alarm = alarms[index];
            return ListTile(
              leading: const Icon(Icons.access_time),
              title: Text(
                alarm.time.format(context),
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              subtitle: Text(alarm.label),
              trailing: Switch(
                value: alarm.enabled,
                onChanged: (on) => setState(() => alarm.enabled = on),
              ),
              onTap: () => _onEditAlarm(alarm, index),
            );
          },
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.green.shade300,
                Colors.green.shade400,
                Colors.teal.shade300,
              ],
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: 2,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withOpacity(0.6),
            onTap: (i) {
              if (i == 0) Navigator.pop(context);
              if (i == 1) Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => Suggest2Page()),
              );
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline_rounded), label: 'Suggest'),
              BottomNavigationBarItem(icon: Icon(Icons.notifications_outlined), label: 'Alarm'),
            ],
          ),
        ),
      ),
    );
  }

  void _onAddAlarm() async {
    final newAlarm = Alarm(time: TimeOfDay.now());
    final created = await Navigator.push<Alarm?>(
      context,
      MaterialPageRoute(
        builder: (_) => EditAlarmScreen(
          alarm: newAlarm,
          plantColor: widget.plantColor,
          isNew: true,
        ),
      ),
    );
    if (created != null) setState(() => alarms.add(created));
  }

  void _onEditAlarm(Alarm alarm, int index) async {
    final updated = await Navigator.push<Alarm?>(
      context,
      MaterialPageRoute(
        builder: (_) => EditAlarmScreen(
          alarm: alarm,
          plantColor: widget.plantColor,
        ),
      ),
    );
    if (updated == null) setState(() => alarms.removeAt(index));
    else setState(() => alarms[index] = updated);
  }
}

// lib/screen/edit_alarm_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:app/structure/background_container.dart';
import 'package:app/screen/alarm_screen.dart';

/// หน้าแก้ไข / เพิ่มแจ้งเตือน
class EditAlarmScreen extends StatefulWidget {
  final Alarm alarm;
  final Color plantColor;
  final bool isNew;

  const EditAlarmScreen({
    Key? key,
    required this.alarm,
    required this.plantColor,
    this.isNew = false,
  }) : super(key: key);

  @override
  _EditAlarmScreenState createState() => _EditAlarmScreenState();
}

class _EditAlarmScreenState extends State<EditAlarmScreen> {
  late Alarm alarm;

  @override
  void initState() {
    super.initState();
    alarm = widget.alarm;
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,

        // AppBar ภาษาไทย
        appBar: AppBar(
          backgroundColor: widget.plantColor,
          elevation: 0,
          leading: TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('ยกเลิก', style: TextStyle(color: Colors.white)),
          ),
          title: const Text('แก้ไขแจ้งเตือน'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, alarm),
              child: const Text('บันทึก', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),

        // เนื้อหาหลัก
        body: Column(
          children: [
            // วงล้อเลือกเวลา
            SizedBox(
              height: 180,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                initialDateTime: DateTime(
                  0, 0, 0, alarm.time.hour, alarm.time.minute,
                ),
                use24hFormat: false,
                onDateTimeChanged: (dt) {
                  setState(() {
                    alarm.time = TimeOfDay(hour: dt.hour, minute: dt.minute);
                  });
                },
              ),
            ),
            const SizedBox(height: 16),

            // การตั้งค่าเพิ่มเติม
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text('ทำซ้ำ'),
                        trailing: const Text('ไม่มี >'),
                        onTap: () {},
                      ),
                      ListTile(
                        title: const Text('ชื่อแจ้งเตือน'),
                        trailing: Text(alarm.label),
                        onTap: () {},
                      ),
                      SwitchListTile(
                        title: const Text('เสียง'),
                        value: alarm.soundOn,
                        onChanged: (v) => setState(() => alarm.soundOn = v),
                      ),
                      SwitchListTile(
                        title: const Text('เลื่อนเวลา'),
                        value: alarm.snoozeOn,
                        onChanged: (v) => setState(() => alarm.snoozeOn = v),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const Spacer(),

            // ปุ่มลบ (เฉพาะเมื่อแก้ไข ไม่ใช่สร้างใหม่)
            if (!widget.isNew)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: const Size.fromHeight(48),
                  ),
                  onPressed: () => Navigator.pop(context, null),
                  child: const Text('ลบแจ้งเตือน'),
                ),
              ),

            const SizedBox(height: 24),
          ],
        ),

        // BottomAppBar
        bottomNavigationBar: BottomAppBar(
          color: widget.plantColor,
          child: const SizedBox(height: 48),
        ),
      ),
    );
  }
}

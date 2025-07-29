import 'package:flutter/material.dart';
import 'package:app/structure/background_container.dart';
import 'package:app/screen/sugges2_screen.dart';

// หน้าจอให้ตั้งค่าเวลาแจ้งเตือน
class AlarmScreen extends StatefulWidget {
  final Color plantColor; // สีธีมของหน้า

  const AlarmScreen({super.key, required this.plantColor});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  @override
  void initState() {
    super.initState();
    // เรียกหลังจากวาด UI เสร็จเพื่ออัปเดตสถานะ (ถ้ายังเมาท์ติดอยู่)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // ส่วนหัวของหน้าจอ (AppBar)
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(280),
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
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // ปุ่มย้อนกลับ
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Material(
                        color: Colors.transparent,
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
                    ),
                    // ชื่อหน้า ตรงกลาง
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
                    const SizedBox(width: 45), // เว้นที่ด้านขวาเท่าไอคอน
                  ],
                ),
              ),
            ),
          ),
        ),
        // เนื้อหาหลักของหน้า
        body: const Center(
          child: Text(
            "หน้าตั้งเวลาแจ้งเตือนแง้ว",
            style: TextStyle(fontSize: 24),
          ),
        ),
        // แถบเมนูด้านล่าง
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.green.shade300,
                Colors.green.shade400,
                Colors.teal.shade300,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: 2, // ตั้งค่าให้ไอคอน Alarm ถูกเลือก
            onTap: (index) {
              // กำหนดการทำงานเมื่อกดไอคอนแต่ละตัว
              if (index == 0) {
                // กลับไปหน้าโฮม
                Navigator.pop(context);
              } else if (index == 1) {
                // ไปหน้าส่งคำแนะนำ
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Suggest2Page()),
                );
              } else if (index == 2) {
                // อยู่ในหน้าแจ้งเตือนแล้ว ไม่ต้องทำอะไร
                return;
              }
            },
            backgroundColor: Colors.transparent,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withOpacity(0.6),
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded, size: 28),
                label: 'Home', // หน้าโฮม
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble_outline_rounded, size: 28),
                label: 'Suggest', // คำแนะนำ
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications_outlined, size: 28),
                label: 'Alarm', // ตั้งค่าแจ้งเตือน
              ),
            ],
          ),
        ),
      ),
    );
  }
}

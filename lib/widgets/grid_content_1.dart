import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cbe/screens/phone_transfer_screen.dart'; // Imports the Transfer Screen

class GridContent1 extends StatelessWidget {
  GridContent1({super.key});

  final List<Map<String, dynamic>> gridItems = [
    {"text": "Linked Bank Acct", "icon": FontAwesomeIcons.house},
    {"text": "Send Money", "icon": FontAwesomeIcons.moneyBillTransfer},
    {"text": "To CBE Acct", "icon": FontAwesomeIcons.buildingColumns},
    {"text": "Air Time", "icon": FontAwesomeIcons.phone},
    {"text": "Cash Out", "icon": FontAwesomeIcons.moneyBill},
    {"text": "Airtime Package", "icon": FontAwesomeIcons.wifi},
    {"text": "Scheduled Pay", "icon": FontAwesomeIcons.calendarDays},
    {"text": "MagicPay", "icon": FontAwesomeIcons.wandMagic},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: gridItems.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            String buttonText = gridItems[index]["text"];
            
            // If you click Send Money, it opens the new Phone Transfer screen
            if (buttonText == "Send Money" || buttonText == "To CBE Acct") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PhoneTransferScreen()),
              );
            } else {
              // For the rest, show a "Coming Soon" popup
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(buttonText),
                  content: const Text("This feature is coming soon!"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context), 
                      child: const Text("OK")
                    )
                  ],
                )
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      gridItems[index]["icon"],
                      color: const Color.fromRGBO(143, 39, 143, 1),
                      size: 25,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      gridItems[index]["text"],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

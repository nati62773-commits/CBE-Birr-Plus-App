import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cbe/screens/phone_transfer_screen.dart'; // Points to the correct screen

class GridContent2 extends StatelessWidget {
  GridContent2({super.key});

  final List<Map<String, dynamic>> items = [
    {
      "icon": FontAwesomeIcons.twitter, // Orange bird icon
      "color": Colors.orange,
      "text": "Transfer To\nOther Banks",
      "action": "bank"
    },
    {
      "icon": FontAwesomeIcons.twitter, // Orange bird icon
      "color": Colors.orange,
      "text": "Transfer To\nOther Wallet &\nMicro Finance",
      "action": "soon"
    },
    {
      "icon": FontAwesomeIcons.dollarSign,
      "color": const Color.fromRGBO(143, 39, 143, 1),
      "text": "Pay for\nMerchant",
      "action": "soon"
    },
    {
      "icon": FontAwesomeIcons.gasPump,
      "color": const Color.fromRGBO(143, 39, 143, 1),
      "text": "Fuel Pay",
      "action": "soon"
    },
    {
      "icon": FontAwesomeIcons.building,
      "color": const Color.fromRGBO(200, 160, 100, 1),
      "text": "Condominium\nRepayment",
      "action": "soon"
    },
    {
      "icon": FontAwesomeIcons.store,
      "color": const Color.fromRGBO(143, 39, 143, 1),
      "text": "Money\nRequest",
      "action": "soon"
    },
    {
      "icon": FontAwesomeIcons.locationDot,
      "color": const Color.fromRGBO(143, 39, 143, 1),
      "text": "Location",
      "action": "soon"
    },
    {
      "icon": FontAwesomeIcons.gamepad,
      "color": const Color.fromRGBO(143, 39, 143, 1),
      "text": "Play and\nWin",
      "action": "soon"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 15,
        crossAxisSpacing: 10,
        childAspectRatio: 0.8, // Adjusts height to fit the text
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Logic for bottom grid buttons
            if (items[index]["action"] == "bank") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PhoneTransferScreen()),
              );
            } else {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(items[index]["text"].replaceAll('\n', ' ')),
                  content: const Text("This feature is coming soon in the next update!"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("OK"),
                    )
                  ],
                ),
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    items[index]["icon"],
                    color: items[index]["color"],
                    size: 30,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    items[index]["text"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

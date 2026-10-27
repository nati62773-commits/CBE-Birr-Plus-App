import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GenericPayScreen extends StatefulWidget {
  final String title;
  const GenericPayScreen({super.key, required this.title});

  @override
  State<GenericPayScreen> createState() => _GenericPayScreenState();
}

class _GenericPayScreenState extends State<GenericPayScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  void _processPayment() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Column(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 60),
                SizedBox(height: 8),
                Text("Payment Successful", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                _buildReceiptRow("Service", widget.title),
                _buildReceiptRow("Account/Meter", _accountController.text),
                _buildReceiptRow("Amount Paid", "ETB ${_amountController.text}"),
                _buildReceiptRow("Date", DateFormat('dd MMM yyyy, HH:mm').format(DateTime.now())),
                const SizedBox(height: 10),
                const Text("Thank you for your payment.", style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close receipt
                  Navigator.pop(context); // Go back to pay screen
                },
                child: const Text("Done", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ],
          );
        },
      );
    }
  }

  Widget _buildReceiptRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(143, 39, 143, 1),
        title: Text(widget.title),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _accountController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: "Account / Meter / Reference Number",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.numbers),
                ),
                validator: (value) => value!.isEmpty ? "Please enter account number" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Amount (ETB)",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                ),
                validator: (value) => value!.isEmpty ? "Please enter amount" : null,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(143, 39, 143, 1),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: _processPayment,
                  child: Text("Pay ${widget.title}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

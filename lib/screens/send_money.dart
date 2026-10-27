import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add this to pubspec.yaml if not present

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  // Generate a fake but realistic CBE Birr transaction ID
  String get _transactionId {
    final now = DateTime.now();
    final formatter = DateFormat('yyMMddHHmmss');
    return 'FT${formatter.format(now)}';
  }

  void _showConfirmation() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Confirm Transfer"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Send ETB ${_amountController.text} to"),
                const SizedBox(height: 4),
                Text(_accountController.text, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text("Reason: ${_reasonController.text}"),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF9C27B0)),
                onPressed: () {
                  Navigator.pop(context); // Close confirmation
                  _processTransfer(); // Show receipt
                },
                child: const Text("Confirm", style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      );
    }
  }

  void _processTransfer() {
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
              Text("Transfer Successful", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              _buildReceiptRow("Transaction ID", _transactionId),
              _buildReceiptRow("Receiver", _accountController.text),
              _buildReceiptRow("Amount", "ETB ${_amountController.text}"),
              _buildReceiptRow("Service Fee", "ETB 0.00"),
              _buildReceiptRow("Total Paid", "ETB ${_amountController.text}"),
              _buildReceiptRow("Reason", _reasonController.text),
              _buildReceiptRow("Date", DateFormat('dd MMM yyyy, HH:mm').format(DateTime.now())),
              const SizedBox(height: 10),
              const Text("Payer: CBE Birr User", style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close receipt
                Navigator.pop(context); // Go back to home
              },
              child: const Text("Done", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ],
        );
      },
    );
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
        backgroundColor: const Color(0xFF9C27B0),
        title: const Text("Send Money"),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _accountController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Receiver's CBE Birr Account / Phone",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (value) => value!.isEmpty ? "Enter receiver account" : null,
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
                validator: (value) {
                  if (value!.isEmpty) return "Enter amount";
                  if (double.tryParse(value) == null) return "Enter a valid number";
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _reasonController,
                decoration: const InputDecoration(
                  labelText: "Reason (e.g., Family Support)",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.note),
                ),
                validator: (value) => value!.isEmpty ? "Enter a reason" : null,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9C27B0),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: _showConfirmation,
                  child: const Text("Send Money", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

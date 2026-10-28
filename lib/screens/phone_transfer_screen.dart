import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cbe/utils/user_session.dart';

class PhoneTransferScreen extends StatefulWidget {
  const PhoneTransferScreen({super.key});

  @override
  State<PhoneTransferScreen> createState() => _PhoneTransferScreenState();
}

class _PhoneTransferScreenState extends State<PhoneTransferScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _receiverNameController = TextEditingController();

  bool _isSearching = false;
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _phoneController.dispose();
    _amountController.dispose();
    _reasonController.dispose();
    _receiverNameController.dispose();
    super.dispose();
  }

  void _lookupPhone(String phoneNumber) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    if (phoneNumber.length >= 10) { 
      setState(() {
        _isSearching = true;
        _receiverNameController.text = "";
      });

      _debounce = Timer(const Duration(milliseconds: 800), () {
        setState(() {
          _isSearching = false;
          int sum = 0;
          for (int i = 0; i < phoneNumber.length; i++) {
            sum += int.tryParse(phoneNumber[i]) ?? 0;
          }
          final firstNames = ["ABEBE", "SARA", "DAWIT", "BIRUK", "HELEN", "KALEB", "YONAS"];
          final lastNames = ["KEBEDE", "JOHNSON", "MULUGETA", "GIRMA", "HAILE", "TADESSE"];
          
          _receiverNameController.text = "${firstNames[sum % firstNames.length]} ${lastNames[sum % lastNames.length]}";
        });
      });
    } else {
      setState(() {
        _isSearching = false;
        _receiverNameController.text = "";
      });
    }
  }

  void _showConfirmationModal() {
    if (_phoneController.text.isEmpty || _amountController.text.isEmpty || _receiverNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
              ),
              const Center(child: Text("Send Money", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
              Center(child: Text("${_amountController.text} ETB", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
              const SizedBox(height: 10),
              Center(child: Text("To: ${_receiverNameController.text}", style: const TextStyle(fontSize: 14, color: Colors.grey))),
              const SizedBox(height: 20),
              _buildFeeRow("Service Charge", "0.05 ETB"),
              _buildFeeRow("Total Deductions", "${(double.tryParse(_amountController.text) ?? 0) + 0.06} ETB", isBold: true),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(143, 39, 143, 1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    Navigator.pop(context); 
                    _showSuccessReceipt();
                  },
                  child: const Text("Confirm", style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSuccessReceipt() {
    final String txnId = "FT${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}";
    final String date = DateFormat('dd MMM yyyy h:mm a').format(DateTime.now());

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 60),
                const SizedBox(height: 10),
                const Text("Thank you", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const Text("Success", style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Transaction Summary", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(color: Colors.black, fontSize: 13, height: 1.5),
                          children: [
                            TextSpan(text: "ETB ${_amountController.text} has been debited from "),
                            TextSpan(text: UserSession.fullName, style: const TextStyle(fontWeight: FontWeight.bold)), 
                            TextSpan(text: " for "),
                            TextSpan(text: _receiverNameController.text, style: const TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: " on $date with transaction ID: "),
                            TextSpan(text: txnId, style: const TextStyle(fontWeight: FontWeight.bold)),
                            const TextSpan(text: " via CBEBirr mobile app's Transfer."),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!)),
                          child: const Icon(Icons.qr_code_2, size: 80, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () { Navigator.pop(context); Navigator.pop(context); },
                        child: const Text("Back to home"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Close"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFeeRow(String label, String amount, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(amount, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(143, 39, 143, 1),
        title: const Text("Send Money"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("* Receiver's Phone", style: TextStyle(color: Color.fromRGBO(143, 39, 143, 1), fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                onChanged: _lookupPhone,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.phone, color: Color.fromRGBO(143, 39, 143, 1)),
                  suffixIcon: _isSearching ? const Padding(padding: EdgeInsets.all(12), child: CircularProgressIndicator(strokeWidth: 2)) : null,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color.fromRGBO(143, 39, 143, 1))),
                  hintText: "Enter Phone Number",
                ),
              ),
              
              if (_receiverNameController.text.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Receiver's Name (Editable)", style: TextStyle(fontSize: 12, color: Colors.grey)),
                      TextFormField(
                        controller: _receiverNameController,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 20),
              const Text("* Amount", style: TextStyle(color: Color.fromRGBO(143, 39, 143, 1), fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.attach_money, color: Color.fromRGBO(143, 39, 143, 1)),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color.fromRGBO(143, 39, 143, 1))),
                  hintText: "Amount",
                ),
              ),
              
              const SizedBox(height: 20),
              const Text("Reason", style: TextStyle(color: Color.fromRGBO(143, 39, 143, 1), fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _reasonController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.question_mark, color: Color.fromRGBO(143, 39, 143, 1)),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color.fromRGBO(143, 39, 143, 1))),
                  hintText: "Reason",
                ),
              ),
              
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(143, 39, 143, 1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: _showConfirmationModal,
                  child: const Text("Send Money", style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

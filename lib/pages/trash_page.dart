import 'package:flutter/material.dart';

class TrashPage extends StatefulWidget {
  const TrashPage({super.key});

  @override
  State<TrashPage> createState() => _TrashPageState();
}

class _TrashPageState extends State<TrashPage> {
  DateTime? selectedDate;
  String? selectedType;
  String selectedUnit = 'gram';

  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  final List<String> sampahTypes = [
    'Plastik',
    'Organik',
    'Kaca',
    'Kertas',
    'Logam',
  ];

  final List<String> satuan = ['gram', 'kg', 'pcs'];

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2026),
    );

    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0b3348),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.arrow_back, color: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'SampahKU\nInputSampah',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        height: 1.3),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // FORM
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xff2e4d5a),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle('Catat Sampah Hari ini'),

                    const SizedBox(height: 20),
                    _formLabel('Tanggal :'),
                    GestureDetector(
                      onTap: _pickDate,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        decoration: _formBoxDecoration(),
                        child: Text(
                          selectedDate == null
                              ? 'Pilih tanggal'
                              : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    _formLabel('Jenis Sampah :'),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: _formBoxDecoration(),
                      child: DropdownButton<String>(
                        value: selectedType,
                        hint: const Text(
                          'Pilih Jenis sampah',
                          style: TextStyle(color: Colors.white70),
                        ),
                        dropdownColor: const Color(0xff2e4d5a),
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                        underline: const SizedBox(),
                        items: sampahTypes.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e, style: const TextStyle(color: Colors.white)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() => selectedType = value);
                        },
                      ),
                    ),

                    const SizedBox(height: 20),
                    _formLabel('Jumlah :'),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: amountController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: '0',
                              hintStyle:
                                  const TextStyle(color: Colors.white54),
                              filled: true,
                              fillColor: Colors.transparent,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Colors.white24),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Colors.white24),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        DropdownButton<String>(
                          value: selectedUnit,
                          dropdownColor: const Color(0xff2e4d5a),
                          style: const TextStyle(color: Colors.white),
                          underline: const SizedBox(),
                          icon: const Icon(Icons.arrow_drop_down,
                              color: Colors.white),
                          items: satuan.map((e) {
                            return DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() => selectedUnit = val!);
                          },
                        )
                      ],
                    ),

                    const SizedBox(height: 20),
                    _formLabel('Catatan (Opsional) :'),
                    TextField(
                      controller: noteController,
                      maxLines: 3,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Tambahkan catatan . . .',
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.transparent,
                        contentPadding: const EdgeInsets.all(12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.white24),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.white24),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // BUTTONS
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff57e47a),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Simpan',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white24),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text('Batal'),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _formLabel(String text) => Text(
        text,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      );

  Widget _sectionTitle(String text) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      );

  BoxDecoration _formBoxDecoration() => BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24),
      );
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:laundropool/models/pool_model.dart';
import 'package:laundropool/screens/home_screen.dart';
import 'package:laundropool/widgets/text_field_input.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../values/colors.dart';

class CreatePoolScreen extends StatefulWidget {
  const CreatePoolScreen({Key? key}) : super(key: key);

  @override
  State<CreatePoolScreen> createState() => _CreatePoolScreenState();
}

class _CreatePoolScreenState extends State<CreatePoolScreen> {
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _totalWeightController = TextEditingController();
  TextEditingController _availableSpaceController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  String _selectedService = "LAUNDROMAT";
  int day = DateTime.now().day;
  int month = DateTime.now().month;
  int year = DateTime.now().year;

  @override
  void initState() {
    fetchUser();
    super.initState();
  }

  void fetchUser() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _totalWeightController.dispose();
    _availableSpaceController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  var db = FirebaseFirestore.instance;

  addPoolToFirebase(Pool pool) async {
    var ref = await db.collection("pools").add(pool.toJson());
    await ref.update({"uid": ref.id});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const SizedBox(height: 32),
            Flexible(
              flex: 1,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "Create pool",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 32),
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
            const SizedBox(height: 36),
            Row(
              children: [
                Text(
                  "Let's create a pool!",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: AppColors().primaryColor),
                ),
                Expanded(child: Container()),
              ],
            ),
            const SizedBox(height: 4),
            const SizedBox(height: 12),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    const Text(
                      "Description",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    TextFieldInput(
                      svgImage: const Icon(Icons.edit_note),
                      hintText: "Description",
                      textInputType: TextInputType.text,
                      textEditingController: _descriptionController,
                      maxLines: 3,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Total weight",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 18),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: 140,
                              child: TextFieldInput(
                                svgImage: const Icon(Icons.monitor_weight),
                                hintText: "in KG",
                                textInputType: TextInputType.number,
                                textEditingController: _totalWeightController,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 32),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Available space",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 18),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: 140,
                              child: TextFieldInput(
                                svgImage: const Icon(Icons.monitor_weight),
                                hintText: "in KG",
                                textInputType: TextInputType.number,
                                textEditingController:
                                    _availableSpaceController,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Total Price",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 140,
                      child: TextFieldInput(
                        svgImage: const Icon(Icons.money),
                        hintText: "in ₹",
                        textInputType: TextInputType.number,
                        textEditingController: _priceController,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Laundary service",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    servicePicker(),
                    const SizedBox(height: 12),
                    const Text(
                      "Select date",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: const BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                        child: Text("$day/$month/$year"),
                      ),
                      onTap: () => DatePicker.showDatePicker(context,
                      minTime: DateTime.now(),
                          showTitleActions: true, onChanged: (date) {
                        setState(() {
                          day = date.day;
                          month = date.month;
                          year = date.year;
                        });
                      }),
                    ),
                  ],
                ),
              ),
              flex: 9,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors().primaryColorLightest,
        onPressed: () async {
          if (_descriptionController.text.isNotEmpty &&
              _totalWeightController.text.isNotEmpty &&
              _availableSpaceController.text.isNotEmpty &&
              _priceController.text.isNotEmpty &&
              (int.parse( _totalWeightController.text) > int.parse(_availableSpaceController.text))) {
            await addPoolToFirebase(
              Pool(
                uid: "",
                bio: _descriptionController.text,
                creator: Provider.of<UserProvider>(context, listen: false)
                    .getUser
                    .username,
                participants: {
                  Provider.of<UserProvider>(context, listen: false)
                          .getUser
                          .uid
                          .toString():
                      (int.parse(_totalWeightController.text) -
                          int.parse(_availableSpaceController.text)),
                },
                available_space: int.parse(_availableSpaceController.text),
                total_space: int.parse(_totalWeightController.text),
                laundary_service: _selectedService,
                day_of_month: day,
                month: month,
                year: year,
                price: int.parse(_priceController.text),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Congratulations! Pool created.")));
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: ((context) => const HomeScreen())));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill all fields appropriately")));
          }
        },
        label: const Text(
          "Create",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget servicePicker() {
    return Container(
      width: 240,
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: const BorderRadius.all(Radius.circular(4))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.room_service),
          ),
          const SizedBox(
            width: 4,
          ),
          DropdownButton<String>(
            value: _selectedService,
            items: <String>[
              "LAUNDROMAT",
              // "POWER LAUNDARY",
              // "TRUE COLORS",
              // "LAXMI"
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedService = newValue!;
              });
            },
          ),
        ],
      ),
    );
  }
}

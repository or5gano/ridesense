import 'package:flutter/material.dart';
import 'MapScreen.dart';

class Home extends StatefulWidget {
  static const String id = '/home';

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();  
  final TextEditingController _locationController = TextEditingController();  

   @override
  void dispose() {
    _locationController.dispose();  
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 18, top: 120, right: 18),
        child: Form(
          key: _formKey,  
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Location (City, Address, Coordinates)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
              ),
              SizedBox(height: 25),
             ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapScreen(
                          location: _locationController.text,
                        ),
                      ),
                    );
                  }
                },
                child: Text('Submit'),
              ),
              Image.asset('assets/images/map.png',),
            ],
          ),
        ),
      ),
    );
  }
}
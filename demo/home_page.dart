import 'package:flutter/material.dart';
import 'package:getxdemo/custom_textfield.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final emailcontroller = TextEditingController();
  final passcontroller = TextEditingController();
  final searchController = TextEditingController();

  final _key = GlobalKey<FormState>();

  bool _searchEnable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: _searchEnable
            ? SizedBox(
                height: 40,
                child: SearchBar(
                  onSubmitted: (val) {},
                  onTapOutside: (event) {},
                  controller: searchController,
                  elevation: const WidgetStatePropertyAll(12),
                  hintText: "Search",
                  textStyle: const WidgetStatePropertyAll(
                    TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  hintStyle: const WidgetStatePropertyAll(
                    TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: const WidgetStatePropertyAll(
                    Colors.white24,
                  ),
                  trailing: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _searchEnable = !_searchEnable;
                        });
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            : Text(
                widget.title,
                style: const TextStyle(color: Colors.white),
              ),
        actions: _searchEnable
            ? []
            : [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _searchEnable = !_searchEnable;
                    });
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const CircleAvatar(
                    radius: 14,
                    child: Text("A"),
                  ),
                ),
              ],
      ),
      body: Form(
        key: _key,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(22),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                  controller: emailcontroller,
                  labelText: 'Email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email field cannot be empty';
                    }
                    const emailPattern =
                        r'^[a-zA-Z0-9.a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
                    final regex = RegExp(emailPattern);
                    if (!regex.hasMatch(value)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  controller: passcontroller,
                  labelText: 'Password',
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password field cannot be empty';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters long';
                    }
                    const passwordPattern =
                        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
                    final regex = RegExp(passwordPattern);
                    if (!regex.hasMatch(value)) {
                      return 'Password must include uppercase, lowercase, number, and special character';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                // const CustomButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

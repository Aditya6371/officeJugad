import 'package:flutter/material.dart';
import 'package:getxdemo/custom_textfield.dart';
import 'package:fast_rsa/fast_rsa.dart';

//flutter pub add fast_rsa

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

  bool _searchEnable = false;
  String message = 'Test for encrypt/decrypt RSA';

  var privateKey = '''-----BEGIN RSA PRIVATE KEY-----
MIICXQIBAAKBgQCmIyo8x9PuWa7GasppkFlhwcTEo4w5L5OPlBm00HG+rovf9cCN
S35HBrmK0KSWximOFEzvqaDyQc/G9HEZse7IxOLCOHv5w2aNdkZ/kW/BolIqAiWF
7cU9HbcNqr2UqT3L40no/IKUoMxSmdUu0Li9YD31XOpj25d8KmbC/HR/XwIDAQAB
AoGAPX6SqcDFf1oOyT7KAVz+2KJidO6cfqZPljuZcEYfdBcjixhp12L0MNIaZ3ln
Eq/yvbZh6+v7uPAHOntMSdiEq41+YwV2lLPCZNyOTEyAxIyQzH95UZmjF+/egpZD
dqg2+AAZt7btTpuQZI1X7RbfThlEPTkEt69M4n9qWWotb8ECQQDuXh9YgJemskha
ZxxDyyp1w/0rcJQV+nEPGi2En3dt6SRAc3mdCwvP3G8bOv6oiMWlB8WVXGyuTe9y
RlKHLXGRAkEAsm0+ryq+jgNZZztBVabxftsz0nH71lmAkf7jmikJoJUMXadZObfE
KISqrcUoAGBgKPDDLHGnhWErf/QbZMNp7wJBAJZtwdxpcssZcf3TWowSGB6v7ALR
DjN8lIMSYy1yMb2kR2OBPHt2MCMimt+VcIbNoeWPLQsgg9nQh08XwBdc/3ECQGLR
Lg5FVhPAtxr9LkoJk2X2cNT0W81y9EnnKJaQc8yDv71+mWPl6rWmBAEJWAYdWiRS
c0WCDI1KK5VJ1IIR1/ECQQCeVTiNS77HTDY8ytnBff7/tP8IOyQV/t3Vo7H2Yyte
0p/rYuahDzIbNsLplnrFFv/DsyMEOalJJAh857dBliFp
-----END RSA PRIVATE KEY-----''';

  var publicKey = '''-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCmIyo8x9PuWa7GasppkFlhwcTE
o4w5L5OPlBm00HG+rovf9cCNS35HBrmK0KSWximOFEzvqaDyQc/G9HEZse7IxOLC
OHv5w2aNdkZ/kW/BolIqAiWF7cU9HbcNqr2UqT3L40no/IKUoMxSmdUu0Li9YD31
XOpj25d8KmbC/HR/XwIDAQAB
-----END PUBLIC KEY-----''';

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
        child: Container(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              CustomTextField(
                controller: emailcontroller,
                labelText: 'Enter Text to be encrypt',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email field cannot be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                title: const Text(
                  "ENCRYPT",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_key.currentState!.validate()) {
                    var result = await RSA.encryptPKCS1v15(
                        emailcontroller.text, publicKey);
                    message = result;
                    print(message);
                    setState(() {});
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                title: const Text(
                  "DECRYPT",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_key.currentState!.validate()) {
                    var result = await RSA.decryptPKCS1v15(message, privateKey);
                    message = result;
                    print(message);
                    setState(() {});
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Text(message),
            ],
          ),
        ),
      ),
    );
  }
}

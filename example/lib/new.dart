import 'package:accessibly/accessibly.dart';
import 'package:accessibly/accessibility_screen.dart';
import 'package:accessibly/widget/accessible_heading_text.dart';
import 'package:accessibly/widget/accessible_text.dart';
import 'package:accessibly/widget/accessiblity_image.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Accessibly>(
      builder: (context, accessibly, _) {
        return Scaffold(
          backgroundColor: accessibly.textBgColor,
          appBar: AppBar(
            title: const Text('Accessibly Features'),
            actions: [
              Builder(
                // Wrap the IconButton with Builder widget
                builder: (context) => IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    // Use the context from the Builder
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AccessiblyScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const AccessiblyHeadingText(
                  "Hello This is Accessibly...",
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(height: 20),
                const AccessiblyText(
                  "This is a simple text widget",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {},
                    child: const AccessiblyText(
                      "This is a button",
                      style: TextStyle(fontSize: 20),
                    )),
                const AccessiblyImage(
                  image: AssetImage('assets/hello.png'),
                  width: 200,
                  height: 250,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  colorBlendMode: BlendMode.colorBurn,
                  filterQuality: FilterQuality.high,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

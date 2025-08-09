import 'package:flutter/material.dart';

void main() {
  runApp(const BasicFeaturesApp());
}

class BasicFeaturesApp extends StatefulWidget {
  const BasicFeaturesApp({super.key});

  @override
  State<BasicFeaturesApp> createState() => _BasicFeaturesAppState();
}

class _BasicFeaturesAppState extends State<BasicFeaturesApp> {
  bool isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Enhanced Basic Features Demo',
      theme: isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      home: HomeScreen(
        toggleTheme: () {
          setState(() {
            isDarkTheme = !isDarkTheme;
          });
        },
        isDarkTheme: isDarkTheme,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkTheme;

  const HomeScreen({super.key, required this.toggleTheme, required this.isDarkTheme});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String displayedText = 'Welcome to the Enhanced Features App!';
  final TextEditingController inputController = TextEditingController();
  String inputText = '';
  int counter = 0;
  final List<String> items = ['Item 1', 'Item 2', 'Item 3'];

  // For checkbox list
  final Map<String, bool> checkedItems = {
    'Option 1': false,
    'Option 2': false,
    'Option 3': false,
  };

  // For slider
  double sliderValue = 50;

  void updateText() {
    setState(() {
      displayedText = inputText.isEmpty
          ? 'Please enter some text!'
          : 'Text changed! You typed: $inputText';
    });
  }

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void updateInput(String value) {
    setState(() {
      inputText = value;
    });
  }

  void resetAll() {
    setState(() {
      displayedText = 'Welcome to the Enhanced Features App!';
      inputController.clear();
      inputText = '';
      counter = 0;
      sliderValue = 50;
      for (var key in checkedItems.keys) {
        checkedItems[key] = false;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Reset all values')),
    );
  }

  void navigateToSecondScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SecondScreen()),
    );
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enhanced Features Demo'),
        actions: [
          IconButton(
            icon: Icon(widget.isDarkTheme ? Icons.wb_sunny : Icons.nightlight_round),
            tooltip: 'Toggle Theme',
            onPressed: widget.toggleTheme,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset All',
            onPressed: resetAll,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              displayedText,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: inputController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Type something',
              ),
              onChanged: updateInput,
            ),
            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: updateText,
              child: const Text('Update Text'),
            ),
            const SizedBox(height: 20),

            Text(
              'Counter: $counter',
              style: const TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: incrementCounter,
              child: const Text('Increment Counter'),
            ),
            const SizedBox(height: 20),

            const Text(
              'Items List:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) => ListTile(
                  leading: const Icon(Icons.star),
                  title: Text(items[index]),
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Checkbox List:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...checkedItems.keys.map((key) {
              return CheckboxListTile(
                title: Text(key),
                value: checkedItems[key],
                onChanged: (val) {
                  setState(() {
                    checkedItems[key] = val ?? false;
                  });
                },
              );
            }).toList(),
            const SizedBox(height: 20),

            const Text(
              'Slider Value:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: sliderValue,
              min: 0,
              max: 100,
              divisions: 100,
              label: sliderValue.round().toString(),
              onChanged: (value) {
                setState(() {
                  sliderValue = value;
                });
              },
            ),
            Text(
              sliderValue.toStringAsFixed(1),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),

            Image.network(
              'https://flutter.dev/assets/images/shared/brand/flutter/logo/flutter-lockup.png',
              height: 60,
            ),
            const SizedBox(height: 10),

            const Icon(
              Icons.flutter_dash,
              size: 50,
              color: Colors.blue,
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: navigateToSecondScreen,
              child: const Text('Go to Second Screen'),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Go Back'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

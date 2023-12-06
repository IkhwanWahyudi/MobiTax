// setting.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'themeModeData.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    ThemeData selectedTheme = Provider.of<ThemeModeData>(context).getTheme();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white, // Ganti warna sesuai keinginan Anda
        ),
        backgroundColor: selectedTheme.primaryColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          RadioListTile(
            title: const Text('Hijau'),
            value: ThemeModeOption.green,
            groupValue: Provider.of<ThemeModeData>(context).selectedOption,
            onChanged: (value) {
              Provider.of<ThemeModeData>(context, listen: false).setThemeModeOption(value!);
            },
          ),
          RadioListTile(
            title: const Text('Kuning'),
            value: ThemeModeOption.yellow,
            groupValue: Provider.of<ThemeModeData>(context).selectedOption,
            onChanged: (value) {
              Provider.of<ThemeModeData>(context, listen: false).setThemeModeOption(value!);
            },
          ),
          RadioListTile(
            title: const Text('Biru'),
            value: ThemeModeOption.blue,
            groupValue: Provider.of<ThemeModeData>(context).selectedOption,
            onChanged: (value) {
              Provider.of<ThemeModeData>(context, listen: false).setThemeModeOption(value!);
            },
          ),
        ],
      ),
    );
  }
}

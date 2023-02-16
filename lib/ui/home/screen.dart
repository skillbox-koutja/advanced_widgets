import 'package:advanced_widgets/core/utils/extensions/build_context_ext.dart';
import 'package:advanced_widgets/ui/text_decoration/text_decoration.dart';
import 'package:advanced_widgets/ui/weather/indicator.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback toLight;
  final VoidCallback toDark;

  const HomeScreen({
    required this.toLight,
    required this.toDark,
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double cloudiness = 0.5;
  bool maximizeView = false;

  @override
  Widget build(BuildContext context) {
    final themeMode = context.themeViewModel.themeMode;
    final themeColors = context.themeColors;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: themeMode == ThemeMode.light ? widget.toDark : widget.toLight,
            icon: themeMode == ThemeMode.light ? const Icon(Icons.light_mode) : const Icon(Icons.dark_mode),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Slider(
              value: cloudiness,
              divisions: 10,
              label: cloudiness.toString(),
              onChanged: (value) {
                setState(() {
                  cloudiness = value;
                });
              },
            ),
            Expanded(
              child: Stack(
                children: [
                  AnimatedPositioned(
                    top: maximizeView ? 50 : 0,
                    right: maximizeView ? MediaQuery.of(context).size.width / 2 - 100 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          maximizeView = !maximizeView;
                        });
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox.square(
                            dimension: maximizeView ? 200 : 50,
                            child: CustomPaint(
                              painter: WeatherIndicator(
                                cloudiness: cloudiness,
                                colors: themeColors,
                              ),
                            ),
                          ),
                          if (maximizeView)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25.0),
                              child: InnerShadowText(
                                child: Text(
                                  'Облачно,\n12 градусов',
                                  style: Theme.of(context).textTheme.headlineSmall,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

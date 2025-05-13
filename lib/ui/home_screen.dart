import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/ui/errorView.dart';
import 'package:weather_app/ui/initalViewScreen.dart';
import 'package:weather_app/ui/widgets/weatherDashbord.dart';
import '../cubit/weather_cubit.dart';
import '../cubit/weather_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate splash screen delay
    Future.delayed(const Duration(seconds: 3), () {
      // Load weather data
      context.read<WeatherCubit>().fetchByLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF242834),
      body: SafeArea(
        child: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            // Always show splash screen first
            if (state is WeatherInitial) {
              return SplashScreen();
            } else if (state is WeatherLoading) {
              return const LoadingView();
            } else if (state is WeatherLoaded) {
              return WeatherDashboard(
                city: state.city,
                temperature: state.currentTemp,
                condition: state.currentCondition,
              );
            } else if (state is WeatherError) {
              return ErrorView(message: state.message);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            "assets/loading.json",
            width: 300,
            height: 300,
            fit: BoxFit.fill,
            repeat: true,
            frameRate: FrameRate.max,
          ),
          const SizedBox(height: 20),
          const Text(
            "Weather App",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        "assets/loading.json",
        width: 300,
        height: 300,
        fit: BoxFit.fill,
        repeat: true,
        frameRate: FrameRate.max,
      ),
    );
  }
}

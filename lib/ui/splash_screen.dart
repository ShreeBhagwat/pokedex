import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pokedex/data/modals/pokemon.dart';
import 'package:pokedex/data/networking/dio_client.dart';
import 'package:pokedex/utils/constant.dart';

import '../repo/pokemon_repo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

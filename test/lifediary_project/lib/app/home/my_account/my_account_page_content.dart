import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifediary_project/app/cubit/root_cubit.dart';
import 'package:lifediary_project/app/home/to_do_list/to_do_list_content.dart';
import 'package:lifediary_project/app/instruction/instruction_page.dart';
import 'package:lifediary_project/app/login/login_page.dart';
import 'package:lifediary_project/app/login/user_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAccountPageContent extends StatelessWidget {
  const MyAccountPageContent({
    Key? key,
    required this.email,
  }) : super(key: key);

  final String? email;

  LoginPage moveToLogin() {
    return LoginPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'USER PAGE',
          style: GoogleFonts.lato(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/math.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Zalogowano jako $email! ',
                  style: GoogleFonts.lato(
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                      fontSize: 19),
                ),
                const SizedBox(height: 100),
                ElevatedButton.icon(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  icon: const Icon(Icons.person, color: Colors.amber),
                  label: Text('Panel użytkownika'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserProfile()),
                    );
                  },
                ),
                ElevatedButton.icon(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  icon: const Icon(Icons.pageview, color: Colors.amber),
                  label: Text('Instrukcja obsługi'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InstructionPage()),
                    );
                  },
                ),
                const SizedBox(height: 100),
                ElevatedButton(
                    onPressed: () {
                      context.read<RootCubit>().signOut();
                    },
                    child: const Text('Wyloguj')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


import 'package:expensetracker/expense_tracker/expence_tracker_app.dart';
import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,

        /// Primary colors
        primaryColor: Colors.deepPurple,
        primarySwatch: Colors.deepPurple,

        /// Backgrounds
        scaffoldBackgroundColor: const Color(0xFFF5F6FA),

        // AppBar
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFEDE7F6),
          foregroundColor: Colors.deepPurple,
          elevation: 1,
        ),


        /// Floating action button
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.purple.shade100,
            foregroundColor: Colors.deepPurple,
            shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(50))
        ),

        /// Cards
        cardColor: Colors.white,

        /// Text
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black87),
          bodyMedium: TextStyle(color: Colors.black54),
          titleLarge: TextStyle(color: Colors.black),
        ),

        /// Icons
        iconTheme: const IconThemeData(color: Colors.black54),

        /// Divider
        dividerColor: Colors.black12,

        /// Buttons
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        /// Inputs
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.deepPurple),
          ),
        ),

        /// List Tile Theme
        listTileTheme: ListTileThemeData(
          tileColor: const Color(0xFFF3EEFC), // soft purple tint
          textColor: Colors.black87,
          iconColor: Colors.deepPurple.shade400,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),


      ),





      /// Dark Theme
      darkTheme: ThemeData(
        brightness: Brightness.dark,

        /// Primary colors
        primaryColor: Colors.deepPurple,
        primarySwatch: Colors.deepPurple,

        /// Backgrounds
        scaffoldBackgroundColor: const Color(0xFF121212),

        dialogTheme: DialogThemeData(
            backgroundColor: Color(0xFF121212)
        ),

        /// AppBar
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1F1B24),
          foregroundColor: Colors.white,
          elevation: 1,
        ),

        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Color(0xFF3D3552),
            foregroundColor: Colors.white70,
            shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(50))
        ),

        /// Cards
        cardColor: const Color(0xFF1E1E1E),

        /// tile
        listTileTheme: ListTileThemeData(
            tileColor: Color(0xFF1F1B24),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
            )
        ),

        /// Text
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
          titleLarge: TextStyle(color: Colors.white),
        ),

        /// Icons
        iconTheme: const IconThemeData(color: Colors.white70),

        /// Divider
        dividerColor: Colors.white24,

        /// Buttons
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        /// Inputs
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF1E1E1E),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.deepPurple),
          ),
        ),

      ),

      home: ExpenseTrackerApp(

      ),
    );
  }
}


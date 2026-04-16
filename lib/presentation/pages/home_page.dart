import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/constants.dart';
import '../providers/lottery_provider.dart';
import 'results_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lotteryProvider = context.watch<LotteryProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Custom Header
          _buildHeader(lotteryProvider),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Pick Your Numbers Card
                  _buildPickNumbersCard(lotteryProvider),
                  
                  const SizedBox(height: 25),
                  
                  // Your Numbers Section
                  Row(
                    children: [
                      Text(
                        'Your Numbers',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF001F5B),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(child: Divider(thickness: 1, color: Color(0xFFEEEEEE))),
                    ],
                  ),
                  const SizedBox(height: 15),
                  _buildSelectedNumbers(lotteryProvider),
                  
                  const SizedBox(height: 25),
                  const Divider(thickness: 1, color: Color(0xFFEEEEEE)),
                  const SizedBox(height: 20),
                  
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: _buildActionButton(
                          text: 'Buy Ticket',
                          color: const Color(0xFFFBC02D),
                          textColor: const Color(0xFF001F5B),
                          onPressed: lotteryProvider.selectedNumbers.length == 5
                              ? () {
                                  lotteryProvider.play();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const ResultsPage()),
                                  );
                                }
                              : null,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: _buildActionButton(
                          text: 'View Results',
                          color: const Color(0xFF1E56D1),
                          textColor: Colors.white,
                          onPressed: () {
                            if (lotteryProvider.winningNumbers != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ResultsPage()),
                              );
                            } else if (lotteryProvider.selectedNumbers.length == 5) {
                                lotteryProvider.play();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const ResultsPage()),
                                );
                            } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Please select 5 numbers to play first!')),
                                );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primaryBlue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.arrow_circle_right_outlined), label: 'Results'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildHeader(LotteryProvider provider) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 60, bottom: 25, left: 25, right: 25),
      decoration: const BoxDecoration(
        color: AppColors.primaryBlue,
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: Text(
                  'Hello, User 👋',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.notifications, color: Colors.white, size: 28),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF1540A1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                const Icon(Icons.pie_chart, color: Colors.white70, size: 20),
                const SizedBox(width: 10),
                Text(
                  'Wallet Balance: ',
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
                ),
                Text(
                  '\$${provider.walletBalance.toStringAsFixed(2)}',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPickNumbersCard(LotteryProvider provider) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pick Your Numbers',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF001F5B),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 8,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: 32,
            itemBuilder: (context, index) {
              int number = index + 1;
              
              final isSelected = provider.selectedNumbers.contains(number);
              return GestureDetector(
                onTap: () => provider.toggleNumber(number),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primaryBlue : const Color(0xFFF5F7FA),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.withOpacity(0.1)),
                    boxShadow: [
                      if (!isSelected)
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                    ],
                  ),
                  child: Text(
                    '$number',
                    style: GoogleFonts.poppins(
                      color: isSelected ? Colors.white : const Color(0xFF001F5B),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedNumbers(LotteryProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: provider.selectedNumbers.isEmpty 
        ? [Text('None selected', style: GoogleFonts.poppins(color: Colors.grey))]
        : provider.selectedNumbers.map((n) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: 48,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: const RadialGradient(
                  colors: [Color(0xFFFFDF73), Color(0xFFE89A00)],
                  center: Alignment(-0.3, -0.3),
                  radius: 0.8,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 4,
                    offset: const Offset(0, 3),
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    blurRadius: 1,
                    spreadRadius: -1,
                    offset: Offset(-1, -1),
                  ),
                ],
              ),
              child: Text(
                '$n',
                style: const TextStyle(
                  color: Colors.white, 
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  shadows: [
                    Shadow(
                      color: Colors.black26, 
                      offset: Offset(0, 1), 
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildActionButton({
    required String text,
    required Color color,
    required Color textColor,
    VoidCallback? onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        disabledBackgroundColor: color.withOpacity(0.5),
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

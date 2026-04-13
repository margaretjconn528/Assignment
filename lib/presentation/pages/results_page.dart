import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../core/constants.dart';
import '../providers/lottery_provider.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final lotteryProvider = context.watch<LotteryProvider>();
    final winningNumbers = lotteryProvider.winningNumbers ?? [1, 2, 3, 4, 5];
    final selectedNumbers = lotteryProvider.selectedNumbers.isEmpty ? [1, 2, 3, 4, 30] : lotteryProvider.selectedNumbers;
    bool isWinner = lotteryProvider.isWinner;
    if (lotteryProvider.winningNumbers == null) {
      isWinner = selectedNumbers.length == winningNumbers.length &&
          selectedNumbers.every((n) => winningNumbers.contains(n));
    }
    final date = DateTime.now();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF1E56D1), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Latest Results',
          style: GoogleFonts.poppins(
            color: const Color(0xFF001F5B),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(color: Colors.grey.withOpacity(0.2), height: 1),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Text(
              'Winning Numbers',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF001F5B),
              ),
            ),
            const SizedBox(height: 20),
            _buildWinningNumbersRow(winningNumbers),
            const SizedBox(height: 12),
            Text(
              DateFormat('MMMM dd, yyyy').format(date),
              style: GoogleFonts.poppins(color: const Color(0xFF7B8BB2), fontSize: 14),
            ),
            const SizedBox(height: 20),
            Divider(color: Colors.grey.withOpacity(0.2)),
            const SizedBox(height: 20),
            Text(
              'Your Numbers',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF001F5B),
              ),
            ),
            const SizedBox(height: 20),
            _buildYourNumbersRow(selectedNumbers, winningNumbers),
            const SizedBox(height: 40),
            Divider(color: Colors.grey.withOpacity(0.2)),
            const SizedBox(height: 30),
            
            // Result Status
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isWinner ? const Color(0xFF4CAF50) : Colors.red,
                shape: BoxShape.circle,
              ),
              child: Icon(isWinner ? Icons.check : Icons.close, color: Colors.white, size: 35),
            ),
            const SizedBox(height: 20),
            Text(
              isWinner ? 'Congratulations! You Win!' : 'Better Luck Next Time!',
              style: GoogleFonts.poppins(
                color: isWinner ? const Color(0xFF2E7D32) : Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                lotteryProvider.resetGame();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E56D1),
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: Text(
                'Play Again',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildWinningNumbersRow(List<int> numbers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(numbers.length, (index) {
        final n = numbers[index];
        // Match the image where the 3rd number is gold
        final bool isGold = index == 2; 
        
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: 50,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isGold 
                  ? [const Color(0xFFF9A825), const Color(0xFFFFD54F)]
                  : [const Color(0xFF1E56D1), const Color(0xFF448AFF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: (isGold ? Colors.orange : Colors.blue).withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            ]
          ),
          child: Text(
            '$n'.padLeft(2, '0'),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        );
      }),
    );
  }

  Widget _buildYourNumbersRow(List<int> selected, List<int> winning) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(selected.length, (index) {
        final n = selected[index];
        
        Color? bgColor;
        Color textColor = const Color(0xFF001F5B);
        BoxBorder? border;
        List<BoxShadow>? shadows;

        if (winning.contains(n)) {
          bgColor = const Color(0xFF1E56D1);
          textColor = Colors.white;
          shadows = [
            BoxShadow(
              color: Colors.blue.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ];
        } else {
          bgColor = Colors.white;
          border = Border.all(color: Colors.grey.withOpacity(0.2), width: 1.5);
          shadows = [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ];
        }

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: 50,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
            border: border,
            boxShadow: shadows,
          ),
          child: Text(
            '$n'.padLeft(2, '0'),
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        );
      }),
    );
  }
}

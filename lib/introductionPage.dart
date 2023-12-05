import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mobi_tax/sign_in.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({Key? key});

  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroductionComplete() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignIn()),
    );
  }

  void _onIntroductionSkip() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignIn()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Theme(
        data: ThemeData.light(),
        child: IntroductionScreen(
          dotsDecorator: const DotsDecorator(
            size: Size(10.0, 10.0),
            color: Colors.black, // Warna default indikator
            activeColor: Color.fromRGBO(70, 152, 138,
                1), // Warna indikator aktif (yang menunjukkan halaman saat ini)
          ),
          showSkipButton: true,
          skip: const Text(
            "Skip",
            style: TextStyle(
              color: Color.fromRGBO(70, 152, 138, 1),
            ),
          ),
          next: const Text(
            "Next",
            style: TextStyle(
              color: Color.fromRGBO(70, 152, 138, 1),
            ),
          ),
          done: const Text(
            "Finish",
            style: TextStyle(
              color: Color.fromRGBO(70, 152, 138, 1),
            ),
          ),
          onDone: _onIntroductionComplete,
          onSkip: _onIntroductionSkip,
          pages: [
            PageViewModel(
              title: "Comply with Vehicle Tax Payment",
              body:
                  "Discover various vehicle tax payment options to fulfill your obligation.",
              image: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'assets/tax.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              decoration: const PageDecoration(
                pageColor: Colors.white,
              ),
            ),
            PageViewModel(
              title: "Track Payment History",
              body:
                  "Effortlessly track and manage your payment history for better financial planning.",
              image: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'assets/history.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              decoration: const PageDecoration(
                pageColor: Colors.white,
              ),
            ),
            PageViewModel(
              title: "Join Us in Tax Compliance",
              body:
                  "Be a responsible citizen. Pay your taxes on time and contribute to the nation's development.",
              image: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'assets/citizen.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              decoration: const PageDecoration(
                pageColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

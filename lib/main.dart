import 'package:flutter/material.dart';
import 'package:conversor_moeda_jpvp/homeScreen.dart';
import 'package:conversor_moeda_jpvp/get/LoadStart.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MyApp());
}

// Você também pode testar com seus próprios IDs de bloco de anúncios registrando seu dispositivo como um
// dispositivo de teste. Verifique os registros para o valor de ID do seu dispositivo.
const String testDevice = 'ce1a84c0-11b0-48c9-8e28-406e05dd7fbe';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversor Online de Moedas',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: ConversorApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ConversorApp extends StatefulWidget {
  @override
  _ConversorAppState createState() => _ConversorAppState();
}

class _ConversorAppState extends State<ConversorApp> {
//INÍCIO RODAPÉ - BANNER
  BannerAd _bannerRodape;

  @override
  void initState() {
    super.initState();
    _bannerRodape = BannerAd(
      adUnitId: 'ca-app-pub-9464403316889483/1694332185',
      size: AdSize.banner,
      request: AdRequest(),
      listener: AdListener(
        // Chamada quando um anúncio é recebido com sucesso.
        onAdLoaded: (Ad ad) => print('Ad Banner loaded.'),
        // Chamada quando uma solicitação de anúncio falha.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Ad Banner  failed to load: $error');
        },
        // Chamada quando um anúncio abre uma sobreposição que cobre a tela.
        onAdOpened: (Ad ad) => print('Ad Banner  opened.'),
        // Chamada quando um anúncio remove uma sobreposição que cobre a tela.
        onAdClosed: (Ad ad) => print('Ad Banner  closed.'),
        // Chamada quando um anúncio está saindo do aplicativo.
        onApplicationExit: (Ad ad) => print('Left application.'),
      ),
    );

    _bannerRodape?.load();
  }

  @override
  void dispose() {
    super.dispose();
    _bannerRodape?.dispose();
    _bannerRodape = null;
  }

//FIM RODAPÉ BANNER

  var screens = [
    LoadStart(), // 0
    HomeScreen(), // 1
    //CardScreen(), // 2
  ]; // TELA PARA CADA GUIA

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final AdWidget adWidget = AdWidget(ad: _bannerRodape);
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 245, 248, 1),
      bottomNavigationBar: Container(
        child: Container(
          alignment: Alignment.center,
          child: adWidget,
          width: _bannerRodape.size.width.toDouble(),
          height: _bannerRodape.size.height.toDouble(),
        ),
        color: Color.fromRGBO(243, 245, 248, 1),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: screens[selectedTab],
    );
  }
}

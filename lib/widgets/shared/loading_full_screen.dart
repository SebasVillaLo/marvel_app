import 'package:flutter/material.dart';

class LoadingFullScreen extends StatelessWidget {
  const LoadingFullScreen({super.key});

  Stream<String> getLoadingMessages() {
    final message = <String>[
      'Cargando comics',
      'Ya mero...',
      'Esto esta tardando mas de lo esperado :('
    ];
    return Stream.periodic(const Duration(milliseconds: 1200), (step) {
      return message[step];
    }).take(message.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Expere por favor'),
          const SizedBox(
            height: 10,
          ),
          const CircularProgressIndicator(
            strokeWidth: 2,
          ),
          const SizedBox(
            height: 10,
          ),
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Cargando...');

              return Text(snapshot.data!);
            },
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'models/post_model.dart';
import 'services/post_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cliente Dio Avanzado',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PostScreen(),
    );
  }
}

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late Future<Post> _postFuture;
  final PostService _postService = PostService();

  @override
  void initState() {
    super.initState();
    _postFuture = _postService.getPostDetail();
  }

  void _reloadPost() {
    setState(() {
      _postFuture = _postService.getPostDetail();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consumo Dio & Interceptores'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _reloadPost,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<Post>(
          future: _postFuture,
          builder: (context, snapshot) {
            // Estado 1: Cargando datos
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Consultando endpoint...'),
                  ],
                ),
              );
            }

            // Estado 2: Error capturado (Manejo Defensivo)
            if (snapshot.hasError) {
              final errorMessage = snapshot.error.toString().replaceAll('Exception: ', '');
              return Center(
                child: Card(
                  color: Colors.red.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.wifi_off_rounded, color: Colors.red, size: 48),
                        const SizedBox(height: 12),
                        Text(
                          'Ocurrió un error',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade900,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          errorMessage,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _reloadPost,
                          child: const Text('Reintentar'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            // Estado 3: Respuesta Exitosa
            if (snapshot.hasData) {
              final post = snapshot.data!;
              return Center(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Chip(
                              label: Text('Post #${post.id}'),
                              backgroundColor: Colors.deepPurple.shade50,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          post.title,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const Divider(height: 24),
                        Text(
                          post.body,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            return const Center(child: Text('Sin datos disponibles'));
          },
        ),
      ),
    );
  }
}
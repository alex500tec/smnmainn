import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smn/models/modelo_municipio.dart';
import 'package:smn/providers/provider_municipio.dart';
import 'package:smn/utils/favoritos.dart';

class PaginaFavoritos extends StatefulWidget {
  const PaginaFavoritos({super.key});

  @override
  State<PaginaFavoritos> createState() => _PaginaFavoritosState();
}

class _PaginaFavoritosState extends State<PaginaFavoritos> {
  List<ModeloMunicipio> favoritos = [];

  @override
  void initState() {
    super.initState();
    _cargarFavoritos();
  }

  Future<void> _cargarFavoritos() async {
    final lista = await Favoritos.obtenerFavoritos();
    setState(() {
      favoritos = lista;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alexandro Mejía Sánchez'),
      ),
      body: favoritos.isEmpty
          ? Center(child: Text('No tienes municipios favoritos'))
          : ListView.builder(
              itemCount: favoritos.length,
              itemBuilder: (context, index) {
                final municipio = favoritos[index];
                return ListTile(
                  title: Text(municipio.label),
                  subtitle: Text('Estado ID: ${municipio.idEdo}, Municipio ID: ${municipio.idMpo}'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () async {
                    // Actualiza el municipio activo en el ProviderMunicipio
                    await Provider.of<ProviderMunicipio>(context, listen: false)
                        .setCiudad(
                          context,
                          nombre: municipio.label,
                          IdEdo: municipio.idEdo,
                          IdMpo: municipio.idMpo,
                        );

                    // Vuelve a la pantalla principal (que reacciona al cambio)
                    Navigator.pop(context);
                  },
                );
              },
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smn/providers/provider_lista_municipios.dart';

class BuscarMunicipio extends StatefulWidget {
  const BuscarMunicipio({super.key});

  @override
  State<BuscarMunicipio> createState() => _BuscarMunicipioState();
}

class _BuscarMunicipioState extends State<BuscarMunicipio> {
  final TextEditingController _controlador_de_mi_caja_de_texto =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProviderListaMunicipios>(context, listen: false)
          .cargaMunicipios();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buscando Municipio"),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 16,
            ),
            child: TextField(
              controller: _controlador_de_mi_caja_de_texto,
              onChanged: (texto) {
                Provider.of<ProviderListaMunicipios>(context, listen: false)
                    .filtrarMunicipios(texto);
              },
            ),
          ),
          Expanded(
            child: Consumer<ProviderListaMunicipios>(
              builder: (context, proveedor_del_municipio, child) {
                if (proveedor_del_municipio.estaCargando) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                  itemCount:
                      proveedor_del_municipio.listaDeMunicipiosFiltrada.length,
                  itemBuilder: (context, index) {
                    final municipio = proveedor_del_municipio
                        .listaDeMunicipiosFiltrada[index];

                    return ListTile(
                      onTap: () => print(municipio.label),
                      title: Text(municipio.label),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

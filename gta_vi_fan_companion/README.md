# GTA VI - Vice City

Pantalla Flutter con tres controles visuales, basada en el diseño acordado.

## Componentes

- ControlLuna, creado para este proyecto. El slider mueve el indicador lunar entre seis fases.
- SelectorProtagonistas, integrado desde la rama pablo-protagonistas del repositorio del equipo. Permite alternar entre Lucía y Jason.
- GtaSelectorCard, integrado desde la rama Ramilla. Permite seleccionar el GTA favorito del I al VI.

Los dos componentes del equipo se conservan como paquetes locales. La app los importa desde packages y no copia sus clases dentro de la aplicación.

## Estructura

- lib/main.dart: pantalla que combina los componentes.
- packages/control_luna: componente propio, documentación y prueba.
- packages/protagonistas_gta: componente de protagonistas y su prueba original.
- packages/gta_selector_card: selector de entregas y su prueba original.

## Ejecutar

Desde la raíz, ejecuta flutter pub get y después flutter run. La prueba de integración se ejecuta con flutter test. Cada paquete tiene su propia prueba; ejecútala desde la carpeta del paquete correspondiente.

## Defensa

La pantalla guarda la fase lunar y el protagonista activo. ControlLuna devuelve el número de fase con onChanged; SelectorProtagonistas devuelve el personaje seleccionado; GtaSelectorCard cambia el resaltado y comunica el índice. La app actualiza el estado o muestra un aviso para cada interacción.

# Paquete gta_selector_card

Selector circular que permite elegir la entrega de GTA favorita.

## Propiedades

- options: lista de opciones; por defecto, I, II, III, IV, V y VI.
- initialIndex: índice seleccionado al inicio; por defecto, 5 (GTA VI).
- barraAzul: color del acento del título.
- rosa: color de la opción seleccionada.
- degradadoInicial y degradadoFinal: colores de fondo de la tarjeta.
- circuloVacio: fondo de las opciones sin seleccionar.
- onChanged: callback opcional que recibe el índice elegido.

## Funcionamiento

Al tocar un círculo, cambia el resaltado y la etiqueta muestra el GTA elegido. El componente llama a onChanged con su índice, empezando desde cero.

## Prueba

Desde esta carpeta, ejecutar flutter test. La prueba selecciona GTA III, comprueba la etiqueta y verifica que el callback recibe el índice 2.

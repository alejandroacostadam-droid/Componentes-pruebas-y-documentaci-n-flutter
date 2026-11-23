# Paquete control_luna

Componente propio: una luna que se desplaza y cambia de fase al mover el slider.

## Propiedades

- valor: fase actual entre 1 y valorMaximo; obligatoria.
- onChanged: callback obligatorio que entrega la nueva fase.
- valorMaximo: total de fases; por defecto, 6.
- titulo: etiqueta del control; por defecto, MOVER LUNA.

## Funcionamiento

El slider tiene seis pasos. La parte iluminada del thumb cambia al arrastrarlo y el callback devuelve el número elegido. La pantalla principal conserva el valor y actualiza la fase.

## Prueba

Desde esta carpeta, ejecutar flutter test. La prueba arrastra el slider y comprueba que el valor pasa de 5 a 6.

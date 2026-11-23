# gta_selector_card

Tarjeta con selector circular para votar "¿Qué GTA te gustó más?".

## Propiedades
| Propiedad | Tipo | Por defecto |
|---|---|---|
| title | String | '¿QUÉ GTA TE GUSTÓ MÁS?' |
| labelPrefix | String | 'GTA' |
| options | List<String> | ['I','II','III','IV','V','VI'] |
| initialIndex | int | 5 |
| accentColor | Color | 0xFF00E5FF |
| selectedColor | Color | 0xFFFF2D8A |
| backgroundColor / backgroundColorEnd | Color | 0xFF16213E / 0xFF0F1830 |
| circleColor | Color | 0xFF0B1226 |
| circleSize | double | 44 |
| borderRadius | double | 16 |

## Eventos
- `onChanged(int index)`: se llama al elegir una opción distinta.

## Ejemplo
```dart
GtaSelectorCard(
  initialIndex: 3,
  onChanged: (i) => print('Elegido: $i'),
)
```

## Uso desde otra app (pubspec.yaml)
```yaml
dependencies:
  gta_selector_card:
    path: ../gta_selector_card
```

## Pruebas
`flutter test`

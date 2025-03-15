#!/bin/bash

# Directorio de los archivos
DIRECTORIO="hymns"

# Recorre todos los archivos .txt en el directorio
for archivo in "$DIRECTORIO"/*.txt; do
  # Filtra solo líneas no vacías y con "{comment:"
  lineas=$(grep -m2 '^{comment:' "$archivo" | awk 'NF') 

  # Cuenta cuántas líneas con {comment: hay
  num_lineas=$(echo "$lineas" | grep -c '^{comment:')

  if [ "$num_lineas" -eq 1 ]; then
    # Si hay una sola línea con {comment:}, reemplazar por {title:}
    sed -i.bak '1s/{comment:/{title:/' "$archivo" && rm "$archivo.bak"
    echo "✅ Archivo procesado: $archivo (1 línea convertida a title)"

  elif [ "$num_lineas" -eq 2 ]; then
    # Si hay dos líneas con {comment:}, reemplazar la primera con {title:} y la segunda con {tone:}
    sed -i.bak '1s/{comment:/{title:/; 2s/{comment:/{tone:/' "$archivo" && rm "$archivo.bak"
    echo "✅ Archivo procesado: $archivo (2 líneas convertidas a title y tone)"
  fi
done

echo "✅ Procesamiento completado."

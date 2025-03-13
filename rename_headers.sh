#!/bin/bash

dir="hymns"

for file in "$dir"/*.txt; do
    # Extraer todas las líneas después de la cuarta línea
    tail -n +5 "$file" > "$file.tmp"

    # Procesar las primeras 4 líneas
    head -n 4 "$file" | grep -v -E "^\{comment:\s*\}$" > "$file.head"

    # Combinar los archivos
    cat "$file.head" "$file.tmp" > "$file"

    # Limpiar archivos temporales
    rm "$file.head" "$file.tmp"
done

echo "Proceso completado."

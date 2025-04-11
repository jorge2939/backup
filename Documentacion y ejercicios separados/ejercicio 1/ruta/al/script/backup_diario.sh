#!/bin/bash

# Configuración
FECHA=$(date +%Y-%m-%d)
#BACKUP_DIR="/home/jorge/Escritorio/backups"

ORIGEN="/home/jorge/Documentos/"
DESTINO="/home/jorge/Escritorio/backups/"
LOG_FILE="/home/jorge/Escritorio/backups/backup.log"

# Crear directorio de backups si no existe
mkdir -p $DESTINO

# Crear backup comprimido
echo "[$(date +%Y-%m-%d_%H:%M:%S)] Iniciando backup..." >> $LOG_FILE
tar -czf "$DESTINO backup_$FECHA.tar.gz" $ORIGEN 2>> $LOG_FILE

# Verificar éxito
if [ $? -eq 0 ]; then
    echo "[$(date +%Y-%m-%d_%H:%M:%S)] Backup completado: $DESTINO backup_$FECHA.tar.gz" >> "$LOG_FILE"
else
    echo "[$(date +%Y-%m-%d_%H:%M:%S)] Error al crear backup!" >> $LOG_FILE
fi

# Eliminar backups antiguos (más de 7 días)
find $DESTINO -name "backup_*.tar.gz" -mtime +7 -delete 2>> $LOG_FILE
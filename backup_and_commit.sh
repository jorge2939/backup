#!/bin/bash

# Configuración
PROJECT_DIR="/home/jorge/Escritorio/proyecto_automatizado"
BACKUP_DIR="/home/jorge/Escritorio/backup/proyecto"
LOG_FILE="/home/jorge/Escritorio/backup/proyecto_automatizado.log"
GIT_REPO="https://github.com/jorge2939/backup.git"  # Cambiar por tu repo

# Entrar al directorio
cd "$PROJECT_DIR" || exit 1

# Registrar inicio
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Iniciando proceso..." >> "$LOG_FILE"

# 1. Hacer backup
tar -czf "$BACKUP_DIR/backup_$(date +%Y%m%d%H%M%S).tar.gz" "$PROJECT_DIR/src" >> "$LOG_FILE" 2>&1

# 2. Actualizar repo git
git add . >> "$LOG_FILE" 2>&1
git commit -m "Auto-commit $(date '+%Y-%m-%d %H:%M:%S')" >> "$LOG_FILE" 2>&1

# 3. Subir cambios (usando SSH agent para evitar prompts)
eval "$(ssh-agent -s)" >> "$LOG_FILE" 2>&1
ssh-add /home/jorge/.ssh/id_rsa >> "$LOG_FILE" 2>&1
git push origin main >> "$LOG_FILE" 2>&1

# 4. Limpieza (opcional)
find "$BACKUP_DIR" -name "*.tar.gz" -mtime +7 -delete >> "$LOG_FILE" 2>&1

# Registrar finalización
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Proceso completado" >> "$LOG_FILE"
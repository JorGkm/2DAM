#!/usr/bin/env bash
#
# subir.sh — Sube tus cambios a GitHub
#
# Uso:  ./subir.sh
#
# Hace:  git add -A  →  te pregunta el nombre del cambio  →  commit  →  push
#

set -uo pipefail

# Nos sitjamos siempre en la carpeta del repo, da igual desde dónde lo lances
cd "$(dirname "$0")" || exit 1

# Colores para que se entienda de un vistazo
BOLD=$'\033[1m'
GREEN=$'\033[0;32m'
YELLOW=$'\033[1;33m'
RED=$'\033[0;31m'
BLUE=$'\033[0;36m'
NC=$'\033[0m'

echo -e "${BLUE}════════════ SUBIR CAMBIOS ════════════${NC}"
echo

# --- 1. Preparar todos los cambios ---
git add -A

# --- 2. ¿Hay algo que subir? ---
if git diff --cached --quiet; then
    echo -e "${YELLOW}○ No hay cambios nuevos.${NC}"
    echo "  Nada que subir."
    exit 0
fi

# --- 3. Resumen de lo que se va ---
echo -e "${BOLD}Archivos que se van a subir:${NC}"
git diff --cached --stat
echo

# --- 4. Preguntar el nombre del cambio ---
echo -e "${BOLD}¿Cómo describes este cambio?${NC}"
echo -e "  ${YELLOW}(se usará como título del commit)${NC}"
read -r -p "  > " mensaje
echo

if [ -z "$mensaje" ]; then
    echo -e "${RED}✗ Cancelado.${NC} El mensaje no puede estar vacío."
    exit 1
fi

# --- 5. Commit ---
if ! git commit -m "$mensaje"; then
    echo -e "${RED}✗ Error al hacer el commit.${NC}"
    exit 1
fi

# --- 6. Subir ---
echo
echo -e "${BOLD}Subiendo a GitHub...${NC}"
if git push; then
    echo
    echo -e "${GREEN}✓ Subido correctamente.${NC}"
    echo -e "  ${BOLD}${mensaje}${NC}"
    exit 0
fi

# --- Si el push falla ---
echo
echo -e "${RED}✗ No se pudo subir.${NC}"
echo
echo -e "${BOLD}Motivo más probable:${NC} hay cambios en GitHub que tú aún"
echo "no tenías (subiste desde el otro equipo hace un momento)."
echo
echo -e "${BOLD}Solución:${NC}"
echo "  1. ./bajar.sh      ${YELLOW}# baja lo que hay en GitHub${NC}"
echo "  2. ./subir.sh      ${YELLOW}# vuelve a subir tus cambios${NC}"
exit 1

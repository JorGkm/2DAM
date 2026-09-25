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

# --- 2. ¿Hay archivos modificados sin guardar? ---
HAY_CAMBIO=0
if ! git diff --cached --quiet; then
    HAY_CAMBIO=1

    # --- Resumen de lo que se va ---
    echo -e "${BOLD}Archivos que se van a subir:${NC}"
    git diff --cached --stat
    echo

    # --- Preguntar el nombre del cambio ---
    echo -e "${BOLD}¿Cómo describes este cambio?${NC}"
    echo -e "  ${YELLOW}(se usará como título del commit)${NC}"
    read -r -p "  > " mensaje
    echo

    if [ -z "$mensaje" ]; then
        echo -e "${RED}✗ Cancelado.${NC} El mensaje no puede estar vacío."
        exit 1
    fi

    # --- Commit ---
    if ! git commit -m "$mensaje"; then
        echo -e "${RED}✗ Error al hacer el commit.${NC}"
        exit 1
    fi
fi

# --- 3. ¿Queda algún commit sin subir a GitHub? ---
SIN_SUBIR=$(git rev-list --count origin/main..HEAD 2>/dev/null || echo 0)

if [ "$SIN_SUBIR" -eq 0 ]; then
    echo -e "${GREEN}✓ Todo está al día.${NC}"
    echo "  No hay cambios nuevos ni commits pendientes."
    exit 0
fi

if [ "$HAY_CAMBIO" -eq 0 ]; then
    echo -e "${YELLOW}○ No hay archivos nuevos, pero quedan ${BOLD}${SIN_SUBIR}${NC} ${YELLOW}commit(s) sin subir:${NC}"
    git log --oneline origin/main..HEAD
    echo
fi

# --- 4. Subir ---
echo
echo -e "${BOLD}Subiendo a GitHub...${NC}"
SALIDA=$(git push 2>&1)
CODIGO=$?

if [ $CODIGO -eq 0 ]; then
    echo "$SALIDA" | sed 's/^/    /'
    echo
    echo -e "${GREEN}✓ Subido correctamente.${NC}"
    echo -e "  ${BOLD}${mensaje}${NC}"
    exit 0
fi

# --- Si el push falla: averiguar por qué ---
echo
echo -e "${RED}✗ No se pudo subir.${NC}"
echo
echo "$SALIDA" | sed 's/^/    /'
echo

if echo "$SALIDA" | grep -qiE "could not read Username|Authentication failed|403|Invalid username or password"; then
    echo -e "${BOLD}Motivo: ${RED}no estás autenticado.${NC}"
    echo
    echo -e "${BOLD}Solución (ejecútalo tú, en tu terminal):${NC}"
    echo
    echo -e "    ${BOLD}git -c credential.helper=store push${NC}"
    echo
    echo "  Te pedirá:"
    echo "    Username → ${BOLD}JorGkm${NC}"
    echo "    Password → ${BOLD}tu token de GitHub${NC} (no tu contraseña normal)"
    echo
    echo "  Así el token se guarda y no te lo vuelve a pedir nunca más."
elif echo "$SALIDA" | grep -qiE "non-fast-forward|fetch first|rejected"; then
    echo -e "${BOLD}Motivo: ${RED}hay cambios en GitHub que tú aún no tienes${NC}"
    echo "(subiste desde el otro equipo hace un momento)."
    echo
    echo -e "${BOLD}Solución:${NC}"
    echo "  ./bajar.sh     ${YELLOW}# trae lo que hay en GitHub${NC}"
    echo "  ./subir.sh     ${YELLOW}# y vuelve a subir tus cambios${NC}"
else
    echo -e "${BOLD}Motivo: ${RED}error desconocido.${NC} Mira el mensaje de arriba."
fi

exit 1

#!/usr/bin/env bash
#
# bajar.sh — Baja de GitHub los cambios del otro equipo
#
# Uso:  ./bajar.sh
#
# Hace:  te enseña qué hay nuevo  →  git pull
#

set -uo pipefail

cd "$(dirname "$0")" || exit 1

BOLD=$'\033[1m'
GREEN=$'\033[0;32m'
YELLOW=$'\033[1;33m'
RED=$'\033[0;31m'
BLUE=$'\033[0;36m'
NC=$'\033[0m'

echo -e "${BLUE}════════════ BAJAR CAMBIOS ════════════${NC}"
echo

# --- 1. Comprobar que esto es un repositorio ---
if [ ! -d ".git" ]; then
    echo -e "${RED}✗ Esto no es un repositorio de git.${NC}"
    exit 1
fi

# --- 2. Ver si hay commits nuevos sin bajar ---
ANTES=$(git rev-parse HEAD)

if ! git fetch origin; then
    echo
    echo -e "${RED}✗ No se pudo conectar con GitHub.${NC}"
    echo "  Revisa tu conexión a internet."
    exit 1
fi

DESPUES=$(git rev-parse origin/main)

# --- 3. ¿Hay novedades? ---
if [ "$ANTES" = "$DESPUES" ]; then
    echo -e "${GREEN}✓ Ya estás al día.${NC}"
    echo "  No hay nada nuevo en GitHub."
    exit 0
fi

NUEVOS=$(git rev-list --count "$ANTES"..origin/main)
echo -e "${YELLOW}${NUEVOS} cambio(s) nuevo(s) en GitHub:${NC}"
git log --oneline "$ANTES"..origin/main
echo

# --- 4. Bajar de verdad ---
echo -e "${BOLD}Aplicando cambios...${NC}"
if ! git merge --ff-only origin/main; then
    echo
    echo -e "${RED}✗ Hay un conflicto.${NC}"
    echo "  Git no puede aplicar los cambios automáticamente porque"
    echo "  has modificado un archivo que también cambió en el otro equipo."
    echo
    echo -e "${BOLD}Cómo resolverlo:${NC}"
    echo "  git status                    ${YELLOW}# ver qué choca${NC}"
    echo "  ${YELLOW}# abre los archivos marcados y borra las líneas:${NC}"
    echo "  ${YELLOW}#   <<<<<<<, =======, >>>>>>>  (qué versión te quedas)${NC}"
    echo "  git add ."
    echo "  git commit -m 'Resuelto el conflicto'"
    exit 1
fi

echo
echo -e "${GREEN}✓ Actualizado.${NC}"
git status -sb

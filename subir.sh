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
# Ojo: si la rama remota NO existe todavía (repo nuevo), hay que subir
# siempre. Si no se comprueba esto, el script cree que está todo al día
# y no sube nada.
if git rev-parse --verify --quiet origin/main >/dev/null 2>&1; then
    SIN_SUBIR=$(git rev-list --count origin/main..HEAD 2>/dev/null || echo 0)
    if [ -z "$SIN_SUBIR" ] || [ "$SIN_SUBIR" -eq 0 ] 2>/dev/null; then
        SIN_SUBIR=0
    fi
else
    SIN_SUBIR=1
    echo -e "${YELLOW}○ La rama ${BOLD}main${NC} ${YELLOW}aún no existe en GitHub.${NC}"
    echo -e "  ${YELLOW}Se va a crear con tu primer commit.${NC}"
    echo
fi

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

# --- 4. Subir (con reintentos: el wifi de los centros a veces falla) ---
echo
echo -e "${BOLD}Subiendo a GitHub...${NC}"
SALIDA=""
CODIGO=1
INTENTO=1
MAX_INTENTOS=3

# Si la rama todavía no está vinculada a GitHub (repo nuevo), el push normal
# falla. En ese caso se usa "-u" para crear el vínculo automáticamente.
RAMA=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "main")
if git rev-parse --abbrev-ref --symbolic-full-name '@{u}' >/dev/null 2>&1; then
    PUSH_CMD="git push"
else
    PUSH_CMD="git push -u origin $RAMA"
fi

while [ $INTENTO -le $MAX_INTENTOS ]; do
    SALIDA=$($PUSH_CMD 2>&1)
    CODIGO=$?

    if [ $CODIGO -eq 0 ]; then
        echo "$SALIDA" | sed 's/^/    /'
        echo
        echo -e "${GREEN}✓ Subido correctamente.${NC}"
        exit 0
    fi

    # Solo se reintenta si el problema es de red, no de autenticación
    # ni de conflictos (reintentar eso no arregla nada).
    if echo "$SALIDA" | grep -qiE "Could not resolve host|Connection timed out|Connection reset|Connection refused|Operation timed out|SSL certificate problem|502 Bad Gateway|503 Service|remote end hung up|early EOF"; then
        if [ $INTENTO -lt $MAX_INTENTOS ]; then
            echo -e "  ${YELLOW}✗ Fallo de conexión. Reintento $INTENTO de $MAX_INTENTOS...${NC}"
            sleep 3
            INTENTO=$((INTENTO + 1))
            continue
        fi
    fi

    # Cualquier otro error: no insistir, es un problema de verdad
    break
done

# --- Si el push falla: averiguar por qué ---
echo
echo -e "${RED}✗ No se pudo subir.${NC}"
echo
echo "$SALIDA" | sed 's/^/    /'
echo

# ¿Hay un token guardado que ha caducado? Es el caso más confuso:
# generas uno nuevo pero git sigue enviando el viejo caducado.
TOKEN_CADUCADO=0
if [ -f "$HOME/.git-credentials" ] && echo "$SALIDA" | grep -qiE "Authentication failed|403|Invalid username or password"; then
    TOKEN_CADUCADO=1
fi

if [ "$TOKEN_CADUCADO" -eq 1 ]; then
    echo -e "${BOLD}Motivo: ${RED}tu token ha caducado.${NC}"
    echo
    echo -e "${BOLD}Solución (3 pasos):${NC}"
    echo "  1. Genera uno nuevo en"
    echo -e "     ${BOLD}https://github.com/settings/tokens${NC}"
    echo -e "     ${YELLOW}(marca Contents → Read and write)${NC}"
    echo -e "  2. ${BOLD}rm ~/.git-credentials${NC}   ${YELLOW}# borra el caducado${NC}"
    echo "  3. ${BOLD}./subir.sh${NC}   ${YELLOW}# y pega el token nuevo${NC}"
    echo
    echo -e "  ${YELLOW}El paso 2 es imprescindible: sin él git sigue${NC}"
    echo -e "  ${YELLOW}mandando el token viejo y te lo rechaza otra vez.${NC}"
elif echo "$SALIDA" | grep -qiE "could not read Username|Authentication failed|403|Invalid username or password"; then
    echo -e "${BOLD}Motivo: ${RED}no estás autenticado todavía.${NC}"
    echo "Es la primera vez (o el token se borró del sistema)."
    echo
    echo -e "${BOLD}Solución (ejecútalo tú, en tu terminal):${NC}"
    echo
    echo -e "    ${BOLD}git push${NC}"
    echo
    echo "  Te pedirá:"
    echo "    Username → ${BOLD}JorGkm${NC}"
    echo "    Password → ${BOLD}tu token de GitHub${NC} (no tu contraseña normal)"
    echo
    echo "  Quedará guardado y no te lo volverá a pedir hasta que caduque."
elif echo "$SALIDA" | grep -qiE "does not have an upstream|no tiene una rama upstream|set-upstream"; then
    echo -e "${BOLD}Motivo: ${RED}esta rama aún no está vinculada a GitHub.${NC}"
    echo
    echo -e "${BOLD}Solución:${NC}"
    echo "Es la primera vez que subes esta rama. Vincúlala con:"
    echo
    echo -e "    ${BOLD}git push -u origin $RAMA${NC}"
    echo
    echo "A partir de ahí, ./subir.sh ya lo hará solo."
elif echo "$SALIDA" | grep -qiE "Could not resolve host|Connection timed out|Connection reset|Connection refused|Operation timed out|SSL certificate problem|Bad Gateway|Service Unavailable|remote end hung up|early EOF|Network is unreachable"; then
    echo -e "${BOLD}Motivo: ${RED}fallo de red.${NC} No se pudo ni conectar con GitHub."
    echo
    echo -e "${BOLD}Prueba esto:${NC}"
    echo "  • ¿Estás conectado a internet?"
    echo "  • Si usas el wifi de un centro, quizá haya un ${BOLD}portal de acceso${NC}"
    echo "    (abre el navegador y autentifícate primero)"
    echo "  • ¿Hay VPN o un proxy que esté bloqueando?"
    echo
    echo "  Tus cambios están a salvo en local. Cuando vuelvas a tener"
    echo -e "  red, ejecuta ${BOLD}./subir.sh${NC} otra vez y subirán igual."
elif echo "$SALIDA" | grep -qiE "non-fast-forward|fetch first|\(rejected\).*\(fetch first\)|\(rejected\).*non-fast-forward"; then
    echo -e "${BOLD}Motivo: ${RED}hay cambios en GitHub que tú aún no tienes${NC}"
    echo "(subiste desde el otro equipo hace un momento)."
    echo
    echo -e "${BOLD}Solución:${NC}"
    echo "  ./bajar.sh     ${YELLOW}# trae lo que hay en GitHub${NC}"
    echo "  ./subir.sh     ${YELLOW}# y vuelve a subir tus cambios${NC}"
elif echo "$SALIDA" | grep -qiE "\(rejected\)"; then
    echo -e "${BOLD}Motivo: ${RED}GitHub ha rechazado el push.${NC}"
    echo
    echo "Lee el mensaje de arriba con atención: suele indicar que el"
    echo "token no tiene permiso de escritura sobre el repo."
    echo
    echo -e "${BOLD}Solución:${NC}"
    echo "  1. Revisa el token en https://github.com/settings/tokens"
    echo -e "  2. ${BOLD}rm ~/.git-credentials${NC}   ${YELLOW}# borra el guardado${NC}"
    echo "  3. ${BOLD}git push${NC}   ${YELLOW}# y pega un token nuevo${NC}"
else
    echo -e "${BOLD}Motivo: ${RED}error desconocido.${NC} Mira el mensaje de arriba."
    echo
    echo -e "${BOLD}Si no lo entiendes, copia el texto de arriba y mándamelo.${NC}"
    echo "Tus cambios NO se han perdido: siguen guardados en local."
fi

exit 1

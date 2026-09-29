# Guía de Git — repo `2DAM`

Guía personal para trabajar con este repositorio desde varios ordenadores
(sobremesa y portátil) sin liarse.

---

## 📌 Qué es esto

Este repositorio guarda tus apuntes y proyectos de 2ºDAM, sincronizados
con GitHub para poder trabajar desde cualquier equipo.

- **Repo:** <https://github.com/JorGkm/2DAM>
- **Rama principal:** `main`
- **Visibilidad:** público

### Ficheros especiales de esta carpeta

| Fichero | Para qué sirve |
|---|---|
| `subir.sh` / `subir.bat` | Sube tus cambios a GitHub (sh = Linux, bat = Windows) |
| `bajar.sh` / `bajar.bat` | Baja los cambios del otro equipo |
| `.gitignore` | Lista lo que **no** se sube (compilados, cachés…) |
| `.gitattributes` | Normaliza los finales de línea entre Windows y Linux |
| `GIT.md` | Este manual |

---

## 🚀 Lo normal: dos scripts

En la raíz de la carpeta tienes dos scripts que hacen todo el trabajo
por ti. Solo necesitas ejecutarlos.

### `subir.sh` — mandar tus cambios a GitHub

```bash
./subir.sh
```

Te enseña qué archivos van a subir, te pide una descripción del cambio
y lo sube. Si falla por la red, **lo intenta 3 veces solo**.

### `bajar.sh` — traerte los cambios del otro equipo

```bash
./bajar.sh
```

Te dice cuántos cambios nuevos hay y los aplica.

> Si te sale `Permission denied` al ejecutarlos, dale permisos una vez
> (**solo en Linux**; en Windows no existe `chmod`):
> ```bash
> chmod +x subir.sh bajar.sh
> ```

---

## 🔄 El día a día

```
   SOBRE MESA (Windows)         GITHUB          PORTÁTIL (Linux)
          │                        │                    │
     haces cambios                │              haces cambios
          │                        │                    │
     subir.bat ──────────────────► │                    │
          │                        │              ./bajar.sh
          │                        │ ◄──────────────────┘
          │                        │
          │                   ./bajar.sh
          │                        │                    │
     subir.bat ──────────────────► │ ─────────────────► │
```

**Regla de oro:** antes de ponerte a trabajar en un equipo, baja los
cambios. Así evitas conflictos.

---

## 🖥️ Configurar el Sobremesa (Windows) — una sola vez

```powershell
cd Documentos
git clone https://github.com/JorGkm/2DAM.git
cd 2DAM
```

Como el repo es **público**, no pide usuario ni contraseña ni token.
Y en Windows **no** hay que hacer `chmod`.

### Ejecutar los scripts en Windows

Hay dos juegos de scripts. Los `.bat` son los fáciles: **doble clic y ya**.

#### ⭐ Lo más fácil: `subir.bat` y `bajar.bat`

**Doble clic** y se abre una ventana negra que te hace todo lo necesario.
No necesitas bash, ni terminals raras, ni tocar nada.

```
subir.bat     →  te pide el nombre del cambio y sube
bajar.bat     →  baja los cambios del otro equipo
```

> La ventana se cierra sola cuando termina. Para que **no** se cierre
> y puedas leer los mensajes, ábrelos desde CMD o PowerShell:
> ```cmd
> cd Documentos\2DAM
> subir.bat
> ```

#### Alternativa: los `.sh` con Git Bash

Git for Windows **incluye** bash. Los `.sh` dan colores y mensajes más
bonitos, pero hay que lanzarlos así:

| Opción | Cómo |
|---|---|
| **A. Menú contextual** | Clic derecho en la carpeta → *"Abrir con Git Bash"* → `./subir.sh` |
| **B. Barra de direcciones** | En el Explorador de archivos, escribe `bash` y dale Enter |
| **C. Desde CMD o PowerShell** | `bash subir.sh` |

> **"No tengo bash"**: sí lo tienes. Busca *"Git Bash"* en el menú Inicio,
> o está en `C:\Program Files\Git\bin\bash.exe`. Viene con Git, y tú ya
> tienes Git (has clonado el repo). Si no lo encuentras, usa los `.bat`.

### ⚠️ Por qué los `.bat` no se pueden abrir en Linux

Los ficheros `.bat` y `.cmd` de Windows necesitan saltos de línea **CRLF**
(o "fin de línea de Windows"). El intérprete de comandos rompe los
`goto` si están en LF.

Para eso está el `.gitattributes` de este repo, que fuerza:

| Tipo | Final de línea |
|---|---|
| `.bat` `.cmd` `.ps1` | **CRLF** (Windows) |
| `.sh` `.dart` `.md` `.yaml` `.xml` | **LF** (Linux) |
| `.png` `.zip` `.jar` | binario, no se toca |

Así que los `.bat` en Windows funcionan, y los `.sh` en el portátil
también. Sin tocar nada a mano.

> **Nunca edites un `.bat` en el Bloc de Notas** y lo guardes: puede
> meter un carácter invisible al principio del archivo y Windows se
> quejará. Usa VS Code o Notepad++.

---

## 🔑 Sobre la autenticación (por qué a veces te pide cosas)

| Acción | ¿Pide contraseña? |
|---|---|
| `git clone` (bajar el repo) | No, si es público |
| `bajar.sh` (actualizar) | No |
| `subir.sh` (subir) | **Sí** — siempre, incluso en repos públicos |

> **¿Por qué si es público?** Porque *leer* es abierto para todos, pero
> *escribir* hay que demostrar que eres tú. Es como una biblioteca
> pública: entras a leer libremente, pero necesitas el carnet para
> añadir libros.

**Hacerlo privado no cambia nada de esto.** Lo único que conseguirías es
que también te pidiera contraseña para *bajar*.

Si algún día te pide credenciales:

- **Usuario:** `JorGkm`
- **Contraseña:** tu contraseña normal **no** sirve. Necesitas un
  **token personal** en <https://github.com/settings/tokens> con el
  permiso **Contents → Read and write**.

Una vez que el token se guarda (`~/.git-credentials`), no te lo vuelve a
pedir hasta que caduque.

---

## 🚨 Errores frecuentes y qué hacer

Cuando `./subir.sh` falla, **imprime el mensaje real de git arriba** y
debajo un diagnóstico. A veces el diagnóstico es una suposición, así que
**lee también el texto literal**.

### "fallo de red"

```
fatal: unable to access '...': Could not resolve host: github.com
```

**Qué ha pasado:** no se pudo ni conectar. Wi-fi del centro, portal de
acceso, VPN...

**Qué hacer:**

- Comprueba que tienes internet
- Si usas el wifi de un centro, abre el navegador y autentifícate
  primero (portal cautivo)
- Cuando vuelvas a tener red, ejecuta `./subir.sh` otra vez

💡 El script ya reintenta 3 veces solo, pero si el wifi está caído del
todo no hay MAGIC que haga.

### "tu token ha caducado"

```
remote: Invalid username or password
fatal: Authentication failed
```

**Qué ha pasado:** el token guardado en tu ordenador venció. GitHub los
tokens caducan (normalmente a los 90 días).

**Qué hacer (3 pasos):**

1. Genera uno nuevo en <https://github.com/settings/tokens>
   (marca **Contents → Read and write**)
2. `rm ~/.git-credentials` ← **imprescindible**, borra el caducado
3. `./subir.sh` y pega el token nuevo

⚠️ **El paso 2 no es opcional.** Sin él, git sigue enviando el token
viejo y te lo rechaza otra vez, aunque el nuevo sea correcto. Es el error
más desconcertante que te vas a encontrar.

### "hay cambios en GitHub que tú aún no tienes"

```
! [rejected]        main -> main (fetch first)
```

**Qué ha pasado:** el otro equipo subió cosas y tú aún no las has bajado.
Un conflicto de verdad.

**Qué hacer:**

```bash
./bajar.sh     # trae lo que hay en GitHub
./subir.sh     # y vuelve a subir tus cambios
```

### "no estás autenticado todavía"

**Qué ha pasado:** es la primera vez, o el token se borró del sistema.

**Qué hacer:**

```bash
git push
```

Y pegar usuario `JorGkm` + tu token.

### "La rama main aún no existe en GitHub"

**Qué ha pasado:** es la primera vez que subes esta rama. El script lo
detecta y usa `-u` solo, así que normalmente **ni te aparecerá**.
Si te aparece, el push va con `-u` automáticamente.

### En cualquier caso

**Tus cambios nunca se pierden.** Un error de git no borra tu trabajo:
todo sigue guardado en tu disco, en local. Lo único que hay que hacer
es volver a intentarlo cuando el problema desaparezca.

---

## ⚔️ Si sale un conflicto

Pasa cuando modificas **el mismo archivo** en los dos equipos sin
haber sincronizado entre medias.

Git inserta estas marcas en el archivo:

```
<<<<<<< HEAD
esto es lo que tienes tú aquí
=======
esto es lo que viene del otro equipo
>>>>>>> origin/main
```

**Cómo resolverlo:**

1. Abre el archivo en un editor
2. Borra las tres líneas de marcado (`<<<<<<<`, `=======`, `>>>>>>>`)
3. Deja el texto que te quieras quedar
4. Sube el cambio:

```bash
git add .
git commit -m "Resuelto el conflicto"
git push
```

**Cómo evitarlo:** sincroniza siempre antes de empezar a trabajar.
`./bajar.sh` al empezar, `./subir.sh` al terminar.

---

## ⌨️ Comandos a mano

Los scripts son una comodidad, pero esto es lo que hay detrás por si
alguna vez lo necesitas:

| Quiero... | Comando |
|---|---|
| Preparar todos los cambios | `git add .` |
| Guardar el cambio | `git commit -m "mensaje"` |
| Subir | `git push` |
| Bajar | `git pull` |
| Ver qué he cambiado | `git status` |
| Ver el historial | `git log --oneline` |
| Ver el historial con dibujito | `git log --oneline --graph --all` |
| Descartar cambios sin querer | `git restore .` |
| Ver qué hay en GitHub sin bajarlo | `git fetch origin && git log --oneline HEAD..origin/main` |

### Estoy al día?

```bash
git status -sb
```

Si la línea es `## main...origin/main` **y no hay nada más detrás**,
estás perfectamente sincronizado. Esa línea vacía es tu "todo bien".

---

## 🚫 Lo que ignora el repo

El `.gitignore` evita subir basura que no es tuya. Cubre:

| Herramienta | Lo que ignora |
|---|---|
| **Flutter / Dart** | `.dart_tool/`, `build/`, `.flutter-plugins` |
| **Android** | `build/`, `local.properties`, `*.apk`, `*.aab` |
| **Android Studio / IntelliJ** | `.idea/`, `*.iml`, `.kotlin/` |
| **Eclipse** | `.metadata/`, `.settings/`, `.classpath` |
| **NetBeans** | `nbproject/private/`, `nbbuild/`, `dist/` |
| **VS Code** | `.vscode/` (salvo `settings.json` y `extensions.json`) |
| **.NET / C#** | `bin/` (salvo `.dart`), `obj/`, `.vs/` |
| **Node** | `node_modules/` |
| **Python** | `__pycache__/`, `.venv/` |
| **Sistema** | `.directory`, `Thumbs.db`, `.DS_Store`, `*~` |

### Dos detalles importantes

**`pubspec.lock` SÍ se sube.** En una app conviene fijarlo para que todo
el mundo use la misma versión. Solo se ignoraría si hicieras una librería.

**`*.jar` NO se ignora.** A propósito: el wrapper de Gradle
(`gradle/wrapper/gradle-wrapper.jar`) hace falta para compilar, y algunas
prácticas de clase usan librerías `.jar` que hay que subir.

### Subir algo que está ignorado

```bash
git add -f ruta/al/archivo
```

---

## 🧠 Conceptos (para entender qué haces)

- **Repositorio** — la carpeta con una subcarpeta oculta `.git` donde git
  guarda la historia. Si la borras, "desvinculas" el repo.
- **Commit** — una foto de tus archivos con un mensaje que explica qué
  cambiaste. Es un punto al que siempre puedes volver.
- **`origin`** — el nombre corto que le damos a tu repo de GitHub. Es un
  alias para no escribir la URL entera cada vez.
- **`main`** — la rama principal, la "versión buena".
- **push / pull** — push *manda* hacia GitHub, pull *trae* desde GitHub.
- **upstream** — el vínculo entre tu rama local y la de GitHub. Si no
  existe, el push normal falla (el script lo crea solo con `-u`).

---

## 🧰 Tu equipo

Si algún día esto se rompe y quieres empezar de cero:

| Herramienta | Estado |
|---|---|
| Flutter | ✅ 3.47.5 |
| Dart | ✅ 3.13.4 |
| Android Studio | ✅ |
| Java (Temurin) | ✅ 25 |
| VS Code | ✅ |
| Android SDK | ✅ `~/Android/Sdk` |
| .NET SDK | ✅ |
| Eclipse | ❌ no instalado |
| NetBeans | ❌ no instalado |
| IntelliJ IDEA | ❌ no instalado |

Para instalar los que faltan (en Arch / CachyOS):

```bash
sudo pacman -S netbeans eclipse
```

IntelliJ IDEA no está en los repos de pacman: bájalo de
<https://www.jetbrains.com/idea/download>.

### Deshacer todo (empezar de cero)

```bash
rm -rf .git
git init
git add -A
git commit -m "Primer commit"
git remote add origin https://github.com/JorGkm/2DAM.git
git push -u origin main
```

⚠️ Ojo: si en GitHub ya hay commits, necesitarás `--force` para
sobrescribir, y eso **borra el historial remoto**. No lo hagas salvo
que sepas lo que implica.

---

*Documento creado y actualizado en septiembre de 2026.*

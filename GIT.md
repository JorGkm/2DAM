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

---

## 🚀 Lo normal: dos scripts

En la raíz de la carpeta tienes dos scripts que hacen todo el trabajo
por ti. Solo necesitas ejecutarlos.

### `subir.sh` — mandar tus cambios a GitHub

```bash
./subir.sh
```

Te enseñará qué archivos van a subir, te pedirá una descripción del
cambio y lo sube.

### `bajar.sh` — traerte los cambios del otro equipo

```bash
./bajar.sh
```

Te dirá cuántos cambios nuevos hay y los aplica.

> Si te sale `Permission denied` al ejecutarlos, dale permisos una vez:
> ```bash
> chmod +x subir.sh bajar.sh
> ```

---

## 🔄 El día a día

```
   SOBREmesa/portátil A          GITHUB          Equipo B
        │                          │                │
   haces cambios                  │           haces cambios
        │                          │                │
   ./subir.sh ──────────────────► │                │
                                  │           ./bajar.sh
                                  │ ◄───────────────┘
```

**Regla de oro:** antes de ponerte a trabajar en un equipo, ejecuta
`./bajar.sh`. Así evitas conflictos.

---

## 🖥️ Configurar el otro equipo (una sola vez)

En el sobremesa, si el repo aún no está descargado:

```bash
cd ~/Escritorio
git clone https://github.com/JorGkm/2DAM.git
```

Como el repo es **público**, no pide ni usuario ni contraseña ni token.

Y para que los scripts funcionen también allí:

```bash
cd ~/Escritorio/2DAM
chmod +x subir.sh bajar.sh
```

---

## 🔑 Sobre la autenticación (por qué a veces te pide cosas)

Cuando el repo era **privado** había que autenticarse. Ahora es público,
así que ya no hace falta para nada de lo que haces.

| Acción | ¿Pide contraseña? |
|---|---|
| `git clone` (bajar el repo) | No, si es público |
| `git pull` (actualizar) | No |
| `git push` (subir) | **Sí** — siempre, incluso en repos públicos |

> **¿Por qué si es público?** Porque *leer* es abierto para todos, pero
> *escribir* hay que demostrar que eres tú. Es como una biblioteca
> pública: entras a leer libremente, pero necesitas el carnet para
> añadir libros.

Si algún día `git push` te pide credenciales:

- **Usuario:** `JorGkm`
- **Contraseña:** tu *contraseña normal **no** sirve*. Necesitas un
  **token personal** en <https://github.com/settings/tokens>
  con el permiso **Contents → Read and write**.

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
| Descartar cambios sin querer | `git restore .` |
| Ver qué hay en GitHub | `git fetch origin && git log --oneline HEAD..origin/main` |

---

## 🚫 Lo que ignora el repo

El `.gitignore` evita subir basura que no es tuya:

| Ignorado | Por qué |
|---|---|
| `.directory` | Metadatos de carpeta de KDE, se regeneran solos |
| `.idea/` `.vscode/` | Configuración de editores, es personal |
| `.DS_Store` `Thumbs.db` | Basura del sistema operativo |
| `*~` `*.swp` | Ficheros de respaldo de editores |

Si algún día quieres subir algo que está ignorado, borra su línea del
`.gitignore` o usa:

```bash
git add -f ruta/al/archivo
```

---

## 🆘 Deshacer cosas

| Me he equivocado... | Solución |
|---|---|
| Modifiqué un archivo y no quería | `git restore .` (descarta todo) |
| Hice un commit con el mensaje mal | `git commit --amend -m "mensaje bueno"` |
| Commité algo que no debías | `git revert <nº-del-commit>` |
| Subí algo que no debías | `git revert <nº-del-commit>` y luego `git push` |
| Lo quiero todo como estaba antes | Ver "Deshacer todo" más abajo |

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

## 🧠 Conceptos (para entender qué haces)

- **Repositorio** — la carpeta con una subcarpeta oculta `.git` donde
  git guarda la historia. Si la borras, "desvincular" el repo.
- **Commit** — una foto de tus archivos con un mensaje que explica qué
  cambiaste. Es un punto al que siempre puedes volver.
- **`origin`** — el nombre corto que le damos a tu repo de GitHub. Es
  solo un alias para no escribir la URL entera cada vez.
- **`main`** — la rama principal, la "versión buena" de tus apuntes.
- **push / pull** — push *manda* hacia GitHub, pull *trae* desde
  GitHub. Ojo: pull trae, no baja... bueno, los dos es lo mismo.

---

*Documento creado en septiembre de 2026.*

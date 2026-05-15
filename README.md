# Fildem Global Menu & HUD

[![Inled Branding](https://img.shields.io/badge/Developed%20by-Inled-blue.svg)](https://inled.es)
![GNOME Shell](https://img.shields.io/badge/GNOME-45--50-green.svg)

Fildem es un sistema de menú global y HUD para el escritorio GNOME. Este proyecto permite tener una barra de menú integrada en el panel superior de GNOME, similar a macOS o Unity, y un buscador HUD (Heads-Up Display) para acceder rápidamente a las opciones de menú.

Esta versión ha sido adaptada para ser totalmente compatible con **GNOME 48, 49 y 50**, migrando la extensión a ESM y actualizando la comunicación D-Bus.

## Requisitos y Componentes

Fildem consta de dos partes que deben estar instaladas y funcionando simultáneamente:

1.  **Extensión de GNOME Shell (`fildem@inled.es`)**: Gestiona la interfaz en el panel de GNOME.
2.  **Aplicación de Complemento (Python)**: Gestiona la extracción de menús de las aplicaciones y la lógica del HUD.

## Instalación

### 1. Instalación de la Aplicación (Complemento)

La aplicación de complemento es necesaria para que la extensión pueda recibir los menús de las ventanas activas.

#### Dependencias (Ubuntu/Debian)
```bash
sudo apt install python3-gi python3-dbus bamfdaemon libbamf3-dev libkeybinder-3.0-dev appmenu-gtk2-module appmenu-gtk3-module unity-gtk-module-common
```

#### Instalación rápida (Recomendado)
Si quieres instalar todo automáticamente (Extensión + Aplicación + Servicio), ejecuta el siguiente comando en tu terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/InledGroup/Fildem/main/install.sh | bash
```

Este comando descargará el instalador, pedirá permisos de superusuario para las dependencias y dejará todo configurado, incluyendo el servicio de arranque automático.

#### Instalación manual (Paso a paso)

Si prefieres instalar los componentes por separado o estás en el directorio del repositorio:

1. **Instalar la Aplicación (Complemento) y el Servicio:**
   ```bash
   ./install_app.sh
   ```
2. **Instalar la Extensión de GNOME Shell:**
   ```bash
   ./install_extension.sh
   ```

### Configuración de Módulos GTK

- Crea o edita el archivo `~/.gtkrc-2.0` y añade:
  ```text
  gtk-modules="appmenu-gtk-module"
  ```
- Crea o edita el archivo `~/.config/gtk-3.0/settings.ini` y añade bajo la sección `[Settings]`:
  ```ini
  [Settings]
  gtk-modules="appmenu-gtk-module"
  ```

### 3. Instalación de la Extensión

1. Copia la carpeta de la extensión a tu directorio local de extensiones:
   ```bash
   cp -r fildem@inled.es ~/.local/share/gnome-shell/extensions/
   ```
2. Reinicia GNOME Shell (Alt+F2, escribe `r` y pulsa Enter en X11, o cierra sesión y vuelve a entrar en Wayland).
3. Habilita la extensión mediante la aplicación de "Extensiones" o "Retoques".

## Uso

### Ejecución del servicio
Para que el menú global funcione, el servicio de Fildem debe estar ejecutándose. Puedes iniciarlo manualmente con:
```bash
fildem
```
*(Se recomienda añadir `fildem` a tus aplicaciones de inicio en GNOME).*

### HUD (Heads-Up Display)
El HUD permite buscar acciones del menú pulsando una combinación de teclas.
- En **Xorg**: Pulsa `Alt + Espacio`.
- En **Wayland**: Debes crear un atajo de teclado personalizado en la configuración de GNOME que ejecute el comando `fildem-hud`.

## Personalización

Puedes configurar el comportamiento de la extensión desde sus preferencias:
- **Button paddings**: Ajusta el espaciado entre los botones del menú.
- **Show menu only when hover**: Oculta el menú a menos que pases el ratón por encima del panel.
- **Hide app menu**: Oculta el nombre de la aplicación activa para dejar más espacio al menú global.

## Créditos
Originalmente creado por Gonzalo. Adaptado y mantenido para versiones modernas de GNOME por **Inled**.

#!/bin/bash
set -e

UUID="fildem@inled.es"
EXT_DIR="$HOME/.local/share/gnome-shell/extensions/$UUID"
OLD_UUID="fildemGMenu@gonza.com"
OLD_EXT_DIR="$HOME/.local/share/gnome-shell/extensions/$OLD_UUID"

echo "🧹 Limpiando versiones anteriores..."
if [ -d "$EXT_DIR" ]; then
    rm -rf "$EXT_DIR"
fi
if [ -d "$OLD_EXT_DIR" ]; then
    rm -rf "$OLD_EXT_DIR"
fi

echo "📂 Instalando la nueva extensión ($UUID)..."
mkdir -p "$EXT_DIR"
cp -r fildem@inled.es/* "$EXT_DIR/"

echo "🛠️ Compilando esquemas GSettings..."
glib-compile-schemas "$EXT_DIR/schemas/"

echo "✨ Extensión instalada con éxito."
echo "🔄 Reinicia GNOME Shell (Alt+F2 -> r en X11, o cierra sesión en Wayland) y activa la extensión."

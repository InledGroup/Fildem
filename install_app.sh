#!/bin/bash
set -e

# Obtener la ruta absoluta del directorio actual
CURRENT_DIR=$(pwd)

echo "📦 Actualizando índices de paquetes..."
pkexec apt update

echo "📦 Instalando dependencias principales (GTK3)..."
pkexec apt install -y python3-gi python3-dbus bamfdaemon libbamf3-dev libkeybinder-3.0-dev \
    appmenu-gtk3-module python3-setuptools

echo "📦 Intentando instalar paquetes de compatibilidad legada (opcionales)..."
# Intentamos instalar GTK2 y Unity modules pero no fallamos si no existen
pkexec apt install -y appmenu-gtk2-module unity-gtk-module-common 2>/dev/null || echo "⚠️  Nota: Algunos paquetes legados (GTK2/Unity) no están disponibles en tu sistema. Se omitirán."

echo "⚙️ Instalando el complemento Python (Fildem Service)..."
# Entramos al directorio del proyecto antes de ejecutar setup.py para que encuentre README.md
pkexec sh -c "cd '$CURRENT_DIR' && python3 setup.py install"

echo "📝 Configurando módulos GTK..."
# GTK 2 (si existe el archivo o el soporte)
if [ ! -f ~/.gtkrc-2.0 ]; then
    touch ~/.gtkrc-2.0
fi
if ! grep -q "appmenu-gtk-module" ~/.gtkrc-2.0; then
    echo 'gtk-modules="appmenu-gtk-module"' >> ~/.gtkrc-2.0
fi

# GTK 3 (Principal para GNOME 45+)
mkdir -p ~/.config/gtk-3.0
if [ ! -f ~/.config/gtk-3.0/settings.ini ]; then
    echo -e "[Settings]\ngtk-modules=\"appmenu-gtk-module\"" > ~/.config/gtk-3.0/settings.ini
else
    if ! grep -q "appmenu-gtk-module" ~/.config/gtk-3.0/settings.ini; then
        if grep -q "\[Settings\]" ~/.config/gtk-3.0/settings.ini; then
            sed -i '/\[Settings\]/a gtk-modules="appmenu-gtk-module"' ~/.config/gtk-3.0/settings.ini
        else
            echo -e "\n[Settings]\ngtk-modules=\"appmenu-gtk-module\"" >> ~/.config/gtk-3.0/settings.ini
        fi
    fi
fi

echo "✅ Instalación del complemento completada."
echo "💡 Reinicia tu sesión para activar los módulos de menú global."

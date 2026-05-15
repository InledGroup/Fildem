#!/bin/bash
set -e

# Colores para la salida
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}===========================================${NC}"
echo -e "${BLUE}   Fildem Global Menu - Unified Installer  ${NC}"
echo -e "${BLUE}===========================================${NC}"

# Verificar si git está instalado
if ! command -v git &> /dev/null; then
    echo -e "${YELLOW}📦 Git no está instalado. Instalándolo...${NC}"
    sudo apt update && sudo apt install -y git
fi

# Crear un directorio temporal para la instalación
TEMP_DIR=$(mktemp -d)
trap 'rm -rf "$TEMP_DIR"' EXIT

echo -e "${BLUE}📥 Clonando repositorio desde GitHub...${NC}"
git clone https://github.com/InledGroup/Fildem.git "$TEMP_DIR"

cd "$TEMP_DIR"

# Dar permisos de ejecución a los scripts internos
chmod +x install_app.sh install_extension.sh

echo -e "${BLUE}📦 Instalando la aplicación de complemento...${NC}"
./install_app.sh

echo -e "${BLUE}🧩 Instalando la extensión de GNOME Shell...${NC}"
./install_extension.sh

echo -e "${GREEN}===========================================${NC}"
echo -e "${GREEN}      ¡Instalación completada con éxito!    ${NC}"
echo -e "${GREEN}===========================================${NC}"
echo -e "${YELLOW}IMPORTANTE:${NC}"
echo -e "1. ${BLUE}Reinicia GNOME Shell${NC} (Alt+F2, escribe 'r' y pulsa Enter, o cierra sesión en Wayland)."
echo -e "2. ${BLUE}Activa la extensión${NC} 'Fildem Global Menu' en la aplicación 'Extensiones'."
echo -e "3. ${BLUE}Cierra sesión y vuelve a entrar${NC} para que los menús funcionen en todas las aplicaciones."
echo -e ""
echo -e "Desarrollado con ❤️ por ${BLUE}Inled${NC} (https://inled.es)"

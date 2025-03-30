#!/bin/bash

# Este script configura el repositorio CyberCalc a partir del bundle descargado
# Debes tener Git instalado y configurado en tu computadora

# Verificar si cybercalc.bundle existe
if [ ! -f "cybercalc.bundle" ]; then
    echo "Error: No se encuentra el archivo cybercalc.bundle"
    echo "Debes descargar el archivo cybercalc.bundle desde Replit primero."
    exit 1
fi

# Crear directorio temporal y clonar desde el bundle
echo "Clonando el repositorio desde el bundle..."
git clone cybercalc.bundle cybercalc_temp

# Entrar al directorio
cd cybercalc_temp

# Configurar el remote
echo "Configurando el remote de GitHub..."
git remote remove origin 2>/dev/null
git remote add origin https://github.com/NoobMaster6420/TAREAS.git

# Verificar la configuración
echo "Verificando configuración de Git..."
git config --get user.name || echo "Configura tu nombre de usuario con: git config --global user.name \"Tu Nombre\""
git config --get user.email || echo "Configura tu email con: git config --global user.email \"tu@email.com\""

# Mostrar el remote configurado
echo "Remotes configurados:"
git remote -v

# Instrucciones finales
echo ""
echo "Repositorio configurado correctamente."
echo "Para subir el código a GitHub, ejecuta los siguientes comandos:"
echo ""
echo "cd cybercalc_temp"
echo "git push -u origin main"
echo ""
echo "Cuando se solicite usuario y contraseña, usa tu nombre de usuario de GitHub y tu token personal (no tu contraseña)"
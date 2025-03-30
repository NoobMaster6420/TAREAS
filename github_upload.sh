#!/bin/bash

# Este script configura y sube el repositorio CyberCalc a GitHub
# Debes tener Git instalado y configurado en tu computadora

# Configuración inicial
echo "Configurando el repositorio para subir a GitHub..."

# Eliminar el remote anterior si existe
git remote remove origin 2>/dev/null

# Agregar el nuevo remote
echo "Agregando remote de GitHub..."
git remote add origin https://github.com/NoobMaster6420/TAREAS.git

# Verificar la configuración
echo "Verificando configuración de Git..."
git config --get user.name || echo "Configura tu nombre de usuario con: git config --global user.name \"Tu Nombre\""
git config --get user.email || echo "Configura tu email con: git config --global user.email \"tu@email.com\""

# Mostrar el remote configurado
echo "Remotes configurados:"
git remote -v

# Subir a GitHub
echo "Subiendo el código a GitHub..."
echo "Cuando se solicite usuario y contraseña, usa tu nombre de usuario y token personal de GitHub (no tu contraseña)"
git push -u origin main

echo "Proceso completado."
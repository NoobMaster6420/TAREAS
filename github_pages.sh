#!/bin/bash

# Este script crea los archivos necesarios para GitHub Pages y los sube al repositorio
# Debes tener Git instalado y configurado en tu computadora

# Crear directorios necesarios
mkdir -p .github/workflows

# Crear archivo workflow para GitHub Pages
cat > .github/workflows/github-pages.yml << 'EOL'
name: Deploy to GitHub Pages

on:
  push:
    branches: [ main ]
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '20'
          cache: 'npm'
          
      - name: Install dependencies
        run: npm install
        
      - name: Build frontend
        run: |
          # Crear un build estático personalizado para GitHub Pages
          # Modificamos temporalmente el build para que funcione sin backend
          echo "Creating special build for GitHub Pages static deployment"
          mkdir -p dist
          cp -r client/public/* dist/ 2>/dev/null || :
          
          # Construir el frontend
          npm run build
          
          # Crear archivo index.html en la raíz con redirección
          cat > dist/index.html << 'EOF'
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>CyberCalc - Aplicación Educativa de Cálculo</title>
  <meta http-equiv="refresh" content="0;url=./client/index.html">
  <style>
    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
      margin: 0;
      padding: 20px;
      background-color: #1a1a2e;
      color: #e6e6e6;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      min-height: 100vh;
      text-align: center;
    }
    h1 {
      color: #00b4d8;
      margin-bottom: 10px;
    }
    p {
      max-width: 600px;
      line-height: 1.6;
    }
    a {
      color: #00b4d8;
      text-decoration: none;
      font-weight: bold;
    }
    a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>
  <h1>CyberCalc - Redireccionando</h1>
  <p>Si no eres redirigido automáticamente, <a href="./client/index.html">haz clic aquí</a>.</p>
  <p><small>Nota: Esta es una versión limitada estática. Algunas funcionalidades pueden no estar disponibles sin el backend.</small></p>
</body>
</html>
EOF
      
      - name: Deploy to GitHub Pages
        uses: JamesIves/github-pages-deploy-action@v4
        with:
          folder: dist
          branch: gh-pages
EOL

# Crear archivo .nojekyll
touch .nojekyll
echo "# Este archivo indica a GitHub Pages que no use Jekyll para procesar el sitio" > .nojekyll

echo "Archivos para GitHub Pages creados correctamente"
echo "Para actualizar el repositorio, ejecuta:"
echo "git add .github/workflows/github-pages.yml .nojekyll"
echo "git commit -m \"Agregar configuración de GitHub Pages\""
echo "git push origin main"
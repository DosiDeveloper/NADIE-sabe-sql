# Descarga y Configuración de SQLite3

## Windows

1. Ve a https://www.sqlite.org/download.html
2. Descarga `sqlite-tools-win-x64-*.zip` (la última versión)
3. Extrae el contenido en `C:\sqlite3`
4. Agrega `C:\sqlite3` al PATH del sistema:
   - Abre "Variables de Entorno"
   - En "Variables del sistema", edita `Path`
   - Agrega `C:\sqlite3`
5. Verifica la instalación:

```powershell
sqlite3 --version
```

## Linux

### Ubuntu / Debian

```bash
sudo apt update
sudo apt install sqlite3 -y
sqlite3 --version
```

### Fedora / RHEL

```bash
sudo dnf install sqlite -y
sqlite3 --version
```

### Arch Linux

```bash
sudo pacman -S sqlite
sqlite3 --version
```

### Desde fuente (cualquier distro)

```bash
wget https://www.sqlite.org/2025/sqlite-autoconf-3490100.tar.gz
tar -xzf sqlite-autoconf-3490100.tar.gz
cd sqlite-autoconf-3490100
./configure
make
sudo make install
sqlite3 --version
```

## macOS

### Homebrew

```bash
brew install sqlite3
sqlite3 --version
```

### Desde fuente

```bash
curl -O https://www.sqlite.org/2025/sqlite-autoconf-3490100.tar.gz
tar -xzf sqlite-autoconf-3490100.tar.gz
cd sqlite-autoconf-3490100
./configure
make
sudo make install
sqlite3 --version
```

## Verificación común

```bash
sqlite3 :memory: "SELECT sqlite_version();"
```

function Write-Log {
    param (
        $message
    )
    $formattedTime = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    Write-Host "$formattedTime init_vm: $message"
}

$BUILD_DIRECTORY="C:\BuildArtifacts"
$INSTALL_DIRECTORY="C:\Software"

Set-Location -Path $BUILD_DIRECTORY

# WSL2
Write-Log "Installing WSL2..."
Start-Process wsl -ArgumentList "--install" -Wait
Start-Process wsl -ArgumentList "--update" -Wait

# Docker desktop
$DOCKER_DOWNLOAD_URL="https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe"
$DOCKER_INSTALLER_FILE="docker_installer.exe"
$DOCKER_INSTALLATION_DIR="$INSTALL_DIRECTORY\Docker"
$DOCKER_INSTALL_ARGS="install --quiet --noreboot --installation-dir=$DOCKER_INSTALLATION_DIR"

Write-Log "Downloading docker desktop installer..."
Invoke-WebRequest -Uri $DOCKER_DOWNLOAD_URL -UseBasicParsing -OutFile "$BUILD_DIRECTORY\$DOCKER_INSTALLER_FILE"

Write-Log "Installing docker desktop..."
Start-Process $DOCKER_INSTALLER_FILE -ArgumentList $DOCKER_INSTALL_ARGS -Wait

Write-Log "Moving shortcut to desktop..."
Move-Item -Path "$BUILD_DIRECTORY\Docker Desktop.lnk" -Destination "~/Desktop"

Write-Log "add_docker script completed"
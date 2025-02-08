$ContainerManager = ""
# Check for docker
if (Get-Command docker -ErrorAction SilentlyContinue) {
    $ContainerManager = "docker"
} elseif (Get-Command podman -ErrorAction SilentlyContinue) {
    $ContainerManager = "podman"
} else {
    Write-Host "No container manager found. Please install Docker or Podman."
    exit 1
}

# Build the image
& $ContainerManager build -t porta137/comfy:latest .
& $ContainerManager run -it --rm --gpus all -v ./models:/models -p8188:8188 porta137/comfy:latest
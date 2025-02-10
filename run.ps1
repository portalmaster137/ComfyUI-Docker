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

Write-Host "Using $ContainerManager as container manager."


# mkdir -p /models/checkpoints /models/clip /models/clip_vision /models/configs /models/controlnet /models/diffusion_models /models/unet /models/embeddings /models/loras /models/upscale_models /models/vae
# Make the folders only if they don't exist
if (!(Test-Path ./models/checkpoints)) { mkdir ./models/checkpoints }
if (!(Test-Path ./models/clip)) { mkdir ./models/clip }
if (!(Test-Path ./models/clip_vision)) { mkdir ./models/clip_vision }
if (!(Test-Path ./models/configs)) { mkdir ./models/configs }
if (!(Test-Path ./models/controlnet)) { mkdir ./models/controlnet }
if (!(Test-Path ./models/diffusion_models)) { mkdir ./models/diffusion_models }
if (!(Test-Path ./models/unet)) { mkdir ./models/unet }
if (!(Test-Path ./models/embeddings)) { mkdir ./models/embeddings }
if (!(Test-Path ./models/loras)) { mkdir ./models/loras }
if (!(Test-Path ./models/upscale_models)) { mkdir ./models/upscale_models }
if (!(Test-Path ./models/vae)) { mkdir ./models/vae }
if (!(Test-Path ./models/vae_approx)) { mkdir ./models/vae_approx }
if (!(Test-Path ./models/text_encoders)) { mkdir ./models/text_encoders }
if (!(Test-Path ./custom)) { mkdir ./custom }

Write-Host "Running the container."

# Build the image
& $ContainerManager build -t porta137/comfy:latest .
& $ContainerManager run -it --rm --gpus all -v .\models\:/models -v.\custom\:/root/comfy/ComfyUI/custom_nodes -p8188:8188 porta137/comfy:latest
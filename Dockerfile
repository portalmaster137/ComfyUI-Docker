FROM nvidia/cuda:12.8.0-cudnn-runtime-ubuntu24.04 AS cuda

RUN apt-get update && apt-get install -y python3 python3-pip python3-venv git

RUN python3 -m venv /venv
ENV VIRTUAL_ENV /venv
ENV PATH /venv/bin:$PATH

WORKDIR /comfyui

RUN pip install comfy-cli

RUN comfy --skip-prompt install --nvidia

WORKDIR /root/comfy/ComfyUI

RUN mkdir -p /models/checkpoints /models/clip /models/clip_vision /models/configs /models/controlnet /models/diffusion_models /models/unet /models/embeddings /models/loras /models/upscale_models /models/vae

VOLUME [ "/models" ]

RUN rm extra_model_paths.yaml.example
COPY extra_model_paths.yaml .

EXPOSE 3000
EXPOSE 8188

ENTRYPOINT [ "comfy", "launch", "--", "--listen", "0.0.0.0" ]
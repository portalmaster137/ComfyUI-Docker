FROM python:3.12-slim

RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget 

RUN python3 -m venv /venv
ENV VIRTUAL_ENV=/venv
ENV PATH=/venv/bin:$PATH

WORKDIR /comfyui

RUN pip install comfy-cli

RUN comfy --skip-prompt install --nvidia

WORKDIR /root/comfy/ComfyUI

RUN mkdir -p /models/checkpoints /models/clip /models/clip_vision /models/configs /models/controlnet /models/diffusion_models /models/unet /models/embeddings /models/loras /models/upscale_models /models/vae /models/vae_approx


RUN rm extra_model_paths.yaml.example
COPY extra_model_paths.yaml .


EXPOSE 3000
EXPOSE 8188

COPY entrypoint.sh .

CMD [ "/bin/bash", "entrypoint.sh" ]
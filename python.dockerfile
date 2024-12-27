# Use uma imagem base compatível com NVIDIA
FROM nvidia/cuda:12.6.3-cudnn-runtime-ubuntu24.04

# Instalar dependências básicas
RUN apt update
RUN apt install git software-properties-common -y
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt update
RUN apt install -y python3.10 python3.10-distutils curl libgl1 libglib2.0-0 google-perftools
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10
RUN apt clean && rm -rf /var/lib/apt/lists/*

# Criar diretórios para a aplicação
WORKDIR /app

# Clonar o repositório do stable-diffusion-webui
COPY stable-diffusion-webui-1.10.0/ /app

WORKDIR /app

# Configurar o ambiente virtual
RUN pip3.10 install torch==2.1.0 torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
RUN pip3.10 install -r requirements.txt 

# Definir o ponto de entrada
ENTRYPOINT ["python3.10", "launch.py"]

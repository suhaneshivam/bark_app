FROM python:3.10-slim as builder
RUN apt update && \
        apt install --no-install-recommends -y build-essential gcc
WORKDIR /app
COPY requirements.txt /app/requirements.txt

RUN pip install --no-cache-dir --user -r /app/requirements.txt

FROM nvidia/cuda:12.1.1-cudnn8-runtime-ubuntu22.04
WORKDIR /app

RUN apt update && \
        apt install --no-install-recommends -y build-essential software-properties-common && \
        apt install --no-install-recommends -y python3.10 python3-distutils && \
        update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1 && \
        apt clean && rm -rf /var/lib/apt/lists/*

COPY --from=builder /root/.local/lib/python3.10/site-packages /usr/local/lib/python3.10/dist-packages
COPY . /app
CMD ["python3", "-m", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
EXPOSE 8000

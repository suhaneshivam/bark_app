# bark_app : Step by step guide to build image and run container
1. The Dockerfile is using nvidia/cuda:12.1.1-cudnn8-runtime as base image optimized for UBUNTU:22.04 LTS distro as base image. 
As a rule of thumb, we should always use the same version of cuda and cudnn version inside docker containers as host machine. 
2. In order to use CUDA inside Docker container, nvidia-container-toolkit has to be installed first on host machine. Guide for 
installing nvidia-container-toolkit can be [found here](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#installing-on-ubuntu-and-debian)
3. The Dockerfile is a two-stage docker file which is a standard practice used for memory optimization.
4. The python version being used inside contained is python3.10.6.

# steps to run service:

1.Install `nvidia-container-toolkit` by follwing [this link](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#installing-on-ubuntu-and-debian)

2.build docker image using 
    `docker build -t <image_name>`
    
3.The app is exposed on port 8000 so we have to publish the port 8000 so that the app can be accessed from outside of the container.
    `docker run -p 8000:8000 -d -it --name <container-name> --gpus all <image-name>`
  
4.Now, it should start service at port 8000. Service can be accessed with url: `http://0.0.0.0:8000/generate_audio` with payload
  `{"text" : "text to convert"}`
  
5.Service will retunr response as `{"audio_array" : audio_array}`
  
6.Audio array is a list rather than numpy ndarray because it is not possible to return an ndarray using FastAPI.


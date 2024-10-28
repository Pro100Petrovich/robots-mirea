# Use Ubuntu 20.04 as the base image
FROM ubuntu:20.04

# Set environment variables
ENV PYTHON_VERSION=3.10

# Update the package list and install Python 3.10 and pip
RUN apt-get update && apt-get install -y \
    software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update && apt-get install -y \
    python${PYTHON_VERSION} python${PYTHON_VERSION}-dev python3-pip python3-distutils sudo git curl ffmpeg libsm6 libxext6 libgl1-mesa-dev libosmesa6-dev wget\
    && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py\
    && update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1 \
    && sudo python3 get-pip.py 
    
# Set the working directory inside the container
WORKDIR /app

# Copy your Python dependencies file
COPY APRL APRL
COPY dmcgym dmcgym
RUN pip3 install jaxlib==0.3.25 -f https://storage.googleapis.com/jax-releases/jax_cuda_releases.html
RUN pip3 install -r dmcgym/requirements.txt 
RUN pip3 install --upgrade setuptools
RUN pip3 install -e dmcgym/
RUN pip3 install tensorflow==2.11.0
RUN pip3 install -r APRL/requirements.txt && pip3 install -e APRL/  

# Install Python dependencies

# Default command to run on container start
CMD ["/bin/bash"]

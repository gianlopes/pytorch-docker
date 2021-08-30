FROM nvidia/cuda:10.1-cudnn7-runtime
# ensure system is updated and has basic build tools
RUN apt-get -f -y upgrade
RUN apt-get clean
RUN apt-get update --fix-missing
RUN apt-get -f -y install \
    tmux \
    build-essential \
    gcc g++ make \
    openssh-server \
    binutils \
    curl \
    nano \
    unzip\
    unrar \
    openvpn \
    git \
	ffmpeg \
	openexr \
	libgtk2.0-0 \
    software-properties-common file locales uuid-runtime \
    wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    mercurial subversion

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/archive/Anaconda3-2020.02-Linux-x86_64.sh	-O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh

ENV PATH /opt/conda/bin:$PATH

RUN conda install \
        jupyter \
        matplotlib \
        numpy \
        scipy \
        scikit-learn \
        scikit-image \
        pandas \
        seaborn \
        Pillow \
        tqdm
        
RUN conda install pytorch torchvision cudatoolkit=10.1 -c pytorch

# install tensorflow & keras
RUN pip --no-cache-dir install --upgrade \
        opencv-python-headless
	
#start ssh and terminal
CMD /etc/init.d/ssh start ; /bin/bash
#expose for ssh
EXPOSE 22

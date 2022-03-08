FROM ubuntu:20.04

# ----------------------
# Necessary for most operations

RUN useradd -m user
RUN apt-get update

# ----------------------
# Necessary for Chinese typing

RUN DEBIAN_FRONTEND=noninteractive \
      apt-get install -y \
      fonts-noto-cjk language-pack-zh-hans
RUN locale-gen zh_TW.UTF-8  
ENV LC_ALL=zh_TW.UTF-8

# ------------------
# Git

RUN mkdir /app
WORKDIR /app

RUN DEBIAN_FRONTEND=noninteractive \
      apt-get install -y \
      git 

# ------------------
# Python

RUN DEBIAN_FRONTEND=noninteractive \
      apt install software-properties-common -y
RUN DEBIAN_FRONTEND=noninteractive \
      add-apt-repository ppa:deadsnakes/ppa -y

#RUN DEBIAN_FRONTEND=noninteractive \
#      apt-get update

RUN DEBIAN_FRONTEND=noninteractive \
      apt-get update && apt-get install -y \
      python3.7 python2

RUN DEBIAN_FRONTEND=noninteractive \
      apt-get install -y \
      python3-pip

RUN DEBIAN_FRONTEND=noninteractive \
      apt-get install -y \
      wget

# ------------------------------

# ------------------------------
# Install project

RUN git clone https://github.com/tokland/pysheng
WORKDIR /app/pysheng
RUN python2 setup.py install

RUN wget -c http://archive.ubuntu.com/ubuntu/pool/universe/p/pygtk/python-gtk2_2.24.0-5.1ubuntu2_amd64.deb
RUN apt-get install ./python-gtk2_2.24.0-5.1ubuntu2_amd64.deb -y

RUN wget -c http://archive.ubuntu.com/ubuntu/pool/universe/p/pygtk/python-glade2_2.24.0-5.1ubuntu2_amd64.deb
RUN apt-get install ./python-glade2_2.24.0-5.1ubuntu2_amd64.deb -y

#RUN pip3 install -r requirements.txt
#RUN python3 GoBooDo.py --id=XUwOtdcIWdkC

# ---------------------------------
# Install Python's modules

#RUN python3 -m pip3 -y
#RUN pip3 install gtk
WORKDIR /home/user/
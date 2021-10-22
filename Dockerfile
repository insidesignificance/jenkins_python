FROM jenkins/jenkins:lts-jdk11

USER root

# Install Python 3.8 from source
# RUN apt-get update
# RUN apt-get -y install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget tar
# WORKDIR /tmp
# RUN wget https://www.python.org/ftp/python/3.8.12/Python-3.8.12.tgz
# RUN tar xzf Python-3.8.12.tgz
# WORKDIR Python-3.8.12
# RUN ./configure --enable-optimizations
# RUN make install

# Update apt packages
RUN apt-get update -y
# RUN apt-get upgrade -y

# Install vim
RUN apt-get install -y vim

# Install python 3
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get install -y python3

# Make python 3 the default
RUN echo "alias python=python3" >> ~/.bashrc
RUN export PATH=${PATH}:/usr/bin/python3
RUN /bin/bash -c "source ~/.bashrc"

# Add 3 to the available alternatives
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1

# Set python3 as the default python
RUN update-alternatives --set python /usr/bin/python3

# Install pip
RUN apt-get install -y python3-pip
RUN python3 -m pip install --upgrade pip

# Install pip packages
WORKDIR /tmp
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

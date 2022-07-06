FROM ubuntu:18.04

USER root
# Arguments for configuring tzdata silently
ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=America/Mexico_City

# Install Yocto dependencies
RUN apt-get update &&  \
    apt-get install -y \
    vim \
    sudo \
    less \
    locales \
    curl  \
    zip \
    screen \
    tmux \
    unzip \
    bridge-utils \
    iputils-ping \
    fluxbox \
    net-tools \
    htop \
    lsb-release \
    gawk \
    wget \
    git-core \
    diffstat \
    sysstat \
    unzip \
    texinfo \
    qemu \
    build-essential  \
    chrpath  \
    socat  \
    libsdl1.2-dev  \
    xterm \
    cpio \
    python \
    python3 \
    python3-pip \
    python3-pexpect \
    xz-utils \
    debianutils \
    iputils-ping \
    python3-git \
    python3-jinja2 \
    libegl1-mesa \
    libsdl1.2-dev \
    pylint3 \
    python3-subunit \
    mesa-common-dev\
    make \
    python3-pip \
    zstd \
    liblz4-tool \
    iproute2 \
    uml-utilities \
    gcc-multilib && \
    rm -rf /var/lib/apt/lists/*

# Configure locale
RUN rm bin/sh && ln -s bash /bin/sh
RUN locale-gen en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Install Yocto documentation
RUN pip3 install \
    sphinx \
    sphinx_rtd_theme \
    pyyaml

# Dev user arguments
ARG DEV_USER=dev
ARG DEV_UID=1000
ARG DEV_GID=1000
ARG DEV_PW=dev
ARG HOME_DIR=/home/dev
ARG WORK_DIR=${HOME_DIR}/yocto_workspace

# Add dev user
RUN groupadd --gid "${DEV_GID}" "${DEV_USER}" && \
    useradd -l \
      --uid ${DEV_UID} \
      --gid ${DEV_GID} \
      --home-dir ${HOME_DIR} \
      --create-home \
      --shell /bin/bash \
      ${DEV_USER}

RUN echo "${DEV_USER}:${DEV_PW}" | chpasswd

RUN usermod -aG sudo ${DEV_USER}

USER ${DEV_UID}:${DEV_GID}
WORKDIR ${WORK_DIR}

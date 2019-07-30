FROM ubuntu:18.04

MAINTAINER videah <videah@selfish.systems>

COPY . /app
RUN apt-get update && \
  apt-get install -y qemu-system qemu-utils python3 python3-pip git \
  qemu-kvm libvirt-bin virtinst bridge-utils cpu-checker locales

# Fixes encoding issues for click.py when downloading the image.
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Configuration options
ENV MACOS_VERSION mojave
ENV MACOS_MEMORY 2G
ENV MACOS_CPUS 1
ENV MACOS_DRIVE /data/mac_drive.qcow2
ENV MACOS_DRIVE_SIZE 32G

WORKDIR /macos

ENTRYPOINT ["/app/run.sh"]

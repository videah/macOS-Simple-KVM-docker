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

WORKDIR /macos

ENTRYPOINT ["/app/run.sh"]

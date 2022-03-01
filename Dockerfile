FROM ubuntu:20.10 
ENV DEBIAN_FRONTEND=noninteractive
RUN sed -i -e 's/ports.ubuntu.com\/ubuntu-ports/old-releases.ubuntu.com\/ubuntu/g' \
           -e 's/archive.ubuntu.com\/ubuntu/old-releases.ubuntu.com\/ubuntu/g' \
           -e 's/security.ubuntu.com\/ubuntu/old-releases.ubuntu.com\/ubuntu/g' \
	   /etc/apt/sources.list \
    && apt-get update -y \
    && apt-get dist-upgrade -y \
    && apt-get install -y \
       qt5-default \
       libfreeimage3 \
       libqwt-qt5-6 \
       libopencv-core4.2 \
       libopencv-dev libfreeimage-dev \
       libqwt-qt5-dev qt5-qmake qttools5-dev-tools \
       git cmake g++  \
     && cd /tmp && git clone https://github.com/sandsmark/diffimg.git \
     && cd /tmp/diffimg \
     && cmake /tmp/diffimg  \
     && find /usr/lib -name "libQt5Core.so.5*" -exec strip --remove-section=.note.ABI-tag {} \;  \
     && make -j2

FROM ubuntu:20.10
ENV DEBIAN_FRONTEND=noninteractive
RUN sed -i -e 's/ports.ubuntu.com\/ubuntu-ports/old-releases.ubuntu.com\/ubuntu/g' \
           -e 's/archive.ubuntu.com\/ubuntu/old-releases.ubuntu.com\/ubuntu/g' \
           -e 's/security.ubuntu.com\/ubuntu/old-releases.ubuntu.com\/ubuntu/g' \
	   /etc/apt/sources.list \
    && apt-get update -y \
    && apt-get dist-upgrade -y \
    && apt-get install -y \
       qt5-default \
       libfreeimage3 \
       libqwt-qt5-6 \
       libopencv-core4.2 \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

COPY --from=0 /tmp/diffimg/diffimg /usr/local/bin/

ENV QT_X11_NO_MITSHM 1

CMD [ "/usr/local/bin/diffimg" ]

FROM ubuntu:20.10 
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /tmp/
RUN apt-get update && \
  apt-get install -y \
    libopencv-dev libfreeimage-dev qt5-default \
    libqwt-qt5-dev qt5-qmake qttools5-dev-tools git \
    cmake g++ && \
  git clone https://github.com/sandsmark/diffimg.git && \
  cd diffimg && \
  cmake /tmp/diffimg && \
  find /usr/lib -name "libQt5Core.so.5*" -exec strip --remove-section=.note.ABI-tag {} \; && \
  make -j


FROM ubuntu:20.10
RUN apt-get update && \
    apt-get install -y \
       qt5-default \
       libfreeimage3 \
       libqwt-qt5-6 \
       libopencv-core4.2 # libopencv-features2d4.2

COPY --from=0 /tmp/diffimg/diffimg /usr/local/bin/

ENV QT_X11_NO_MITSHM 1

CMD [ "/usr/local/bin/diffimg" ]

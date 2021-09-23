FROM ubuntu:20.10 
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
  apt-get install -y \
    libopencv-dev libfreeimage-dev qt5-default \
    libqwt-qt5-dev qt5-qmake qttools5-dev-tools \
    cmake g++ git
RUN cd / && \
    git clone https://github.com/sandsmark/diffimg
WORKDIR /diffimg
RUN  cmake /diffimg && \
  find /usr/lib -name "libQt5Core.so.5*" -exec strip --remove-section=.note.ABI-tag {} \; && \
  make -j


FROM ubuntu:20.10
WORKDIR /diffimg
RUN apt-get update && \
  apt-get install -y qt5-default libqwt-qt5-6 libxkbcommon-x11-0 && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  find /usr/lib -name "libQt5Core.so.5*" -exec strip --remove-section=.note.ABI-tag {} \;

COPY --from=0 /diffimg/diffimg /diffimg/


ENV QT_X11_NO_MITSHM 1
ENV XDG_RUNTIME_DIR /tmp
CMD [ "/diffimg/diffimg" ]
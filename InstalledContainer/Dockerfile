ARG compiler "gcc"

FROM ikarusproject/ikarus-dev-${compiler}:latest
ARG branch "main"
ENV BRANCH=${branch}
USER 1001
ARG ccompiler "gcc-12"
ENV C_COMPILER=${ccompiler}

ARG cppcompiler "g++-12"
ENV CPP_COMPILER=${cppcompiler}
#docker build --squash -t ikarusproject/ikarus-gcc:latest --build-arg compiler="gcc" --build-arg ccompiler="gcc-12" --build-arg cppcompiler="g++-12"  . &> build.log
#docker build --squash -t ikarusproject/ikarus-clang:latest --build-arg compiler="clang" --build-arg ccompiler="clang-16" --build-arg cppcompiler="clang++-16"  . &> build.log


ENV DEBIAN_FRONTEND "noninteractive"
ENV CI true
EXPOSE 8000

# WORKDIR $HOME
# RUN useradd --create-home --no-log-init --shell /bin/bash docker
# USER docker
# WORKDIR /home/docker
RUN ls -l /usr/local/lib
#USER 1001
USER root
RUN apt-get update && apt-get install sudo -y
RUN usermod -aG sudo user
USER 1001

RUN cd /dune && git  clone https://github.com/ikarus-project/Ikarus.git && \
    cd Ikarus && \
    git checkout ${BRANCH}

RUN cd /dune &&  /dune/dune-common/bin/dunecontrol --only=ikarus --cmake-opts="$DUNE_MODULE_CMAKE_FLAGS" cmake -DDUNE_PYTHON_INSTALL_LOCATION="none" &&\
   sudo /dune/dune-common/bin/dunecontrol --only=ikarus --cmake-opts="$DUNE_MODULE_CMAKE_FLAGS" make install

CMD [ "/bin/sh" ]



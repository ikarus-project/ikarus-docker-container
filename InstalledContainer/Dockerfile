FROM rath3t/ikarus-dev:latest




ARG branch "main"
ENV BRANCH=${branch}


ENV DEBIAN_FRONTEND "noninteractive"
ENV CI true
EXPOSE 8000

# WORKDIR $HOME
# RUN useradd --create-home --no-log-init --shell /bin/bash docker
# USER docker
# WORKDIR /home/docker

RUN git clone https://github.com/IkarusRepo/Ikarus.git && \
    cd Ikarus && \
    git checkout ${BRANCH} && \
    mkdir build && \
    cd build && \
    cmake .. && \
    cmake --build . --target ikarus && \
    cmake --install . && \
    cd ../.. && \
    rm -rf Ikarus


CMD [ "/bin/sh" ]



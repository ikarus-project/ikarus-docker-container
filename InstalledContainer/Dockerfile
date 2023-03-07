FROM ikarusproject/ikarus-dev:latest


USER root


ARG branch "main"
ENV BRANCH=${branch}


ENV DEBIAN_FRONTEND "noninteractive"
ENV CI true
EXPOSE 8000

# WORKDIR $HOME
# RUN useradd --create-home --no-log-init --shell /bin/bash docker
# USER docker
# WORKDIR /home/docker


RUN git clone https://github.com/ikarus-project/Ikarus.git && \
    cd Ikarus && \
    git checkout ${BRANCH} && \
    mkdir build && \
    cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release -DDUNE_PYTHON_ALLOW_GET_PIP=1 -DDUNE_PYTHON_VIRTUALENV_SETUP=TRUE -DDUNE_ENABLE_PYTHONBINDINGS=TRUE -DBUILD_SHARED_LIBS=TRUE && \
    cmake --build . --target ikarus && \
    cmake --install . 



CMD [ "/bin/sh" ]



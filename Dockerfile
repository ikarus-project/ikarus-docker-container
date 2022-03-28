FROM debian:bookworm



ENV DEBIAN_FRONTEND "noninteractive"
ENV CI true
EXPOSE 8000

# WORKDIR $HOME
# RUN useradd --create-home --no-log-init --shell /bin/bash docker
# USER docker
# WORKDIR /home/docker

RUN apt-get update -q -y  && \
     apt update && \
   apt -y --no-install-recommends install build-essential \
  libssl-dev \
  git \
  wget \
  apt-utils \
  software-properties-common \
  gfortran \
  gcc-11 \
  g++-11 \
  gdb  \
  lldb \
  gcovr \
  clang \
  libgbm1 \
  libmetis-dev \
  libnss3 \
  libxss1 \
  libxtst6 \
  libsecret-1-0 \
  xdg-utils \
  clang-tidy \
  libclang-13-dev \
  clang-format-13 \
  libc++-13-dev \
  libc++abi-13-dev \
  llvm-13-dev \
  liblapack-dev \
  libopenblas-dev \
  libsuitesparse-dev \
  libdune-common-dev \
  libdune-geometry-dev \
  libdune-grid-dev \
  libdune-functions-dev \
  libdune-typetree-dev \
  libdune-localfunctions-dev \
  libdune-uggrid-dev \
  libdune-grid-glue-dev \
  libdune-istl-dev \
  libspdlog-dev \
  libbenchmark-dev \
  libgtest-dev \
  gnuplot \
  python3 \
  pip \
  clang-format-12 \
  gnuplot-x11 \
  curl \
  cppcheck && \
  apt-get install libayatana-appindicator3-1 -y && \
  apt-get -y -f install && \
  apt install libasound2 xvfb -y && \
  wget https://github.com/jgraph/drawio-desktop/releases/download/v16.5.1/drawio-amd64-16.5.1.deb && \
  dpkg -i drawio-amd64-16.5.1.deb && \
  rm drawio-amd64-16.5.1.deb && \
  pip install cmakelang==0.6.13 pyyaml && \
  pip install mkdocs && \
  pip install mkdocs-material && \
  pip install mkdocs-macros-plugin && \
  pip install mkdocs-drawio-exporter && \
  cp /usr/bin/clang-format-12 /usr/bin/clang-format && \
  cd ~ && \
  mkdir -p iwyu && \
  cd iwyu && \
  git clone https://github.com/include-what-you-use/include-what-you-use.git && \
  cd include-what-you-use && \
  git checkout clang_13 && \
  cd .. && \
  mkdir -p build && cd build && \
  cmake -G "Unix Makefiles" -DIWYU_LLVM_ROOT_PATH=/usr/lib/llvm-13 ../include-what-you-use && \
  make && \
  make install && \
  cd ~ && \
  rm -rf iwyu && \
  cd /usr/src/googletest && \
  cmake . && \
  cmake --build . --target install && \
  cd ~ && \
  git clone https://gitlab.com/libeigen/eigen.git && \
  cd eigen && \
  git checkout 3.4 && \
  mkdir build && \
  cd build && \
  cmake ../ && \
  make install && \
  cd ~ && \
  rm -rf eigen && \
  git clone https://github.com/alandefreitas/matplotplusplus.git && \
  cd matplotplusplus && \
  mkdir -p build && \
  cd build && \
  cmake .. -DCMAKE_BUILD_TYPE=Release -DBUILD_EXAMPLES=OFF -DBUILD_TESTS=OFF && \
  cmake --build . --parallel 4 --config Release && \
  cmake --install . && \
  cd ~ && \
  rm -rf matplotplusplus && \
  git clone https://github.com/autodiff/autodiff && \
  cd autodiff/ && \
  mkdir .build && \
  cd .build/ && \
  cmake .. -DAUTODIFF_BUILD_PYTHON=0 -DAUTODIFF_BUILD_EXAMPLES=0 -DAUTODIFF_BUILD_DOCS=0 -DAUTODIFF_BUILD_TESTS=0 && \
   cmake --build . --target install && \
  cd ../.. && \
  mkdir -p dune && \
  cd dune && \
  git clone https://gitlab.dune-project.org/extensions/dune-alugrid.git && \
  git clone https://gitlab.dune-project.org/extensions/dune-foamgrid.git && \
  dunecontrol git checkout releases/2.8 && \
  git clone https://github.com/rath3t/dune-iga.git && \
  dunecontrol cmake "-DCMAKE_BUILD_TYPE=Release" && \
  dunecontrol make && \
  dunecontrol make install && \
  cd .. && \
  rm -rf dune && \
  apt-get auto-remove -y && \
  apt-get clean && \
  rm -rvf /var/lib/apt/lists/* && \
  rm -rvf /var/cache/apt/archives/* && \
  apt-get -y remove  \
  software-properties-common

CMD [ "/bin/sh" ]



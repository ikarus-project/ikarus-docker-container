FROM debian:bookworm-slim

LABEL org.opencontainers.image.authors="mueller@ibb.uni-stuttgart.de"

ARG DEBIAN_FRONTEND=noninteractive
ENV CI true
EXPOSE 8000
ENV DISPLAY=:0
ENV LD_LIBRARY_PATH=/usr/lib/wsl/lib


RUN apt-get update -q -y  && apt-get -y --no-install-recommends install build-essential  \
zlib1g-dev \
 libbz2-dev \ 
 libreadline-dev \
  libsqlite3-dev\
    curl \ 
    llvm \ 
    libncurses5-dev \ 
    libncursesw5-dev \ 
    libgdbm-dev \
    libc6-dev \
 xz-utils \ 
 tk-dev \ 
 libffi-dev \ 
 liblzma-dev \ 
 python3-openssl \ 
  libssl-dev \
  git \
  wget \
  apt-utils \
  software-properties-common \
  gfortran \
  gcc-12 \
  g++-12 \
  cmake \
  gdb  \
  lldb \
  lcov \
  gcovr \
  nano \
  valgrind \
  mesa-utils \
  clang \
  libgbm1 \
  libmetis-dev \
  libnss3 \
  pkg-config \
  libxss1 \
  libxtst6 \
  libsecret-1-0 \
  xdg-utils \
  clang-tidy \
  libclang-14-dev \
  clang-format-13 \
  libc++-14-dev \
  libc++abi-14-dev \
  llvm-14-dev \
  liblapack-dev \
  libopenblas-dev \
  libsuitesparse-dev \
  libsuperlu-dev \
  libquadmath0 \
  libopenmpi-dev \
  gnuplot \
  python3-dev \
  python3 \
  python3-pip

  RUN  update-alternatives --install /usr/bin/python python /usr/bin/python3.11 11

  RUN python3 -m pip install --upgrade pip && \
  python3 -m pip install --no-cache-dir virtualenv \
  cmakelang==0.6.13 \
  pyyaml \
  mkdocs \
  mkdocs-material \
  mkdocs-macros-plugin \
  mkdocs-bibtex \
  mkdocs-glightbox \
  codespell \
  pillow \
  cairosvg \
  "pybind11[global]" \
  scikit-build \
  numpy \
  scipy \
  mpi4py \
  twine \
  matplotlib

  RUN apt-get -y --no-install-recommends install \
  gnuplot-x11 \
  curl \
  cppcheck \
  libayatana-appindicator3-1  \
  libasound2 xvfb && \
  git clone https://github.com/gabime/spdlog.git && \
  cd spdlog && \
  git checkout v1.10.0 && \
  mkdir build && \
  cd build && \
  cmake .. -DSPDLOG_FMT_EXTERNAL=FALSE && \
  make install && \
  cd ~ && \
  rm -rf fmt && \
  cd ~ && \
  cp /usr/bin/clang-format-13 /usr/bin/clang-format && \
  cd ~ && \
  mkdir -p iwyu && \
  cd iwyu && \
  git clone https://github.com/include-what-you-use/include-what-you-use.git && \
  cd include-what-you-use && \
  git checkout clang_14 && \
  cd .. && \
  mkdir -p build && cd build && \
  cmake -G "Unix Makefiles" -DIWYU_LLVM_ROOT_PATH=/usr/lib/llvm-14 ../include-what-you-use && \
  make && \
  make install && \
  cd ~ && \
  rm -rf iwyu && \
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
  git checkout v1.1.0 && \
  mkdir -p build && \
  cd build && \
  cmake .. -DCMAKE_BUILD_TYPE=Release -DBUILD_EXAMPLES=OFF -DBUILD_TESTS=OFF -DBUILD_SHARED_LIBS=1 && \
  cmake --build . --parallel 4 --config Release && \
  cmake --install . && \
  cd ~ && \
  rm -rf matplotplusplus

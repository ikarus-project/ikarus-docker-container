ARG debianversion "bookworm"

FROM debian:${debianversion}-slim
#docker build --squash -t ikarusproject/debian12:latest . &> build.log
LABEL maintainer=mueller@ibb.uni-stuttgart.de

ARG DEBIAN_FRONTEND=noninteractive
ENV CI true
EXPOSE 8000
ENV DISPLAY=:0
ENV LD_LIBRARY_PATH=/usr/lib/wsl/lib

RUN apt-get update -q -y && apt-get -y --no-install-recommends install build-essential \
  python3 \
  python3-pip \
  python3-dev \
  python3-venv \
  libssl-dev \
  lsb-release \
  git \
  wget \
  apt-utils \
  gfortran \
  gcc-12 \
  g++-12 \
  cmake \
  gdb  \
  ccache \
  lcov \
  gcovr \
  nano \
  valgrind \
  mesa-utils \
  libgbm1 \
  libmetis-dev \
  libnss3 \
  pkg-config \
  libxss1 \
  libxtst6 \
  libsecret-1-0 \
  xdg-utils \
  clang-tidy \
  liblapack-dev \
  libopenblas-dev \
  libsuitesparse-dev \
  libsuperlu-dev \
  libquadmath0 \
  libopenmpi-dev \
  doxygen \
  graphviz \ 
  gnuplot \
  libtbb-dev \
  python-is-python3 \
  mpi4py 


RUN DISTRO=$(lsb_release -sc) && \
  if [ "$DISTRO" == "trixie" ]; then \
    apt-get update -q -y && apt-get -y --no-install-recommends install gcc-14 g++-14 gcc-13 g++-13; \
  fi

RUN python3 -m pip install setuptools --no-cache-dir --break-system-packages && python3 -m pip install --no-cache-dir --break-system-packages \
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
  numpy==1.26.4 \
  scipy \
  twine \
  matplotlib \
  clang-format==18.1.8 \
  black==24.4.2 \
  spdlog
  
# RUN DISTRO=$(lsb_release -sc) && \
#   if [ "$DISTRO" = "trixie" ]; then \
#     python3 -m pip install setuptools --no-cache-dir --break-system-packages && python3 -m pip install --no-cache-dir --break-system-packages "mpi4py>4"; \
#   else \
#     python3 -m pip install setuptools --no-cache-dir --break-system-packages && python3 -m pip install --no-cache-dir --break-system-packages mpi4py==3.1.4; \
#   fi

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
  cmake .. -DSPDLOG_FMT_EXTERNAL=FALSE -DSPDLOG_BUILD_SHARED=1 -DSPDLOG_BUILD_PIC=1 && \
  make install && \
  cd ~ && \
  rm -rf fmt && \
  cd ~ && \
  git clone https://gitlab.com/libeigen/eigen.git && \
  cd eigen && \
  git checkout d26e19714fca2faf544619c3604f88d980e5a207 && \
  mkdir build && \
  cd build && \
  cmake ../ && \
  make install && \
  cd ~ && \
  rm -rf eigen && \
  git clone https://github.com/yixuan/spectra.git && \
  cd spectra && \
  mkdir build && cd build && \
  cmake .. -DBUILD_TESTS=FALSE && \
  make all && make install && \
  cd ~ && \
  rm -rf spectra && \
  git clone https://github.com/alandefreitas/matplotplusplus.git && \
  cd matplotplusplus && \
  git checkout v1.2.2 && \
  mkdir -p build && \
  cd build && \
  cmake .. -DCMAKE_BUILD_TYPE=Release -DMATPLOTPP_BUILD_EXAMPLES=OFF -DBUILD_TESTING=OFF -DBUILD_SHARED_LIBS=1 && \
  cmake --build . --parallel 4 --config Release && \
  cmake --install . && \
  cd ~ && \
  rm -rf matplotplusplus

RUN apt update && apt install -y lsb-release wget gnupg ca-certificates
RUN  DISTRO=$(lsb_release -sc) && \
    if [ "$DISTRO" != "trixie" ]; then \
        apt-get install -y --no-install-recommends software-properties-common; fi
RUN apt-get install --reinstall python3-apt -y
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | gpg --dearmor | tee /usr/share/keyrings/llvm-snaptshot.gpg
#RUN apt-add-repository "deb http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-16 main"
RUN wget https://raw.githubusercontent.com/opencollab/llvm-jenkins.debian.net/refs/heads/master/llvm.sh && \
  chmod +x llvm.sh && \
  DISTRO=$(lsb_release -sc) && \
  if [ "$DISTRO" != "trixie" ]; then \
   ./llvm.sh 16 all ; \
  fi  && \
  ./llvm.sh 17 all && \
  ./llvm.sh 18 all

RUN  update-alternatives --install /usr/bin/clang clang /usr/bin/clang-17 10
RUN  update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-17 10



# RUN mkdir -p iwyu && \
#   cd iwyu && \
#   git clone https://github.com/include-what-you-use/include-what-you-use.git && \
#   cd include-what-you-use && \
#   git checkout clang_17 && \
#   cd .. && \
#   mkdir -p build && cd build && \
#   cmake -G "Unix Makefiles" -DLLVM_DIR="$(llvm-config --cmakedir)" -DIWYU_LLVM_ROOT_PATH=/usr/lib/llvm-17 -DCMAKE_C_COMPILER=/usr/lib/llvm-17/bin/clang -DCMAKE_CXX_COMPILER=/usr/lib/llvm-17/bin/clang++ -DCMAKE_PREFIX_PATH=/usr/lib/llvm-17 ../include-what-you-use && \
#   make && \
#   make install && \
#   cd ~ && \
#   rm -rf iwyu

RUN git clone --branch v3.11.3 --depth 1 https://github.com/nlohmann/json.git && \
  cd json && \
  mkdir build && \
  cd build && \
  cmake .. -DJSON_BuildTests=0 &&  \
  make &&  \
  make install 

RUN git clone --branch master --depth 1 https://github.com/mapbox/earcut.hpp.git  && \
  cd earcut.hpp && \
  mkdir build && \
  cd build && \
  cmake .. -DEARCUT_BUILD_TESTS=OFF -DEARCUT_BUILD_BENCH=OFF -DEARCUT_BUILD_VIZ=OFF -DBUILD_SHARED_LIBS=ON && \
  cmake --build . --target install  

RUN git clone https://github.com/AngusJohnson/Clipper2.git && \
  cd Clipper2/CPP && \
  git checkout main && \
  mkdir build && \
  cd build && \
  cmake .. -DCLIPPER2_TESTS=0 -DBUILD_SHARED_LIBS=ON -DCLIPPER2_EXAMPLES=0 -DCLIPPER2_USINGZ=ON && \
  cmake --build . --target install --parallel 2 && \
  cd / && \
  rm -rf Clipper2

RUN git clone https://github.com/dmillard/eigengdb && \
  cd eigengdb && \
  python3 setup.py install && \
  python3 bin/eigengdb_register_printers && \
  gdb -q -iex "add-auto-load-safe-path /tmp/Ikarus/.gdbinit"

RUN  git clone https://github.com/autodiff/autodiff && \
  cd autodiff/ && \
  git checkout v1.0.3 && \
  mkdir .build && \
  cd .build/ && \
  cmake .. -DAUTODIFF_BUILD_PYTHON=1 -DAUTODIFF_BUILD_EXAMPLES=0 -DAUTODIFF_BUILD_DOCS=0 -DAUTODIFF_BUILD_TESTS=0 -DCMAKE_CCACHE_IGNORE=1 && \
  cmake --build . --target install --parallel 2 

RUN git clone https://bitbucket.org/ignromero/muesli.git && \
  cd muesli && \
  git checkout 27e8204971602cb042d633b8b5f87761272b10df
COPY patches/CMakeLists.txt /muesli
COPY patches/MuesliConfig.cmake.in /muesli
RUN cd muesli && \
  mkdir build &&  cd build && \
  cmake .. && \
  cmake --build . --target install --parallel 2  

FROM debian:bookworm-slim

MAINTAINER mueller@ibb.uni-stuttgart.de

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
  git \
  wget \
  apt-utils \
  software-properties-common \
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
  clang-format-13 \
  liblapack-dev \
  libopenblas-dev \
  libsuitesparse-dev \
  libsuperlu-dev \
  libquadmath0 \
  libopenmpi-dev \
  gnuplot 

  RUN  update-alternatives --install /usr/bin/python python /usr/bin/python3.11 11

  RUN  python -m pip install --upgrade pip --break-system-packages && \
  python -m pip install --no-cache-dir --break-system-packages \
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
  git clone https://gitlab.com/libeigen/eigen.git && \
  cd eigen && \
  git checkout 3.4 && \
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
  git checkout v1.1.0 && \
  mkdir -p build && \
  cd build && \
  cmake .. -DCMAKE_BUILD_TYPE=Release -DBUILD_EXAMPLES=OFF -DBUILD_TESTS=OFF -DBUILD_SHARED_LIBS=1 && \
  cmake --build . --parallel 4 --config Release && \
  cmake --install . && \
  cd ~ && \
  rm -rf matplotplusplus

RUN apt update && apt install -y lsb-release wget software-properties-common gnupg ca-certificates
RUN apt install --reinstall python3-software-properties
RUN apt-get install --reinstall python3-apt
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key| apt-key add -
RUN apt-add-repository "deb http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-16 main"
RUN wget https://apt.llvm.org/llvm.sh && \
     chmod +x llvm.sh && \
     ./llvm.sh 16 all


RUN  update-alternatives --install /usr/bin/clang clang /usr/bin/clang-16 10
RUN  update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-16 10



RUN mkdir -p iwyu && \
  cd iwyu && \
  git clone https://github.com/include-what-you-use/include-what-you-use.git && \
  cd include-what-you-use && \
  git checkout clang_16 && \
  cd .. && \
  mkdir -p build && cd build && \
  cmake -G "Unix Makefiles" -DLLVM_DIR="$(llvm-config --cmakedir)" -DIWYU_LLVM_ROOT_PATH=/usr/lib/llvm-16 -DCMAKE_C_COMPILER=/usr/lib/llvm-16/bin/clang -DCMAKE_CXX_COMPILER=/usr/lib/llvm-16/bin/clang++ -DCMAKE_PREFIX_PATH=/usr/lib/llvm-16 ../include-what-you-use && \
  make && \
  make install && \
  cd ~ && \
  rm -rf iwyu
  
RUN git clone --branch v3.11.2 --depth 1 https://github.com/nlohmann/json.git && \
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
  git checkout Clipper2_1.0.6 && \
  mkdir build && \
  cd build && \
  cmake .. -DCLIPPER2_TESTS=0 -DBUILD_SHARED_LIBS=ON -DCLIPPER2_EXAMPLES=0 && \
  cmake --build . --target install --parallel 2 && \
  cd / && \
  rm -rf Clipper2

RUN git clone https://github.com/dmillard/eigengdb && \
  cd eigengdb && \
  python3.11 setup.py install && \
  python3.11 bin/eigengdb_register_printers && \
  gdb -q -iex "add-auto-load-safe-path /tmp/Ikarus/.gdbinit" && \
  git clone https://github.com/autodiff/autodiff && \
  cd autodiff/ && \
  mkdir .build && \
  cd .build/ && \
  cmake .. -DAUTODIFF_BUILD_PYTHON=1 -DAUTODIFF_BUILD_EXAMPLES=0 -DAUTODIFF_BUILD_DOCS=0 -DAUTODIFF_BUILD_TESTS=0 -DAUTODIFF_PYTHON_INSTALL_PREFIX="" && \
  cmake --build . --target install --parallel 2 

  RUN mkdir -p dune && \
  cd dune && \
  git clone https://gitlab.dune-project.org/core/dune-common.git && \
  git clone https://gitlab.dune-project.org/core/dune-geometry.git && \
  git clone https://gitlab.dune-project.org/core/dune-istl.git && \
  git clone https://gitlab.dune-project.org/core/dune-grid.git && \
  git clone https://gitlab.dune-project.org/staging/dune-uggrid.git && \
  git clone https://gitlab.dune-project.org/staging/dune-functions.git && \
  git clone https://gitlab.dune-project.org/staging/dune-typetree.git && \
  git clone https://gitlab.dune-project.org/core/dune-localfunctions.git && \
  git clone https://gitlab.dune-project.org/extensions/dune-alugrid.git && \
  git clone https://gitlab.dune-project.org/extensions/dune-foamgrid.git && \
  git clone https://gitlab.dune-project.org/fufem/dune-matrix-vector.git && \
  git clone https://gitlab.dune-project.org/extensions/dune-grid-glue.git && \
  git clone https://gitlab.dune-project.org/fufem/dune-fufem.git  && \
  git clone https://gitlab.mn.tu-dresden.de/iwr/dune-curvedgeometry.git && \
  git clone https://gitlab.mn.tu-dresden.de/iwr/dune-curvedgrid.git && \
  git clone https://gitlab.mn.tu-dresden.de/iwr/dune-gmsh4.git && \
  git clone https://gitlab.dune-project.org/extensions/dune-vtk.git && \
  dune-common/bin/dunecontrol git checkout master && \
  dune-common/bin/dunecontrol   --cmake-opts="-DCMAKE_CXX_FLAGS='-O3' -DPython3_EXECUTABLE=/usr/bin/python -DPython3_INCLUDE_DIRS=/usr/include/python3.11/ -DDUNE_LOCALFEFUNCTIONS_USE_EIGEN=1 -DDUNE_PYTHON_ALLOW_GET_PIP=1 -DDUNE_ENABLE_PYTHONBINDINGS=TRUE -DBUILD_SHARED_LIBS=TRUE -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_STANDARD=20" cmake && \
  dune-common/bin/dunecontrol make

  RUN ls && cd eigengdb/autodiff && \
  cd .build/ && \
  cd python/package && \
  /dune/dune-common/build-cmake/run-in-dune-env python -m pip install . --no-deps --force-reinstall --no-compile && \
  cd / && \
  rm -rf autodiff 

    RUN cd dune && \
  git clone https://github.com/rath3t/dune-iga.git  && \
  cd dune-iga  && \
  git checkout main && \
  cd / && \
  cd dune && \
  cd .. && \
  git clone  https://github.com/ikarus-project/dune-localfefunctions.git  && \
  cd dune-localfefunctions && \
  git checkout main && \
  cd .. && \
  ./dune-common/bin/dunecontrol   --cmake-opts="-DCMAKE_CXX_FLAGS='-O3' -DPython3_EXECUTABLE=/usr/bin/python -DPython3_INCLUDE_DIRS=/usr/include/python3.11/ -DDUNE_LOCALFEFUNCTIONS_USE_EIGEN=1 -DDUNE_PYTHON_ALLOW_GET_PIP=1 -DDUNE_ENABLE_PYTHONBINDINGS=TRUE -DBUILD_SHARED_LIBS=TRUE -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_STANDARD=20" cmake && \
  ./dune-common/bin/dunecontrol make

  RUN apt-get auto-remove -y && \
  apt-get clean && \
  rm -rvf /var/lib/apt/lists/* && \
  rm -rvf /var/cache/apt/archives/* && \
  apt-get -y remove  \
  software-properties-common

ENV CMAKE_PREFIX_PATH /dune/dune-geometry/build-cmake:/dune/dune-matrix-vector/build-cmake:/dune/dune-functions/build-cmake:/dune/dune-common/build-cmake:/dune/dune-localfunctions/build-cmake:/dune/dune-alugrid/build-cmake:/dune/dune-fufem/build-cmake:/dune/dune-typetree/build-cmake:/dune/dune-uggrid/build-cmake:/dune/dune-grid/build-cmake:/dune/dune-foamgrid/build-cmake:/dune/dune-istl/build-cmake:/dune/dune-grid-glue/build-cmake:/dune/dune-iga/build-cmake:/dune/dune-vtk/build-cmake:/dune/dune-localfefunctions/build-cmake:/dune/dune-curvedgrid/build-cmake:/dune/dune-curvedgeometry/build-cmake:


ARG UID=1001
ARG GID=1001

RUN groupadd -r --gid $GID user \
 && useradd --no-log-init --create-home -g user -r --uid $UID user \
 && yes 1 | passwd user \
 && mkdir -p /etc/sudoers.d \
 && echo "user ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/user \
 && chmod 0440 /etc/sudoers.d/user

RUN chown -R $UID:$GID /dune 

# use python venv on start up
USER user
ENV VIRTUAL_ENV=/dune/dune-common/build-cmake/dune-env/

RUN python3 -m venv  $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

COPY entrypoint.sh /entrypoint.sh
USER root
RUN chmod +x /entrypoint.sh
USER user

ENTRYPOINT ["/entrypoint.sh"]

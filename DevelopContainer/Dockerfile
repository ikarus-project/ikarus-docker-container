FROM debian:bookworm-slim

MAINTAINER mueller@ibb.uni-stuttgart.de

ARG DEBIAN_FRONTEND=noninteractive
ENV CI true
EXPOSE 8000
ENV DISPLAY=:0
ENV LD_LIBRARY_PATH=/usr/lib/wsl/lib

RUN apt-get update -q -y  && apt-get -y --no-install-recommends install wget build-essential libreadline-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev

RUN   wget --no-check-certificate -cq https://www.python.org/ftp/python/3.10.9/Python-3.10.9.tar.xz && \
  tar -Jxf Python-3.10.9.tar.xz &&\
  cd Python-3.10.9 &&\
  ./configure --enable-optimizations --prefix=/usr --enable-shared &&\
  make install && \
  cd .. && \
  rm -rf Python-3.10.9 && \
  rm Python-3.10.9.tar.xz


RUN  update-alternatives --install /usr/bin/python python /usr/bin/python3.10 10

RUN apt-get -y --no-install-recommends install build-essential \
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
  gnuplot 

  RUN  python -m pip install --upgrade pip && \
  python -m pip install --no-cache-dir virtualenv \
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
  dune-common/bin/dunecontrol git checkout releases/2.9 

  RUN ls /usr/include/python3.10/
  
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

  RUN cd dune && \
  cd dune-common/cmake/modules &&\
  sed -i 's/install(FILES ${CMAKE_CURRENT_BINARY_DIR}\/${LINKDUNEPY_CMAKE_METADATA_FILE} DESTINATION python\/dune\/data)/get_filename_component(LINKDUNEPY_CMAKE_METADATA_FILE_DIR ${LINKDUNEPY_CMAKE_METADATA_FILE} DIRECTORY ) \n    install(FILES ${CMAKE_CURRENT_BINARY_DIR}\/${LINKDUNEPY_CMAKE_METADATA_FILE} DESTINATION python\/${LINKDUNEPY_CMAKE_METADATA_FILE_DIR})/g' DunePythonInstallPackage.cmake && \
  cd / && \
  cd dune && \
  git clone https://github.com/rath3t/dune-iga.git && \
  cd dune-iga  && \
  git checkout main && \
  cd / && \
  cd dune && \
  cd dune-foamgrid &&\
  git checkout master && \
  cd .. && \
  git clone https://gitlab.dune-project.org/extensions/dune-vtk.git && \
  cd dune-vtk && \
  git checkout releases/2.9 && \
  cd .. && \
  git clone https://github.com/ikarus-project/dune-localfefunctions.git && \
  cd dune-localfefunctions && \
  git checkout main && \
  cd .. && \
  ./dune-common/bin/dunecontrol   --cmake-opts="-DPython3_EXECUTABLE=/usr/bin/python -DPython3_INCLUDE_DIRS=/usr/include/python3.10/ -DDUNE_LOCALFEFUNCTIONS_USE_EIGEN=1 -DDUNE_PYTHON_ALLOW_GET_PIP=1 -DDUNE_PYTHON_VIRTUALENV_SETUP=TRUE -DDUNE_ENABLE_PYTHONBINDINGS=TRUE -DBUILD_SHARED_LIBS=TRUE -DCMAKE_BUILD_TYPE=Release -DCXX_MAX_STANDARD=20" cmake && \
  ./dune-common/bin/dunecontrol make

RUN  update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 10
RUN git clone https://github.com/dmillard/eigengdb && \
  cd eigengdb && \
  python3.10 setup.py install && \
  python3.10 bin/eigengdb_register_printers && \
  gdb -q -iex "add-auto-load-safe-path /tmp/Ikarus/.gdbinit" && \
  git clone https://github.com/autodiff/autodiff && \
  cd autodiff/ && \
  mkdir .build && \
  cd .build/ && \
  cmake .. -DAUTODIFF_BUILD_PYTHON=1 -DAUTODIFF_BUILD_EXAMPLES=0 -DAUTODIFF_BUILD_DOCS=0 -DAUTODIFF_BUILD_TESTS=0 -DAUTODIFF_PYTHON_INSTALL_PREFIX="" && \
  cmake --build . --target install --parallel 2 &&\
  cd python/package && \
  /dune/dune-common/build-cmake/run-in-dune-env python -m pip install . --no-deps --force-reinstall --no-compile && \
  cd / && \
  rm -rf autodiff && \
  apt-get auto-remove -y && \
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

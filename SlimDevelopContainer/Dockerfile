FROM debian:bookworm-slim



ARG DEBIAN_FRONTEND=noninteractive
ENV CI true
EXPOSE 8000
ENV DISPLAY=:0
ENV LD_LIBRARY_PATH=/usr/lib/wsl/lib

# WORKDIR $HOME
# RUN useradd --create-home --no-log-init --shell /bin/bash docker
# USER docker
# WORKDIR /home/docker

RUN apt-get update -q -y  && \
     apt-get update && \
   apt-get -y --no-install-recommends install build-essential \
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
  python3 \
  python3-dev \
  pip \
  gnuplot-x11 \
  curl \
  cppcheck \
  python3-pybind11 && \
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
  pip install --no-cache-dir cmakelang==0.6.13 pyyaml && \
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
  git clone https://github.com/alandefreitas/matplotplusplus.git && \
  cd matplotplusplus && \
  git checkout v1.1.0 && \
  mkdir -p build && \
  cd build && \
  cmake .. -DCMAKE_BUILD_TYPE=Release -DBUILD_EXAMPLES=OFF -DBUILD_TESTS=OFF && \
  cmake --build . --parallel 4 --config Release && \
  cmake --install . && \
  cd ~ && \
  rm -rf matplotplusplus && \
  mkdir -p dune && \
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
  git clone https://git.imp.fu-berlin.de/agnumpde/dune-matrix-vector.git && \
  git clone https://gitlab.dune-project.org/extensions/dune-grid-glue.git && \
  git clone https://git.imp.fu-berlin.de/agnumpde/dune-fufem.git && \
  dune-common/bin/dunecontrol git checkout releases/2.8 && \
  sed -i '15 i add_subdirectory("cmake/modules")' dune-fufem/CMakeLists.txt && \
  sed -i 's/set(modules "DuneFufemMacros.cmake")/set(modules "DuneFufemMacros.cmake" "AddPythonLibsFlags.cmake" "AddAdolcFlags.cmake" "AddHDF5Flags.cmake" "FindAdolc.cmake")/' dune-fufem/cmake/modules/CMakeLists.txt && \
  git clone https://github.com/rath3t/dune-iga.git && \
  cd dune-iga && \
  git checkout main && \
  cd .. && \
  git clone https://gitlab.dune-project.org/extensions/dune-vtk.git && \
  cd dune-vtk && \
  git checkout releases/2.8 && \
  cd .. && \
  ./dune-common/bin/dunecontrol cmake "-DCMAKE_BUILD_TYPE=Release" && \
  ./dune-common/bin/dunecontrol make && \
  ./dune-common/bin/dunecontrol make install && \
  cd .. && \
  rm -rf dune && \
  git clone https://github.com/dmillard/eigengdb && \
  cd eigengdb && \
  python3.10 setup.py install && \
  python3.10 bin/eigengdb_register_printers && \
  gdb -q -iex "add-auto-load-safe-path /tmp/Ikarus/.gdbinit" && \
  git clone https://github.com/autodiff/autodiff && \
  cd autodiff/ && \
  mkdir .build && \
  cd .build/ && \
  cmake .. -DAUTODIFF_BUILD_PYTHON=1 -DAUTODIFF_BUILD_EXAMPLES=0 -DAUTODIFF_BUILD_DOCS=0 -DAUTODIFF_BUILD_TESTS=0 -DAUTODIFF_PYTHON_INSTALL_PREFIX="" && \
  cmake --build . --target install --parallel 8 &&\
  cd python/package && \
  pip install . --no-deps --force-reinstall --no-compile && \
  cd / && \
  rm -rf autodiff && \
  git clone https://github.com/ikarus-project/dune-localfefunctions.git && \
  dunecontrol --cmake-opts="-DCMAKE_BUILD_TYPE=Release -DDUNE_LOCALFEFUNCTIONS_USE_EIGEN=1" cmake && \
  dunecontrol make &&   \
  dunecontrol make install && \
  rm -rf dune-localfefunctions && \
  apt-get auto-remove -y && \
  apt-get clean && \
  rm -rvf /var/lib/apt/lists/* && \
  rm -rvf /var/cache/apt/archives/* && \
  apt-get -y remove  \
  software-properties-common


CMD [ "/bin/sh" ]
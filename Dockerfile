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
  libdune-common-dev \
  libdune-geometry-dev \
  libdune-grid-dev \
  libdune-functions-dev \
  libdune-typetree-dev \
  libdune-localfunctions-dev \
  libdune-uggrid-dev \
  libdune-grid-glue-dev \
  libdune-istl-dev \
  libbenchmark-dev \
  libgtest-dev \
  libquadmath0 \
  gnuplot \
  python3 \
  python3-dev \
  pip \
  gnuplot-x11 \
  curl \
  cppcheck \
  libayatana-appindicator3-1  \
  libasound2 xvfb

RUN git clone https://github.com/gabime/spdlog.git && \
  cd spdlog && \
  git checkout v1.10.0 && \
  mkdir build && \
  cd build && \
  cmake .. -DSPDLOG_FMT_EXTERNAL=FALSE && \
  make install && \
  cd ~ && \
  rm -rf fmt && \
  cd ~ && \
  mkdir -p catch2 && \
  cd catch2 && \
  git clone https://github.com/catchorg/Catch2.git && \
  cd Catch2 && \
  git checkout v3.1.0 && \
  cmake -Bbuild -H. -DBUILD_TESTING=OFF && \
  cmake --build build/ --target install && \
  cd ~ && \
  rm -rf catch2 && \
  wget https://github.com/jgraph/drawio-desktop/releases/download/v16.5.1/drawio-amd64-16.5.1.deb && \
  dpkg -i drawio-amd64-16.5.1.deb && \
  rm drawio-amd64-16.5.1.deb && \
  pip install --no-cache-dir cmakelang==0.6.13 pyyaml && \
  pip install --no-cache-dir mkdocs && \
  pip install --no-cache-dir mkdocs-material && \
  pip install --no-cache-dir mkdocs-macros-plugin && \
  pip install --no-cache-dir mkdocs-drawio-exporter && \
  pip install --no-cache-dir mkdocs-bibtex && \
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
  git checkout v1.1.0 && \
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
  cd ~ && \
  rm -rf autodiff

RUN mkdir -p dune && \
  cd dune && \
  git clone https://gitlab.dune-project.org/extensions/dune-alugrid.git && \
  git clone https://gitlab.dune-project.org/extensions/dune-foamgrid.git && \
  git clone https://git.imp.fu-berlin.de/agnumpde/dune-matrix-vector.git && \
  git clone https://git.imp.fu-berlin.de/agnumpde/dune-fufem.git && \
  dunecontrol git checkout releases/2.8 && \
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
  dunecontrol cmake "-DCMAKE_BUILD_TYPE=Release" && \
  dunecontrol make && \
  dunecontrol make install && \
  cd .. && \
  rm -rf dune && \
  git clone https://github.com/dmillard/eigengdb && \
  cd eigengdb && \
  python3.10 setup.py install && \
  python3.10 bin/eigengdb_register_printers && \
  gdb -q -iex "add-auto-load-safe-path /tmp/Ikarus/.gdbinit" && \
  apt-get auto-remove -y && \
  apt-get clean && \
  rm -rvf /var/lib/apt/lists/* && \
  rm -rvf /var/cache/apt/archives/* && \
  apt-get -y remove  \
  software-properties-common


CMD [ "/bin/sh" ]

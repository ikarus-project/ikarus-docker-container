FROM ikarusproject/debian:latest

LABEL org.opencontainers.image.authors="mueller@ibb.uni-stuttgart.de"

ARG DEBIAN_FRONTEND=noninteractive
ENV CI true
EXPOSE 8000
ENV DISPLAY=:0
ENV LD_LIBRARY_PATH=/usr/lib/wsl/lib

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
  dune-common/bin/dunecontrol git checkout releases/2.9 

  RUN cd dune && \
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
  ./dune-common/bin/dunecontrol   --cmake-opts="-DPython3_EXECUTABLE=/usr/bin/python -DPython3_INCLUDE_DIRS=/usr/include/python3.11/ -DDUNE_LOCALFEFUNCTIONS_USE_EIGEN=1 -DDUNE_PYTHON_ALLOW_GET_PIP=1 -DDUNE_PYTHON_VIRTUALENV_SETUP=TRUE -DDUNE_ENABLE_PYTHONBINDINGS=TRUE -DBUILD_SHARED_LIBS=TRUE -DCMAKE_BUILD_TYPE=Release -DCXX_MAX_STANDARD=20" cmake && \
  ./dune-common/bin/dunecontrol make

RUN  update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 10
RUN git clone https://github.com/AngusJohnson/Clipper2.git && \
  cd Clipper2/CPP && \
  git checkout Clipper2_1.0.6 && \
  mkdir build && \
  cd build && \
  cmake .. -DCLIPPER2_TESTS=0 -DBUILD_SHARED_LIBS=ON -DCLIPPER2_EXAMPLES=0 && \
  cmake --build . --target install --parallel 2 && \
  cd / && \
  rm -rf Clipper2 && \
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

ENV CMAKE_PREFIX_PATH /dune/dune-geometry/build-cmake:/dune/dune-matrix-vector/build-cmake:/dune/dune-functions/build-cmake:/dune/dune-common/build-cmake:/dune/dune-localfunctions/build-cmake:/dune/dune-alugrid/build-cmake:/dune/dune-fufem/build-cmake:/dune/dune-typetree/build-cmake:/dune/dune-uggrid/build-cmake:/dune/dune-grid/build-cmake:/dune/dune-foamgrid/build-cmake:/dune/dune-istl/build-cmake:/dune/dune-grid-glue/build-cmake:/dune/dune-iga/build-cmake:/dune/dune-vtk/build-cmake:/dune/dune-localfefunctions/build-cmake:

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
    cmake .. -DEARCUT_BUILD_TESTS=OFF -DEARCUT_BUILD_BENCH=OFF -DEARCUT_BUILD_VIZ=OFF && \
    cmake --build . --target install

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
FROM ikarusproject/debian12:latest

LABEL maintainer=mueller@ibb.uni-stuttgart.de
#docker build --squash -t ikarusproject/dunebase-gcc:latest --build-arg ccompiler="gcc-12" --build-arg cppcompiler="g++-12"  . &> build.log
#docker build --squash -t ikarusproject/dunebase-clang:latest --build-arg ccompiler="clang-16" --build-arg cppcompiler="clang++-16"  . &> build.log
ARG DEBIAN_FRONTEND=noninteractive
ENV CI true
EXPOSE 8000
ENV DISPLAY=:0
ENV LD_LIBRARY_PATH=/usr/lib/wsl/lib

ARG ccompiler "gcc-12"
ENV C_COMPILER=${ccompiler}

ARG cppcompiler "g++-12"
ENV CPP_COMPILER=${cppcompiler}

ENV DUNE_CMAKE_FLAGS=-DCMAKE_C_COMPILER=${ccompiler} -DCMAKE_CXX_COMPILER=${cppcompiler}

RUN mkdir -p dune && \
  cd dune && \
  git clone https://gitlab.dune-project.org/core/dune-common.git && \
  git clone https://gitlab.dune-project.org/core/dune-geometry.git && \
  git clone https://gitlab.dune-project.org/core/dune-istl.git && \
  git clone https://gitlab.dune-project.org/core/dune-grid.git && \
  git clone https://gitlab.dune-project.org/extensions/dune-subgrid.git && \
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
  dune-common/bin/dunecontrol   --cmake-opts="-DCMAKE_CXX_FLAGS='-O3' -DCMAKE_C_COMPILER=${C_COMPILER} -DCMAKE_CXX_COMPILER=${CPP_COMPILER} -DPython3_EXECUTABLE=/usr/bin/python -DPython3_INCLUDE_DIRS=/usr/include/python3.11/ -DDUNE_LOCALFEFUNCTIONS_USE_EIGEN=1 -DDUNE_PYTHON_ALLOW_GET_PIP=1 -DDUNE_ENABLE_PYTHONBINDINGS=TRUE -DBUILD_SHARED_LIBS=TRUE -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_STANDARD=20" cmake && \
  dune-common/bin/dunecontrol make

ENV CMAKE_PREFIX_PATH /dune/dune-geometry/build-cmake:/dune/dune-matrix-vector/build-cmake:/dune/dune-functions/build-cmake:/dune/dune-common/build-cmake:/dune/dune-localfunctions/build-cmake:/dune/dune-alugrid/build-cmake:/dune/dune-fufem/build-cmake:/dune/dune-typetree/build-cmake:/dune/dune-uggrid/build-cmake:/dune/dune-grid/build-cmake:/dune/dune-foamgrid/build-cmake:/dune/dune-istl/build-cmake:/dune/dune-grid-glue/build-cmake:/dune/dune-iga/build-cmake:/dune/dune-vtk/build-cmake:/dune/dune-localfefunctions/build-cmake:/dune/dune-curvedgrid/build-cmake:/dune/dune-curvedgeometry/build-cmake:/dune/dune-subgrid/build-cmake:

ARG UID=1001
ARG GID=1001


RUN groupadd -r --gid $GID user \
 && useradd --no-log-init --create-home -g user -r --uid $UID user \
 && yes 1 | passwd user \
 && mkdir -p /etc/sudoers.d \
 && echo "user ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/user \
 && chmod 0440 /etc/sudoers.d/user

RUN chown  -R $UID:$GID /dune 
 
RUN cd autodiff && \
cd .build/  && \
cd python/package && \
/dune/dune-common/build-cmake/run-in-dune-env python -m pip install . --no-deps --force-reinstall --no-compile && \
cd / && \
rm -rf autodiff 
 
RUN apt-get auto-remove -y && \
apt-get clean && \
rm -rvf /var/lib/apt/lists/* && \
rm -rvf /var/cache/apt/archives/* && \
apt-get -y remove  \
software-properties-common

# use python venv on start up

ENV VIRTUAL_ENV=/dune/dune-common/build-cmake/dune-env/

#RUN python3 -m venv  $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN echo $PATH
COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh
USER $UID
ENTRYPOINT ["/entrypoint.sh"]

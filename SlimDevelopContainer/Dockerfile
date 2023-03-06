FROM debian:bookworm-slim

MAINTAINER mueller@ibb.uni-stuttgart.de

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -q -y  && \
     apt-get update && \
   apt-get -y --no-install-recommends install build-essential \
  git \
  wget \
  apt-utils \
  software-properties-common \
  gfortran \
  gcc-12 \
  g++-12 \
  cmake \
  libmetis-dev \
  pkg-config \
  liblapack-dev \
  libopenblas-dev \
  libsuitesparse-dev \
  libsuperlu-dev \
  libquadmath0 \
  libopenmpi-dev \
  python3 \
  python3-dev \
  python3-matplotlib \
  python3-mpi4py \
  python3-numpy \
  python3-pip \
  python3-pytest \
  python3-setuptools \
  python3-scipy \
  python3-venv \
  python3-vtk7 \
  python3-ufl \
  python3-wheel \
  curl \
  python3-pybind11

RUN mkdir -p dune && \
  cd dune && \
  git clone https://gitlab.dune-project.org/core/dune-common.git && \
git clone https://gitlab.dune-project.org/core/dune-geometry.git && \
git clone https://gitlab.dune-project.org/core/dune-localfunctions.git && \
git clone https://gitlab.dune-project.org/core/dune-grid.git && \
  git clone https://gitlab.dune-project.org/core/dune-istl.git && \
    git clone https://gitlab.dune-project.org/staging/dune-typetree.git && \
git clone https://gitlab.dune-project.org/extensions/dune-vtk.git && \
  git clone https://gitlab.dune-project.org/extensions/dune-foamgrid.git && \
  git clone https://gitlab.dune-project.org/extensions/dune-alugrid.git && \
  git clone https://gitlab.dune-project.org/staging/dune-functions.git && \
  dune-common/bin/dunecontrol git checkout releases/2.9 && \
  git clone https://github.com/ikarus-project/ikarus.git && \
  cd ikarus && \
  git checkout  feature/pythonBindingNew

  RUN cd dune && \
  cd dune-foamgrid &&\
  git checkout master && \
  cd .. && \
  ./dune-common/bin/dunecontrol   --cmake-opts="-DCMAKE_BUILD_TYPE=Release -DDUNE_PYTHON_ALLOW_GET_PIP=1 -DDUNE_PYTHON_VIRTUALENV_SETUP=TRUE -DDUNE_ENABLE_PYTHONBINDINGS=TRUE -DBUILD_SHARED_LIBS=TRUE" cmake && \
    ./dune-common/bin/dunecontrol make && \
  ./dune-common/bin/dunecontrol make install



RUN adduser --disabled-password --home /ikarus --uid 50000 ikarus


CMD [ "/bin/sh" ]

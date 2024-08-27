
ARG COMPILER="gcc"

FROM ikarusproject/dunebase-${COMPILER}:latest
ARG ccompiler "gcc-12"
ENV C_COMPILER=${ccompiler}

ARG cppcompiler "g++-12"
ENV CPP_COMPILER=${cppcompiler}
#docker build --squash -t ikarusproject/ikarus-dev-gcc:latest --build-arg compiler="gcc" --build-arg ccompiler="gcc-12" --build-arg cppcompiler="g++-12"  . &> build.log
#docker build --squash -t ikarusproject/ikarus-dev-clang:latest --build-arg compiler="clang" --build-arg ccompiler="clang-16" --build-arg cppcompiler="clang++-16"  . &> build.log

LABEL maintainer=mueller@ibb.uni-stuttgart.de

RUN cd dune && \
  git clone https://github.com/rath3t/dune-iga.git  && \
  cd dune-iga  && \
  git checkout main && \
  cd / && \
  cd dune && \
  git clone  https://github.com/ikarus-project/dune-localfefunctions.git && \
  cd dune-localfefunctions && \
  git checkout main && \
  cd .. && \
  ./dune-common/bin/dunecontrol --only=dune-iga,dune-localfefunctions --cmake-opts="-DCMAKE_CXX_FLAGS='-O3' -DCMAKE_C_COMPILER=${C_COMPILER} -DCMAKE_CXX_COMPILER=${CPP_COMPILER} -DPython3_EXECUTABLE=/usr/bin/python -DPython3_INCLUDE_DIRS=/usr/include/python3.11/ -DDUNE_LOCALFEFUNCTIONS_USE_EIGEN=1 -DDUNE_PYTHON_ALLOW_GET_PIP=1 -DDUNE_ENABLE_PYTHONBINDINGS=TRUE -DBUILD_SHARED_LIBS=TRUE -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_STANDARD=20" cmake && \
  ./dune-common/bin/dunecontrol --only=dune-iga,dune-localfefunctions make 


ARG compiler "gcc"

FROM ikarusproject/dunebase-${compiler}:latest
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
  ./dune-common/bin/dunecontrol --only=dune-iga,dune-localfefunctions --cmake-opts="$DUNE_MODULE_CMAKE_FLAGS" cmake && \
  ./dune-common/bin/dunecontrol --only=dune-iga,dune-localfefunctions make 

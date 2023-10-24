FROM ikarusproject/debian12:latest

MAINTAINER mueller@ibb.uni-stuttgart.de

RUN cd dune && \
  git clone https://github.com/rath3t/dune-iga.git  && \
  cd dune-iga  && \
  git checkout main && \
  cd / && \
  cd dune && \
  git clone  https://github.com/ikarus-project/dune-localfefunctions.git  && \
  cd dune-localfefunctions && \
  git checkout main && \
  cd .. && \
  ./dune-common/bin/dunecontrol --only=dune-iga,dune-localfefunctions --cmake-opts="-DCMAKE_CXX_FLAGS='-O3' -DPython3_EXECUTABLE=/usr/bin/python -DPython3_INCLUDE_DIRS=/usr/include/python3.11/ -DDUNE_LOCALFEFUNCTIONS_USE_EIGEN=1 -DDUNE_PYTHON_ALLOW_GET_PIP=1 -DDUNE_ENABLE_PYTHONBINDINGS=TRUE -DBUILD_SHARED_LIBS=TRUE -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_STANDARD=20" cmake && \
  ./dune-common/bin/dunecontrol --only=dune-iga,dune-localfefunctions make 
